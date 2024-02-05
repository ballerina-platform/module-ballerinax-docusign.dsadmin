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

import ballerina/test;
import ballerina/os;

Client docuSignClient = test:mock(Client);

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

configurable string accessToken = ?;
configurable string email = ?;
configurable string accountId = ?;

@test:BeforeSuite
function initializeClientsForDocuSignServer () returns error? {
    if isTestOnLiveServer {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    token: os:getEnv("ACCESS_TOKEN")
                }
            },
            serviceUrl = "https://api-d.docusign.net/management/"
        );
    } else {
        docuSignClient = check new(
            {
                timeout: 10000,
                auth: {
                    token: accessToken
                }
            },
            serviceUrl = "http://localhost:9090/management"
        );
    }
}

@test:Config {
    groups: ["account"]
}
function testGetOrganizations() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    test:assertNotEquals(response.organizations, ());
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    test:assertEquals(organizations[0].default_account_id , accountId);
}

@test:Config {
    groups: ["account"]
}
function testGetUsersInOrganization() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    OrganizationUsersResponse organizationResponse = check docuSignClient->/v2/organizations/[organizationId]/users(email=email);
    OrganizationUserResponse[]? organizationUsers = organizationResponse.users;
    if organizationUsers is () {
        return error("Users not found");
    }
    test:assertEquals(organizationUsers[0].email, email);
}

@test:Config {
    groups: ["account"]
}
function testGetPermissions() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    PermissionsResponse permissionResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/permissions();
    PermissionProfileResponse[]? permissions = permissionResponse.permissions;
    if permissions is () {
        return error("Permissions not found");
    }
    test:assertNotEquals(permissions.length(), 0);
}

@test:Config {
    groups: ["account"]
}
function testGetExportRequests() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    OrganizationExportsResponse expectedRes = {
        exports: []
    };
    OrganizationExportsResponse exportResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/user_list();
    test:assertEquals(exportResponse, expectedRes);
}

@test:Config {
    groups: ["account"]
}
function testGetUserInfo() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    UsersDrilldownResponse exportResponse = check docuSignClient->/v2/organizations/[organizationId]/users/profile(email = email);
    UserDrilldownResponse[]? users = exportResponse.users;
    if users is () {
        return error("Users not found");
    }
    test:assertEquals(users[0].default_account_id, accountId);
}

@test:Config {
    groups: ["account"]
}
function testGetMemberGroups() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    MemberGroupsResponse memberGroupResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/groups();
    test:assertNotEquals((<MemberGroupResponse[]>memberGroupResponse.groups).length(), 0);
}

@test:Config {
    groups: ["account"]
}
function testGetIdentityProviders() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    IdentityProvidersResponse identityProviders = check docuSignClient->/v2/organizations/[organizationId]/identity_providers();
    test:assertEquals(identityProviders, {});
}

@test:Config {
    groups: ["account"]
}
function testGetAccountSettingsExport() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    OrganizationExportsResponse getExportResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/account_settings();
    OrganizationExportResponse[] exports = <OrganizationExportResponse[]>getExportResponse.exports;
    test:assertNotEquals(exports.length(), 0);
}

@test:Config {
    groups: ["account"]
}
function testCreateAndDeleteAccountSettingsExport() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    OrganizationExportResponse exportResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/account_settings.post({
        accounts: [
            {
                account_id: accountId
            }
        ]
    });
    OrganizationExportRequestorResponse exportRes = <OrganizationExportRequestorResponse>exportResponse.requestor;
    test:assertEquals(exportRes.email, email);

    json deleteResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/user_list/[<string>exportResponse.id].delete();
    test:assertEquals(deleteResponse.success, true);
}

@test:Config {
    groups: ["account"]
}
function testGetAccountSettingExport() returns error? {
    OrganizationsResponse response = check docuSignClient->/v2/organizations();
    OrganizationResponse[]? organizations = response.organizations;
    if organizations is () {
        return error("Organizations not found");
    }
    OrganizationResponse organization = organizations[0];
    string organizationId = <string>organization.id;
    OrganizationExportResponse exportResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/account_settings.post({
        accounts: [
            {
                account_id: accountId
            }
        ]
    });
    OrganizationExportRequestorResponse exportRes = <OrganizationExportRequestorResponse>exportResponse.requestor;
    test:assertEquals(exportRes.email, email);

    OrganizationExportsResponse getResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/account_settings();
    test:assertNotEquals(getResponse.exports, ());
    
    json deleteResponse = check docuSignClient->/v2/organizations/[organizationId]/exports/user_list/[<string>exportResponse.id].delete();
    test:assertEquals(deleteResponse.success, true);
}
