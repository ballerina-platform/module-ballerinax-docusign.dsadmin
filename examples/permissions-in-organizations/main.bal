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

public function main() returns error? {
    dsadmin:Client docusignClient = check new (
        {
            auth: {
                token: accessToken
            }
        },
        serviceUrl = "https://api-d.docusign.net/management"
    );

    dsadmin:OrganizationsResponse orgResponse = check docusignClient->/v2/organizations();
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
        io:println("Error: ", orgResponse);
        return;
    }

    dsadmin:OrganizationResponse organization = organizations[0];
    string? organizationId = organization.id;
    if organizationId == () {
        io:println("Error: ", organization);
        return;
    }
    
    dsadmin:NewUserResponse newUserResp = check docusignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
    io:println("New user created: ", newUserResp);

    dsadmin:OrganizationUsersResponse userInformation = check docusignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = "user1@docusignmail.com");
    io:println("User Information in the Organization: ", userInformation);

    dsadmin:PermissionsResponse permissionsResponse = check docusignClient->/v2/organizations/[organizationId]/accounts/[accountId]/permissions();
    io:println("Permission Profiles: ", permissionsResponse);

    dsadmin:MemberGroupsResponse groupsResponse = check docusignClient->/v2/organizations/[organizationId]/accounts/[accountId]/groups();
    io:println("Groups: ", groupsResponse);
}

function printOrganizations(dsadmin:OrganizationResponse[]? organizations) {
    if organizations is dsadmin:OrganizationResponse[] {
        io:println("Organizations:");
        foreach var org in organizations {
            io:println("  ID: ", org.id, ", Name: ", org.name);
        }
    } else {
        io:println("Error fetching organizations");
    }
}
