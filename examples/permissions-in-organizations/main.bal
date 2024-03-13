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

import ballerina/io;
import ballerina/os;
import ballerinax/docusign.dsadmin;

configurable string clientId = os:getEnv("CLIENT_ID");
configurable string clientSecret = os:getEnv("CLIENT_SECRET");
configurable string refreshToken = os:getEnv("REFRESH_TOKEN");
configurable string refreshUrl = os:getEnv("REFRESH_URL");
configurable string accountId = os:getEnv("ACCOUNT_ID");
configurable string email = os:getEnv("EMAIL");
configurable string serviceUrl = os:getEnv("SERVICE_URL");

public function main() returns error? {
    dsadmin:Client docuSignClient = check new (
        serviceUrl,
        {
            auth: {
                clientId,
                clientSecret,
                refreshToken,
                refreshUrl
            }
        }
    );

    dsadmin:OrganizationsResponse orgResponse = check docuSignClient->/v2/organizations();
    io:println("Organizations: ", orgResponse);

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

    dsadmin:OrganizationResponse[]? organizations = orgResponse.organizations;
    if organizations !is dsadmin:OrganizationResponse[] {
        return error("Organizations are not found");
    }

    dsadmin:OrganizationResponse organization = organizations[0];
    string? organizationId = organization.id;
    if organizationId is () {
        return error("Organization id not found");
    }

    dsadmin:NewUserResponse newUserResp = check docuSignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
    io:println("New user created: ", newUserResp);

    dsadmin:OrganizationUsersResponse userInformation = check docuSignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = email);
    io:println("User Information in the Organization: ", userInformation);

    dsadmin:PermissionsResponse permissionsResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/permissions();
    io:println("Permission Profiles: ", permissionsResponse);

    dsadmin:MemberGroupsResponse groupsResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/groups();
    io:println("Groups: ", groupsResponse);
}
