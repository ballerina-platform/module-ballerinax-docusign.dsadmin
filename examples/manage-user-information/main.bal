// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com) All Rights Reserved.
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerinax/docusign.dsadmin;
import ballerina/io;

configurable string accessToken = ?;
configurable string accountId = ?;
configurable string email = ?;

public function main() returns error? {
    dsadmin:Client docuSignClient = check new(
        {
            auth: {
                token: accessToken
            }
        },
        serviceUrl = "https://api-d.docusign.net/management"
    );

    dsadmin:OrganizationsResponse orgResponse = check docuSignClient->/v2/organizations();
    io:println("Organizations: ", orgResponse);

    dsadmin:OrganizationResponse[]? organizations = orgResponse.organizations;
    if organizations !is dsadmin:OrganizationResponse[] {
        io:println("Error: organizations not found");
        return;
    }

    dsadmin:OrganizationResponse organization = organizations[0];
    string? organizationId = organization.id;
    if organizationId == () {
        io:println("Error: organization id not found");
        return;
    }

    dsadmin:NewUserRequest newUserReq = {
        user_name: "user1",
        first_name: "name1",
        email: "user1@docusignmail.com",
        accounts: [
            {
                id: accountId,
                company_name: "Company"
            }
        ]
    };

    dsadmin:NewUserResponse newUserResponse = check docuSignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
    io:println("New user created: ", newUserResponse);

    string? userId = newUserResponse.id;
    if userId == () {
        io:println("Error: user id not found");
        return;
    }

    dsadmin:OrganizationUsersResponse userInformation = check docuSignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = email);
    io:println("User Information in the Organization: ", userInformation);
}
