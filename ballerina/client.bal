// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
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

import ballerina/data.jsondata;
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
    public isolated function init(ConnectionConfig config, string serviceUrl = "https://api.docusign.net/Management") returns error? {
        http:ClientConfiguration httpClientConfig = {auth: config.auth, httpVersion: config.httpVersion, http1Settings: config.http1Settings, http2Settings: config.http2Settings, timeout: config.timeout, forwarded: config.forwarded, followRedirects: config.followRedirects, poolConfig: config.poolConfig, cache: config.cache, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, cookieConfig: config.cookieConfig, responseLimits: config.responseLimits, secureSocket: config.secureSocket, proxy: config.proxy, socketConfig: config.socketConfig, validation: config.validation, laxDataBinding: config.laxDataBinding};
        self.clientEp = check new (serviceUrl, httpClientConfig);
    }

    # Returns a list of organizations that the authenticated user belongs to.
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations(map<string|string[]> headers = {}, *OrganizationOrganizationGetListV2Queries queries) returns OrganizationsResponse|error {
        string resourcePath = string `/v2/organizations`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes membership data for a user on an account.
    #
    # + accountId - The ID of the account from which to delete the user's data
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/data_redaction/accounts/[string accountId]/user(IndividualMembershipDataRedactionRequest payload, map<string|string[]> headers = {}) returns IndividualUserDataRedactionResponse|error {
        string resourcePath = string `/v2/data_redaction/accounts/${getEncodedUri(accountId)}/user`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns the list of permission profiles in an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/accounts/[string accountId]/permissions(map<string|string[]> headers = {}) returns PermissionsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/permissions`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Returns the list of groups in an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/accounts/[string accountId]/groups(map<string|string[]> headers = {}, *AccountAccountsGetGroupsV2Queries queries) returns MemberGroupsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/groups`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Returns a list of pending and completed export requests.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/user_list(map<string|string[]> headers = {}) returns OrganizationExportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a user list export request.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/exports/user_list(OrganizationExportRequest payload, map<string|string[]> headers = {}) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns a list of pending and completed account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/account_settings(map<string|string[]> headers = {}) returns OrganizationExportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a  new account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/exports/account_settings(OrganizationAccountsRequest payload, map<string|string[]> headers = {}) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns the results for single user list export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/user_list/[string exportId](map<string|string[]> headers = {}) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list/${getEncodedUri(exportId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes a single user list export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/exports/user_list/[string exportId](map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/user_list/${getEncodedUri(exportId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Returns the results for a single account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/exports/account_settings/[string exportId](map<string|string[]> headers = {}) returns OrganizationExportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings/${getEncodedUri(exportId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes a single account settings export request.
    #
    # + organizationId - The organization ID Guid
    # + exportId - The export ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/exports/account_settings/[string exportId](map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/exports/account_settings/${getEncodedUri(exportId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Returns the details and metadata for Bulk Account Settings Import requests in the organization.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/account_settings(map<string|string[]> headers = {}) returns OrganizationAccountSettingsImportResponse[]|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a new account settings import request.
    #
    # + organizationId - The organization ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/account_settings(ImportsAccountSettingsBody payload, map<string|string[]> headers = {}) returns OrganizationAccountSettingsImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns the details/metadata for a Bulk Account Settings Import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/account_settings/[string importId](map<string|string[]> headers = {}) returns OrganizationAccountSettingsImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings/${getEncodedUri(importId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes a Bulk Account Settings Import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/imports/account_settings/[string importId](map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/account_settings/${getEncodedUri(importId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Creates a request to import new users into an account.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/add(BulkUsersAddBody payload, map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/add`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Import request for adding a user to a single account within the organization.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/imports/bulk_users/add(BulkUsersAddBody1 payload, map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/imports/bulk_users/add`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Bulk updates information for existing users.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/update(BulkUsersUpdateBody payload, map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/update`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Import request for updating users for a single account
    # within the organization.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/imports/bulk_users/update(BulkUsersUpdateBody1 payload, map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/imports/bulk_users/update`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Creates a request to close the accounts of existing users.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/close(BulkUsersCloseBody payload, map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/close`;
        http:Request request = new;
        mime:Entity[] bodyParts = check createBodyParts(check jsondata:toJson(payload).ensureType());
        request.setBodyParts(bodyParts);
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Closes external memberships.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/imports/bulk_users/close_external(map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/close_external`;
        http:Request request = new;
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Gets a list of all of the user import requests.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users(map<string|string[]> headers = {}) returns OrganizationImportsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Returns the details of a single user import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users/[string importId](map<string|string[]> headers = {}) returns OrganizationImportResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes a specific user import request.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/imports/bulk_users/[string importId](map<string|string[]> headers = {}) returns record {}|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Given the ID of a user import request,
    # return the CSV file that was imported.
    #
    # + organizationId - The organization ID Guid
    # + importId - The import ID GUID for the request
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/imports/bulk_users/[string importId]/results_csv(map<string|string[]> headers = {}) returns string|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/imports/bulk_users/${getEncodedUri(importId)}/results_csv`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Returns the list of identity providers for an organization.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/identity_providers(map<string|string[]> headers = {}) returns IdentityProvidersResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/identity_providers`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes data for one or more of a user's account memberships.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/data_redaction/organizations/[string organizationId]/user(IndividualUserDataRedactionRequest payload, map<string|string[]> headers = {}) returns IndividualUserDataRedactionResponse|error {
        string resourcePath = string `/v2/data_redaction/organizations/${getEncodedUri(organizationId)}/user`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns the list of reserved domains for the organization.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/reserved_domains(map<string|string[]> headers = {}) returns DomainsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/reserved_domains`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Updates a user's information.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/profiles(UpdateUsersRequest payload, map<string|string[]> headers = {}) returns UsersUpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/profiles`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Updates a user's email address.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/email_addresses(UpdateUsersEmailRequest payload, map<string|string[]> headers = {}) returns UsersUpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/email_addresses`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Closes a user's memberships.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/users/[string userId]/accounts(DeleteMembershipsRequest payload, map<string|string[]> headers = {}) returns DeleteMembershipsResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/accounts`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Returns information about the users in an organization.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/users(map<string|string[]> headers = {}, *OrganizationUserOrganizationUsersGetV2Queries queries) returns OrganizationUsersResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a new user.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users(NewUserRequest payload, map<string|string[]> headers = {}) returns NewUserResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Activates user memberships.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + membershipId - The membership ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/users/[string userId]/memberships/[string membershipId](ForceActivateMembershipRequest payload, map<string|string[]> headers = {}) returns UpdateResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/memberships/${getEncodedUri(membershipId)}`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns historical information about users with a specific email address.
    #
    # + organizationId - The organization ID Guid
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2/organizations/[string organizationId]/users/profile(map<string|string[]> headers = {}, *OrganizationUserOrganizationUsersGetProfileV2Queries queries) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/profile`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes user identities.
    #
    # + organizationId - The organization ID Guid
    # + userId - The user ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2/organizations/[string organizationId]/users/[string userId]/identities(DeleteUserIdentityRequest payload, map<string|string[]> headers = {}) returns DeleteResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/identities`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Adds users to an account.
    #
    # + organizationId - The organization ID Guid
    # + accountId - The account ID Guid
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2/organizations/[string organizationId]/accounts/[string accountId]/users(NewAccountUserRequest payload, map<string|string[]> headers = {}) returns NewUserResponse|error {
        string resourcePath = string `/v2/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns a list of DSGroups.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups(map<string|string[]> headers = {}, *DocuSignGroupsv21GetDSGroupsV21Queries queries) returns DSGroupListResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Creates a new DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups(DSGroupAddRequest payload, map<string|string[]> headers = {}) returns DSGroupResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Returns details about a single DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + dsGroupId - The DSGroup's ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId](map<string|string[]> headers = {}) returns DSGroupResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Deletes a DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + dsGroupId - The DSGroup's GUID
    # + headers - Headers to be sent with the request 
    # + return - No Content 
    resource isolated function delete v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId](map<string|string[]> headers = {}) returns error? {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}`;
        return self.clientEp->delete(resourcePath, headers = headers);
    }

    # Gets a list of users in a DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + dsGroupId - The DSGroup's GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(map<string|string[]> headers = {}, *DocuSignGroupsv21GetDSGroupUsersV21Queries queries) returns DSGroupAndUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Adds a list of users to a DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + dsGroupId - The DSGroup's GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(DSGroupUsersAddRequest payload, map<string|string[]> headers = {}) returns AddDSGroupAndUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Removes a list of users from a DSGroup.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + dsGroupId - The DSGroup's GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2\.1/organizations/[string organizationId]/accounts/[string accountId]/dsgroups/[string dsGroupId]/users(DSGroupUsersRemoveRequest payload, map<string|string[]> headers = {}) returns RemoveDSGroupUsersResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/dsgroups/${getEncodedUri(dsGroupId)}/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Gets products associated with the account and the available permission profiles.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles(map<string|string[]> headers = {}) returns ProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieves a user's product permission profiles by user ID.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + userId - The user ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/users/[string userId]/permission_profiles(map<string|string[]> headers = {}) returns ProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users/${getEncodedUri(userId)}/permission_profiles`;
        return self.clientEp->get(resourcePath, headers);
    }

    # Assigns permission profiles for a user by user ID.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + userId - The user ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/users/[string userId]/permission_profiles(ProductPermissionProfilesRequest payload, map<string|string[]> headers = {}) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users/${getEncodedUri(userId)}/permission_profiles`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Creates and updates a multi-product user.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2\.1/organizations/[string organizationId]/accounts/[string accountId]/users(NewMultiProductUserAddRequest payload, map<string|string[]> headers = {}) returns AddUserResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Retrieves the DS profile for a user specified by email address.
    #
    # + organizationId - The organization's GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/users/dsprofile(map<string|string[]> headers = {}, *OrganizationUserOrganizationUsersGetDSProfilesQueries queries) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/users/dsprofile`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Retrieves the DS profile for a user specified by ID.
    #
    # + organizationId - The organization's GUID
    # + userId - The user ID GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/users/[string userId]/dsprofile(map<string|string[]> headers = {}, *OrganizationUserOrganizationUsersGetDSProfileByUserIdQueries queries) returns UsersDrilldownResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/users/${getEncodedUri(userId)}/dsprofile`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Revokes a user's access to one or more products.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function delete v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/users(UserProductProfileDeleteRequest payload, map<string|string[]> headers = {}) returns RemoveUserProductsResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->delete(resourcePath, request, headers);
    }

    # Retrieves a user's product permission profiles by email address.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles/users(map<string|string[]> headers = {}, *OrganizationProductPermissionProfileGetUserProductPermissionProfilesByEmailQueries queries) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles/users`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Assigns permission profiles for a user by email address.
    #
    # + organizationId - The organization's GUID
    # + accountId - The account ID GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v2\.1/organizations/[string organizationId]/accounts/[string accountId]/products/permission_profiles/users(UserProductPermissionProfilesRequest payload, map<string|string[]> headers = {}) returns UserProductPermissionProfilesResponse|error {
        string resourcePath = string `/v2.1/organizations/${getEncodedUri(organizationId)}/accounts/${getEncodedUri(accountId)}/products/permission_profiles/users`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Get asset group accounts for an organization.
    #
    # + organizationId - The organization's GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/accounts(map<string|string[]> headers = {}, *OrganizationProvisionAssetGroupGetAssetGroupAccountsByOrgQueries queries) returns AssetGroupAccountsResponse|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accounts`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Clone an existing DocuSign account.
    #
    # + organizationId - The organization's GUID
    # + headers - Headers to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function post v1/organizations/[string organizationId]/assetGroups/accountClone(AssetGroupAccountClone payload, map<string|string[]> headers = {}) returns AssetGroupAccountClone|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accountClone`;
        http:Request request = new;
        json jsonBody = jsondata:toJson(payload);
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # Gets all asset group account clones for an organization.
    #
    # + organizationId - The organization's GUID
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/accountClones(map<string|string[]> headers = {}, *OrganizationProvisionAssetGroupGetAssetGroupAccountClonesByOrgIdQueries queries) returns AssetGroupAccountClones|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/accountClones`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }

    # Gets information about a single cloned account.
    #
    # + organizationId - The organization's GUID
    # + assetGroupId - The ID of the asset group
    # + assetGroupWorkId - The ID of the asset group account clone request
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - A successful response or an error 
    resource isolated function get v1/organizations/[string organizationId]/assetGroups/[string assetGroupId]/accountClones/[string assetGroupWorkId](map<string|string[]> headers = {}, *OrganizationProvisionAssetGroupGetAssetGroupAccountCloneQueries queries) returns AssetGroupAccountClone|error {
        string resourcePath = string `/v1/organizations/${getEncodedUri(organizationId)}/assetGroups/${getEncodedUri(assetGroupId)}/accountClones/${getEncodedUri(assetGroupWorkId)}`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        return self.clientEp->get(resourcePath, headers);
    }
}
