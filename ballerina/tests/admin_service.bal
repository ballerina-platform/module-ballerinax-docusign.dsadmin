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

import ballerina/http;

service /management on new http:Listener(9090) {
    # Returns a list of organizations that the authenticated user belongs to.
    #
    # + mode - Specifies how to select the organizations. Valid values: - `org_admin`: Returns organizations for which the authenticated user is an admin. - `account_membership`: Returns organizations that contain an account of which the authenticated user is a member Default value: `org_admin` 
    # + return - A successful response or an error 
    resource function get v2/organizations(string? mode) returns OrganizationsResponse {
        OrganizationsResponse organizationsResponse = {
            organizations: [
                {
                    id: "organizationId",
                    defaultAccountId: accountId
                }
            ]
        };
        return organizationsResponse;
    }

    resource isolated function get v2/organizations/[string organizationId]/users(int:Signed32? 'start = (), int:Signed32? take = (), int:Signed32? end = (), string? email = (), string? email_user_name_like = (), string? status = (), string? membership_status = (), string? account_id = (), string? organization_reserved_domain_id = (), string? last_modified_since = ()) returns OrganizationUsersResponse|error {
        OrganizationUsersResponse response = {
            users: [
                {
                    id: "user1",
                    email: email
                }
            ]
        };
        return response;
    }

    resource isolated function get v2/organizations/[string organizationId]/users/profile(string? email = ()) returns UsersDrilldownResponse|error {
        UsersDrilldownResponse response = {
            users: [
                {
                    defaultAccountId: accountId
                }
            ]
        };
        return response;
    }

    resource isolated function post v2/data_redaction/accounts/[string accountId]/user(IndividualMembershipDataRedactionRequest payload) returns IndividualUserDataRedactionResponse|error {
        IndividualUserDataRedactionResponse individualUserDataRedactionResponse = {
            "id": "user1",
            status: "success"
        };
        return individualUserDataRedactionResponse;
    }

    resource function get v2/organizations/[string organizationId]/accounts/[string accountId]/permissions() returns PermissionsResponse {
        PermissionsResponse permissionsResponse = {
            permissions: [
                {
                    id: 1,
                    name: "Permission 1"
                }
            ]
        };
        return permissionsResponse;
    }

    resource function get v2/organizations/[string organizationId]/accounts/[string accountId]/groups(int:Signed32? 'start, int:Signed32? take, int:Signed32? end) returns MemberGroupsResponse {
        MemberGroupsResponse memberGroupsResponse = {
            groups: [
                {
                    id: 11,
                    name: "Group 1"
                }
            ]
        };
        return memberGroupsResponse;
    }

    resource isolated function get v2/organizations/[string organizationId]/identity_providers() returns IdentityProvidersResponse|error {
        return {};
    }

    resource isolated function get v2/organizations/[string organizationId]/exports/account_settings() returns OrganizationExportsResponse|error {
        OrganizationExportsResponse response = {
            exports: [
                {
                    id: "export1",
                    status: "success"
                }
            ]
        };
        return response;
    }

    resource isolated function post v2/organizations/[string organizationId]/exports/account_settings(OrganizationAccountsRequest payload) returns OrganizationExportResponse|error {
        OrganizationExportResponse response = {
            selectedAccounts: [
                {
                    accountId
                }
            ],
            id: accountId,
            requestor: {
                email: email
            }
        };
        return response;
    }

    resource function get v2/organizations/[string organizationId]/exports/user_list() returns OrganizationExportsResponse {
        return {
            exports: []
        };
    }

    resource isolated function delete v2/organizations/[string organizationId]/exports/user_list/[string exportId]() returns record {}|error {
        return {
            "success": true
        };
    }
}
