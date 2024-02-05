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
import ballerina/mime;

# An API for an organization administrator to manage organizations, accounts and users
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api-d.docusign.net/management") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }

    # Returns a list of organizations that the authenticated user belongs to.
    #
    # + mode - Specifies how to select the organizations. Valid values:
    # - `org_admin`: Returns organizations for which the authenticated user is an admin.
    # - `account_membership`: Returns organizations that contain an account of which the authenticated user is a member
    # Default value: `org_admin`
    # + return - A successful response or an error 
    resource isolated function get v2/organizations(string? mode = ()) returns OrganizationsResponse|error {
        string resourcePath = string `/v2/organizations`;
        map<anydata> queryParam = {"mode": mode};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes membership data for a user on an account.
    #
    # + accountId - The ID of the account from which to delete the user's data.
    # + return - A successful response or an error 
    resource isolated function post v2/data_redaction/accounts/[string accountId]/user(IndividualMembershipDataRedactionRequest payload) returns IndividualUserDataRedactionResponse|error {
        string resourcePath = string `/v2/data_redaction/accounts/${getEncodedUri(accountId)}/user`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        IndividualUserDataRedactionResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns the list of permission profiles in an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/accounts/[string accountId]/permissions() returns PermissionsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/permissions`;
        PermissionsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Returns the list of groups in an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + 'start - Index of first item to include in the response. The default value is 0.
    # + take - Page size of the response. The default value is 20.
    # + end - Index of the last item to include in the response. Ignored if `take` parameter is specified.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/accounts/[string accountId]/groups(int:Signed32? 'start = (), int:Signed32? take = (), int:Signed32? end = ()) returns MemberGroupsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/groups`;
        map<anydata> queryParam = {"start": 'start, "take": take, "end": end};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        MemberGroupsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Returns a list of pending and completed export requests.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/user_list() returns OrganizationExportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list`;
        OrganizationExportsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Creates a user list export request.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/exports/user_list(OrganizationExportRequest payload) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrganizationExportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns a list of pending and completed account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/account_settings() returns OrganizationExportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings`;
        OrganizationExportsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Creates a  new account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/exports/account_settings(OrganizationAccountsRequest payload) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        OrganizationExportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns the results for single user list export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/user_list/[string exportId]() returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list/${getEncodedUri(exportId)}`;
        OrganizationExportResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes a single user list export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/exports/user_list/[string exportId]() returns json|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list/${getEncodedUri(exportId)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }

    # Returns the results for a single account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/account_settings/[string exportId]() returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings/${getEncodedUri(exportId)}`;
        OrganizationExportResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes a single account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/exports/account_settings/[string exportId]() returns json|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings/${getEncodedUri(exportId)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }

    # Returns the details and metadata for Bulk Account Settings Import requests in the organization.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/account_settings() returns OrganizationAccountSettingsImportResponse[]|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings`;
        OrganizationAccountSettingsImportResponse[] response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Creates a new account settings import request.
    #
    # + organizationId - The organization ID GUID.
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/account_settings(Imports_account_settings_body payload) returns OrganizationAccountSettingsImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationAccountSettingsImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns the details/metadata for a Bulk Account Settings Import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/account_settings/[string importId]() returns OrganizationAccountSettingsImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings/${getEncodedUri(importId)}`;
        OrganizationAccountSettingsImportResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes a Bulk Account Settings Import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/imports/account_settings/[string importId]() returns json|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings/${getEncodedUri(importId)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }

    # Creates a request to import new users into an account.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/add(Bulk_users_add_body payload) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/add`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Import request for adding a user to a single account within the organization.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/imports/bulk_users/add(Bulk_users_add_body_1 payload) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/imports/bulk_users/add`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Bulk updates information for existing users.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/update(Bulk_users_update_body payload) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/update`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Import request for updating users for a single account
    # within the organization.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/imports/bulk_users/update(Bulk_users_update_body_1 payload) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/imports/bulk_users/update`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Creates a request to close the accounts of existing users.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/close(Bulk_users_close_body payload) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/close`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(payload);
        request.setBodyParts(bodyParts);
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Closes external memberships.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/close_external() returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/close_external`;
        http:Request request = new;
        OrganizationImportResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Gets a list of all of the user import requests.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users() returns OrganizationImportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users`;
        OrganizationImportsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Returns the details of a single user import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users/[string importId]() returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}`;
        OrganizationImportResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes a specific user import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/imports/bulk_users/[string importId]() returns json|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}`;
        json response = check self.clientEp->delete(resourcePath);
        return response;
    }

    # Given the ID of a user import request,
    # return the CSV file that was imported.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users/[string importId]/results_csv() returns string|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}/results_csv`;
        string response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Returns the list of identity providers for an organization.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/identity_providers() returns IdentityProvidersResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/identity_providers`;
        IdentityProvidersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes data for one or more of a user's account memberships.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/data_redaction/organizations/[string organizationId]/user(IndividualUserDataRedactionRequest payload) returns IndividualUserDataRedactionResponse|error {
        string resourcePath = string `/v2/data_redaction/organizations/${getEncodedUri(organizationId)}/user`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        IndividualUserDataRedactionResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns the list of reserved domains for the organization.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/reserved_domains() returns DomainsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/reserved_domains`;
        DomainsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Updates a user's information.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/profiles(UpdateUsersRequest payload) returns UsersUpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/profiles`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UsersUpdateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Updates a user's email address.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/email_addresses(UpdateUsersEmailRequest payload) returns UsersUpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/email_addresses`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UsersUpdateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Closes a user's memberships.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/users/[string userId]/accounts(DeleteMembershipsRequest payload) returns DeleteMembershipsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/accounts`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeleteMembershipsResponse response = check self.clientEp->delete(resourcePath, request);
        return response;
    }

    # Returns information about the users in an organization.
    #
    # + organizationId - The organization ID Guid
    # + 'start - Index of first item to include in the response. The default value is 0.
    # + take - Page size of the response. The default value is 20.
    # + end - Index of the last item to include in the response. Ignored if `take` parameter is specified.
    # + email - Email address of the desired user. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    # + email_user_name_like - Selects users by pattern matching on the user's email address
    # + status - Status.
    # + membership_status - The user's membership status. One of:
    # - `activation_required`
    # - `activation_sent`
    # - `active`
    # - `closed`
    # - `disabled`
    # + account_id - Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    # + organization_reserved_domain_id - Select users that are in the specified domain. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    # + last_modified_since - Select users whose data have been modified since the date specified. `account_id` or `organization_reserved_domain_id` must be specified.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/users(int:Signed32? 'start = (), int:Signed32? take = (), int:Signed32? end = (), string? email = (), string? email_user_name_like = (), string? status = (), string? membership_status = (), string? account_id = (), string? organization_reserved_domain_id = (), string? last_modified_since = ()) returns OrganizationUsersResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users`;
        map<anydata> queryParam = {"start": 'start, "take": take, "end": end, "email": email, "email_user_name_like": email_user_name_like, "status": status, "membership_status": membership_status, "account_id": account_id, "organization_reserved_domain_id": organization_reserved_domain_id, "last_modified_since": last_modified_since};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        OrganizationUsersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Creates a new user.
    #
    # + organizationId - The organization ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users(NewUserRequest payload) returns NewUserResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        NewUserResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Activates user memberships.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + membershipId - The membership ID GUID.
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/[string userId]/memberships/[string membershipId](ForceActivateMembershipRequest payload) returns UpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/memberships/${getEncodedUri(membershipId)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UpdateResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns historical information about users with a specific email address.
    #
    # + organizationId - The organization ID Guid
    # + email - The email address associated with the users you want to retrieve.
    # **Note:** This property is required.
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/users/profile(string? email = ()) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/profile`;
        map<anydata> queryParam = {"email": email};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UsersDrilldownResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes user identities.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/users/[string userId]/identities(DeleteUserIdentityRequest payload) returns DeleteResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/identities`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DeleteResponse response = check self.clientEp->delete(resourcePath, request);
        return response;
    }

    # Adds users to an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/users(NewAccountUserRequest payload) returns NewUserResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        NewUserResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns a list of DSGroups.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + page - Start page of DSGroups.
    # + page_size - Page size of DSGroups.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/dsgroups(int:Signed32? page = (), int:Signed32? page_size = ()) returns DSGroupListResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups`;
        map<anydata> queryParam = {"page": page, "page_size": page_size};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DSGroupListResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Creates a new DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + return - A successful response or an error 
    resource isolated function post organizations/[string organizationId]/accounts/[string accountId]/dsgroups(DSGroupAddRequest payload) returns DSGroupResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        DSGroupResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Returns details about a single DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + dsGroupId - The DSGroup's ID GUID
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]() returns DSGroupResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}`;
        DSGroupResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Deletes a DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + dsGroupId - The DSGroup's GUID.
    # + return - No Content 
    resource isolated function delete organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]() returns error? {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}`;
        return self.clientEp->delete(resourcePath);
    }

    # Gets a list of users in a DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + dsGroupId - The DSGroup's GUID.
    # + page - Start page of DSGroups.
    # + page_size - Page size of DSGroups.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(int:Signed32? page = (), int:Signed32? page_size = ()) returns DSGroupAndUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        map<anydata> queryParam = {"page": page, "page_size": page_size};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        DSGroupAndUsersResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Adds a list of users to a DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + dsGroupId - The DSGroup's GUID.
    # + return - A successful response or an error 
    resource isolated function post organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(DSGroupUsersAddRequest payload) returns AddDSGroupAndUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        AddDSGroupAndUsersResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Removes a list of users from a DSGroup.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + dsGroupId - The DSGroup's GUID.
    # + return - A successful response or an error 
    resource isolated function delete organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(DSGroupUsersRemoveRequest payload) returns RemoveDSGroupUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RemoveDSGroupUsersResponse response = check self.clientEp->delete(resourcePath, request);
        return response;
    }

    # Gets products associated with the account and the available permission profiles.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles() returns ProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles`;
        ProductPermissionProfilesResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Retrieves a user's product permission profiles by user ID.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + userId - The user ID GUID.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/products/users/[string userId]/permission_profiles() returns ProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users/${getEncodedUri(userId)}/permission_profiles`;
        ProductPermissionProfilesResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Assigns permission profiles for a user by user ID.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + userId - The user ID GUID.
    # + return - A successful response or an error 
    resource isolated function post organizations/[string organizationId]/accounts/[string accountId]/products/users/[string userId]/permission_profiles(ProductPermissionProfilesRequest payload) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users/${getEncodedUri(userId)}/permission_profiles`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UserProductPermissionProfilesResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Creates and updates a multi-product user.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + return - A successful response or an error 
    resource isolated function post organizations/[string organizationId]/accounts/[string accountId]/users(NewMultiProductUserAddRequest payload) returns AddUserResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        AddUserResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Retrieves the DS profile for a user specified by email address.
    #
    # + organizationId - The organization's GUID.
    # + email - The email address of the user.
    # **Note:** This property is required.
    # + sort - When **true,** sorts the results in ascending order by account name.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/users/dsprofile(string? email = (), boolean? sort = ()) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/users/dsprofile`;
        map<anydata> queryParam = {"email": email, "sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UsersDrilldownResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Retrieves the DS profile for a user specified by ID.
    #
    # + organizationId - The organization's GUID.
    # + userId - The user ID GUID.
    # + sort - When **true,** sorts the results in ascending order by account name.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/users/[string userId]/dsprofile(boolean? sort = ()) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/dsprofile`;
        map<anydata> queryParam = {"sort": sort};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UsersDrilldownResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Revokes a user's access to one or more products.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + return - A successful response or an error 
    resource isolated function delete organizations/[string organizationId]/accounts/[string accountId]/products/users(UserProductProfileDeleteRequest payload) returns RemoveUserProductsResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        RemoveUserProductsResponse response = check self.clientEp->delete(resourcePath, request);
        return response;
    }

    # Retrieves a user's product permission profiles by email address.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + email - The email address of the user.
    # **Note:** This property is required.
    # + return - A successful response or an error 
    resource isolated function get organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles/users(string? email = ()) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles/users`;
        map<anydata> queryParam = {"email": email};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        UserProductPermissionProfilesResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Assigns permission profiles for a user by email address.
    #
    # + organizationId - The organization's GUID.
    # + accountId - The account ID GUID.
    # + return - A successful response or an error 
    resource isolated function post organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles/users(UserProductPermissionProfilesRequest payload) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles/users`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        UserProductPermissionProfilesResponse response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Get asset group accounts for an organization.
    #
    # + organizationId - The organization's GUID.
    # + compliant - When **true,** only compliant accounts are returned and account responses do not include the `compliant` field. The default value is **false.**
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/accounts(boolean? compliant = ()) returns AssetGroupAccountsResponse|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accounts`;
        map<anydata> queryParam = {"compliant": compliant};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        AssetGroupAccountsResponse response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Clone an existing DocuSign account.
    #
    # + organizationId - The organization's GUID.
    # + return - A successful response or an error 
    resource isolated function post v1/organizations/[string organizationId]/assetGroups/accountClone(AssetGroupAccountClone payload) returns AssetGroupAccountClone|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accountClone`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        AssetGroupAccountClone response = check self.clientEp->post(resourcePath, request);
        return response;
    }

    # Gets all asset group account clones for an organization.
    #
    # + organizationId - The organization's GUID.
    # + since_updated_date - Use this parameter to retrieve only account clones that were created on or after a specified date.
    # + include_details - When **true,** include additional details for the asset group account clones. The default value is **false.**
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/accountClones(string? since_updated_date = (), boolean? include_details = ()) returns AssetGroupAccountClones|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accountClones`;
        map<anydata> queryParam = {"since_updated_date": since_updated_date, "include_details": include_details};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        AssetGroupAccountClones response = check self.clientEp->get(resourcePath);
        return response;
    }

    # Gets information about a single cloned account.
    #
    # + organizationId - The organization's GUID.
    # + assetGroupId - The ID of the asset group.
    # + assetGroupWorkId - The ID of the asset group account clone request.
    # + include_details - When **true,** include additional details about the cloned account. The default value is **false.**
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/[string assetGroupId]/accountClones/[string assetGroupWorkId](boolean? include_details = ()) returns AssetGroupAccountClone|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/${getEncodedUri(assetGroupId)}/accountClones/${getEncodedUri(assetGroupWorkId)}`;
        map<anydata> queryParam = {"include_details": include_details};
        resourcePath = resourcePath + check getPathForQueryParam(queryParam);
        AssetGroupAccountClone response = check self.clientEp->get(resourcePath);
        return response;
    }
}
