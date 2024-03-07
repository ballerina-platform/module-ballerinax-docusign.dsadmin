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

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    ClientHttp1Settings http1Settings?;
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings?;
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 60;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache?;
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits?;
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
|};

# Provides settings related to HTTP/1.x protocol.
public type ClientHttp1Settings record {|
    # Specifies whether to reuse a connection for multiple requests
    http:KeepAlive keepAlive = http:KEEPALIVE_AUTO;
    # The chunking behaviour of the request
    http:Chunking chunking = http:CHUNKING_AUTO;
    # Proxy server related options
    ProxyConfig proxy?;
|};

# Proxy server configurations to be used with the HTTP client endpoint.
public type ProxyConfig record {|
    # Host name of the proxy server
    string host = "";
    # Proxy server port
    int port = 0;
    # Proxy server username
    string userName = "";
    # Proxy server password
    @display {label: "", kind: "password"}
    string password = "";
|};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://account.docusign.com/oauth/auth";
|};

public type OrganizationAccountSettingsImportResponseArr OrganizationAccountSettingsImportResponse[];

#
public type OrgReportListResponse_OrgReport record {
    #
    boolean complete?;
    #
    string report_correlation_id?;
    #
    int:Signed32 site_id?;
    #
    string report_id?;
    #
    OrgReportListResponse_Requestor requestor?;
    #
    string created_on?;
    #
    int:Signed32 account_export_count?;
    #
    string url?;
    #
    string report_type_id?;
    #
    string report_date_range?;
    #
    string custom_start_date?;
    #
    string custom_end_date?;
};

#
public type OASIRR_OrganizationAccountSettingsErrorDataResponse record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
    #
    string account_name?;
    # The error number.
    string 'error?;
    #
    string error_key?;
    #
    string setting_key?;
};

public type Bulk_users_add_body record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

# Methods and objects to get account information.
public type AccountSettingsExport record {
};

# A list of accounts to close for a user.
public type DeleteMembershipsRequest record {
    # A list of accounts to close for a user.
    DeleteMembershipRequest[] accounts;
};

#
public type AddUserResponse record {
    #
    string id?;
    #
    int:Signed32 site_id?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address.
    string email?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    #
    AddUserResponseAccountProperties[] accounts?;
};

#
public type DSGroupAddRequest record {
    #
    string group_name;
    #
    string description?;
};

# Methods to import users.
public type SingleAccountUserImport record {
    #
    string id?;
    #
    string 'type?;
    #
    OrganizationImportResponseRequestor requestor?;
    #
    string created?;
    #
    string last_modified?;
    # Status.
    string status?;
    #
    int:Signed32 user_count?;
    #
    int:Signed32 processed_user_count?;
    #
    int:Signed32 added_user_count?;
    #
    int:Signed32 updated_user_count?;
    #
    int:Signed32 closed_user_count?;
    #
    int:Signed32 no_action_required_user_count?;
    #
    int:Signed32 error_count?;
    #
    int:Signed32 warning_count?;
    #
    string invalid_column_headers?;
    #
    string imports_not_found_or_not_available_for_accounts?;
    #
    string imports_failed_for_accounts?;
    #
    string imports_timed_out_for_accounts?;
    #
    string imports_not_found_or_not_available_for_sites?;
    #
    string imports_failed_for_sites?;
    #
    string imports_timed_out_for_sites?;
    #
    OrganizationImportResponseErrorRollup[] file_level_error_rollups?;
    #
    OrganizationImportResponseErrorRollup[] user_level_error_rollups?;
    #
    OrganizationImportResponseWarningRollup[] user_level_warning_rollups?;
    #
    boolean has_csv_results?;
    #
    string results_uri?;
};

# A change email request.
public type UpdateUsersEmailRequest record {
    # A list of users whose email address to change.
    UpdateUserEmailRequest[] users?;
};

# Methods to manage users in an account.
public type Users record {
};

# Information about a newly created user.
public type NewUserResponseAccountProperties record {
    # The user's unique ID.
    string id?;
    # The site ID of the account.
    int:Signed32 site_id?;
    # This object is an individual permission profile response.
    PermissionProfileResponse permission_profile?;
    # A list of groups that the user belongs to.
    MemberGroupResponse[] groups?;
    # The user's company name.
    string company_name?;
    # The job title of the user.
    string job_title?;
};

#
public type UserProductProfileDeleteRequest record {
    # The user's email address.
    string user_email?;
    # The user's unique ID.
    string user_id?;
    # A list of IDs corresponding to the products for which the user's access will be revoked.
    #
    # For example:
    #
    # `["230546a7-xxxx-xxxx-xxxx-af205d5494ad", "984800b7-xxxx-xxxx-xxxx-kt374a5922lk"]`
    string[] product_ids;
};

#
public type IndividualUserDataRedactionRequest record {
    # The ID of the user whose data you want to delete.
    string user_id?;
    # A list of accounts from which you want to delete the user's data. At least one account is required.
    MembershipDataRedactionRequest[] memberships?;
};

#
public type OETR_ErrorDetails record {
    # The error number.
    string 'error?;
    # A longer description of the error.
    string error_description?;
};

#
public type ProductPermissionProfilesRequest record {
    # A list of one or more products and their respective permissions.
    ProductPermissionProfileRequest[] product_permission_profiles;
};

# A list of users whose information you want to change.
public type UpdateUsersRequest record {
    # A list of users whose information you want to change.
    UpdateUserRequest[] users?;
};

# Results of closing accounts.
public type DeleteMembershipResponse record {
    # The ID of an account that could not be closed.
    string id?;
    # Errors.
    ErrorDetails error_details?;
};

#
public type AddDSGroupUsersResponse record {
    #
    boolean is_success?;
    #
    int:Signed32 TotalCount?;
    # A list of users.
    DSGroupUserResponse[] users?;
};

# An object describing the administrator of the cloned account.
public type AssetGroupAccountCloneTargetAccountAdmin record {
    # The email address of the target account administrator. This property is required in the request body when cloning an account.
    string email?;
    # The first name of the target account administrator. This property is required in the request body when cloning an account.
    string firstName?;
    # The last name of the target account administrator. This property is required in the request body when cloning an account.
    string lastName?;
    # The locale of the target account administrator. The locale code for the United States is `en`.
    "None"|"zh_cn"|"zh_tw"|"nl"|"en"|"fr"|"de"|"it"|"ja"|"ko"|"pt"|"pt_br"|"ru"|"es"|"pl" locale?;
};

# Information about a SAML 2.0 identity provider.
public type Saml2IdentityProviderResponse record {
    # The name of the certificate issuer.
    string issuer?;
    # A list of settings.
    SettingResponse[] settings?;
    # A list of certificates responses.
    CertificateResponse[] certificates?;
    # A list of attribute mappings.
    RequiredAttributeMappingResponse[] attribute_mappings?;
};

# Information about a list of users.
public type UsersDrilldownResponse record {
    # A list of users.
    UserDrilldownResponse[] users?;
};

# Organization list.
public type OrganizationsResponse record {
    # A list of organizations of which the  authenticated user is a member.
    OrganizationResponse[] organizations?;
};

# Enables you to specify the kind of export request.
public type OrganizationExportRequest record {
    # The type of export requested. One of:
    #
    # - `organization_domain_users_export`: All users of the reserved domains.
    # - `organization_external_memberships_export`: Users whose email address domain is *not* linked to the organization. 
    # - `organization_memberships_export`: Every user in every account in the organization. Users in multiple accounts will appear more than once.
    # - `organization_account_settings_export`: This value only applies to requests to export account settings.
    string 'type?;
    #
    OrganizationExportAccount[] accounts?;
    #
    OrganizationExportDomain[] domains?;
};

# A list of permission profiles for a given account.
public type PermissionsResponse record {
    # An array of permission profile responses.
    PermissionProfileResponse[] permissions?;
};

# The results of closing a user's account.
public type DeleteMembershipsResponse record {
    # When **true,** the request to close the accounts succeeded.
    boolean success?;
    # A list of accounts that were closed.
    DeleteMembershipResponse[] accounts?;
};

#
public type OrganizationExportTaskResponse record {
    # The unique ID of the task request.
    string id?;
    # The ID of the site the response is for.
    int:Signed32 site_id?;
    # The URL that returns the results as a CSV text stream.
    string url?;
    # The number of rows returned in the result.
    int number_rows?;
    # The size of the response in bytes.
    int size_bytes?;
    #
    OETR_ErrorDetails error_details?;
};

# Error result of attempting to change a user's email address.
public type UserUpdateResponse record {
    # The ID of the user whose email address has been updated.
    string id?;
    # The site ID.
    int:Signed32 site_id?;
    # The email address.
    string email?;
    # Errors.
    ErrorDetails error_details?;
};

# Methods to manage multi-product users in an account.
public type MultiProductUserManagement record {
    #
    string id?;
    #
    int:Signed32 site_id?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address.
    string email?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    #
    AddUserResponseAccountProperties[] accounts?;
};

#
public type MembershipDataRedactionRequest record {
    # The ID of the account from which to delete the user's data.
    string account_id?;
};

# Identifies a product and an associated permission profile.
public type ProductPermissionProfileRequest record {
    # The ID of the product. This property is required.
    string product_id;
    # The ID of the permission profile for the given product. This property is required.
    string permission_profile_id;
};

# Information about a newly created user.
public type NewUserResponse record {
    # The ID of the added user
    string id?;
    # The site ID of the added user.
    int:Signed32 site_id?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The primary email address of the user.
    string email?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # A list of accounts the user belongs to.
    NewUserResponseAccountProperties[] accounts?;
};

# Methods to import users.
public type UserImport record {
};

public type Imports_account_settings_body record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

# An ID object.
public type OrganizationSimpleIdObject record {
    # The ID.
    string id?;
};

#
public type OrganizationAccountSettingsImportResultResponse record {
    #
    string id?;
    #
    int:Signed32 site_id?;
    #
    string url?;
    #
    int number_processed_accounts?;
    #
    OASIRR_ErrorDetails error_details?;
    #
    OASIRR_OrganizationAccountSettingsErrorDataResponse[] processing_issues_by_account?;
    #
    int number_unprocessed_accounts?;
};

#
public type UserProductPermissionProfilesRequest record {
    # The email address associated with the user whose permissions you want to update. This property is required.
    string email;
    # A list of one or more products and their associated permissions.
    ProductPermissionProfileRequest[] product_permission_profiles;
};

# Information about a new user.
public type NewUserRequest record {
    # A list of accounts the user will belong to.
    NewUserRequestAccountProperties[] accounts;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address.
    string email;
    # The account ID of the user's default account.
    string default_account_id?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    #
    string selected_languages?;
    # The access code that the user needs to activate an account.
    string access_code?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # When **true,** the user's account is activated automatically.
    boolean auto_activate_memberships?;
};

# An individual new account user.
public type NewUserRequestAccountProperties record {
    # The account ID.
    string id;
    # A permission profile.
    PermissionProfileRequest permission_profile?;
    # The new user's requested groups.
    GroupRequest[] groups?;
    # The user's company name.
    string company_name?;
    # The user's job title.
    string job_title?;
};

# Results of deleting a user identity.
public type UserIdentityResponse record {
    # The ID of the result.
    string id?;
    # The ID of the identity provider.
    string provider_id?;
    # The user ID.
    string user_id?;
    # A unique ID to identify the removed user.
    string immutable_id?;
    # Errors.
    ErrorDetails error_details?;
};

# This object is an individual permission profile response.
public type PermissionProfileResponse record {
    # The ID of the permission profile.
    int id?;
    # The name of the permission profile. 
    #
    # Example: `DocuSign Sender`
    string name?;
};

# A link to a useful URL.
public type LinkResponse record {
    # The kind of linked item.
    string rel?;
    # The URL of the linked item.
    string href?;
};

# A response containing information about users.
public type OrganizationUsersResponse record {
    # A list of users.
    OrganizationUserResponse[] users?;
    #
    PagingResponseProperties paging?;
};

#
public type UserProductPermissionProfilesResponse record {
    # The ID of the user.
    string user_id?;
    # The ID of the account.
    string account_id?;
    # A list of one or more products and their respective permissions.
    ProductPermissionProfileResponse[] product_permission_profiles?;
};

# Methods for working with organizations.
public type Organization record {
};

#
public type DSGroupAndUsersResponse record {
    #
    DSGroupResponse group?;
    #
    DSGroupUsersResponse group_users?;
};

# A response about reserved domains.
public type DomainsResponse record {
    # Information about reserved domains.
    DomainResponse[] reserved_domains?;
};

# Errors.
public type ErrorDetails record {
    # The code for the error.
    string 'error?;
    # A description of the error.
    string error_description?;
};

#
public type DSGroupResponse record {
    #
    string ds_group_id?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
    #
    string source_product_name?;
    #
    string group_id?;
    #
    string group_name?;
    #
    string description?;
    #
    boolean is_admin?;
    #
    string last_modified_on?;
    #
    int:Signed32 user_count?;
    #
    int external_account_id?;
    #
    string account_name?;
};

# Methods and objects to update account settings.
public type AccountSettingsImport record {
};

#
public type OrganizationExportAccount record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
};

#
public type DSGroupUserResponse record {
    #
    string user_id?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    #
    string middle_name?;
    # Status.
    string status?;
    # Errors.
    ErrorDetails error_details?;
};

# Information about a reserved domain.
public type DomainResponse record {
    # The ID of the reserved domain.
    string id?;
    # The status of the request. One of:
    #
    # - `unknown`
    # - `pending`
    # - `active`
    # - `deactivated`
    # - `rejected`
    string status?;
    # The host name of the reserved domain.
    string host_name?;
    # A token  in form of text of the reserved domain.
    string txt_token?;
    # The identity provider ID of the reserved domain.
    string identity_provider_id?;
    # A list of settings for the reserved domain.
    SettingResponse[] settings?;
    # A list of useful links.
    LinkResponse[] links?;
};

#
public type OrganizationImportResponse record {
    #
    string id?;
    #
    string 'type?;
    #
    OrganizationImportResponseRequestor requestor?;
    #
    string created?;
    #
    string last_modified?;
    # Status.
    string status?;
    #
    int:Signed32 user_count?;
    #
    int:Signed32 processed_user_count?;
    #
    int:Signed32 added_user_count?;
    #
    int:Signed32 updated_user_count?;
    #
    int:Signed32 closed_user_count?;
    #
    int:Signed32 no_action_required_user_count?;
    #
    int:Signed32 error_count?;
    #
    int:Signed32 warning_count?;
    #
    string invalid_column_headers?;
    #
    string imports_not_found_or_not_available_for_accounts?;
    #
    string imports_failed_for_accounts?;
    #
    string imports_timed_out_for_accounts?;
    #
    string imports_not_found_or_not_available_for_sites?;
    #
    string imports_failed_for_sites?;
    #
    string imports_timed_out_for_sites?;
    #
    OrganizationImportResponseErrorRollup[] file_level_error_rollups?;
    #
    OrganizationImportResponseErrorRollup[] user_level_error_rollups?;
    #
    OrganizationImportResponseWarningRollup[] user_level_warning_rollups?;
    #
    boolean has_csv_results?;
    #
    string results_uri?;
};

#
public type OrganizationAccountRequest record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id;
};

#
public type RemoveUserProductsResponse record {
    # When **true,** indicates that the user's access to the specified products was successfully revoked.
    boolean is_success;
    # The user's email address.
    string user_email?;
    # The user's ID.
    string user_id?;
    # The results of the request to revoke product access.
    #
    # Each key in the object is the ID of a product specified in the request. Each corresponding value indicates whether the user's access for that product was successfully revoked. If successful, the value is `deleted`. Otherwise, the value describes the error that occurred.
    #
    # For example:
    # ```
    # {
    #         "230546a7-xxxx-xxxx-xxxx-af205d5494ad"": "deleted",
    #         "984800b7-xxxx-xxxx-xxxx-kt374a5922lk": "Invalid product id"
    # }
    # ```
    record {|string...;|} user_product_results;
};

# Methods to manage eSignature users in an account.
public type ESignUserManagement record {
};

#
public type AssetGroupAccountResponse record {
    # The asset group ID.
    string assetGroupId?;
    # Reserved for DocuSign.
    string assetGroupName?;
    # The ID of the account.
    string accountId?;
    # The name of the account.
    string accountName?;
    # The external account ID.
    int externalAccountId?;
    # When **true,** indicates that the account is compliant.
    boolean compliant?;
    # Reserved for DocuSign.
    int:Signed32 siteId?;
    # Reserved for DocuSign.
    string siteName?;
};

#
public type CloneErrorDetails record {
    # The error code.
    string 'error?;
    # The error description.
    string errorDescription?;
    # When **true,** indicates that the error was caused by the system. When **false,** indicates that the error was caused by the user.
    boolean isSystemError?;
};

# A key/value list of settings.
public type SettingResponse record {
    # The key of the setting.
    string 'key?;
    # The value of the setting.
    record {} value?;
    # The type of the setting. One of:
    #
    # - `unknown`
    # - `guid`
    # - `text`
    # - `integer`
    # - `boolean`
    # - `datetime`
    # - `enumeration`
    string 'type?;
};

# Information about group membership.
public type MembershipResponse record {
    # The email address.
    string email?;
    # The ID of the account.
    string account_id?;
    # The external account ID.
    string external_account_id?;
    # The name of the account.
    string account_name?;
    # When **true,**
    # this is an external account.
    boolean is_external_account?;
    # The status of the user's membership.
    string status?;
    # This object is an individual permission profile response.
    PermissionProfileResponse permission_profile?;
    # The date the user's account was created.
    string created_on?;
    # A list of groups the user is a member of in this account,
    MemberGroupResponse[] groups?;
    # When **true,**
    # the user has administration 
    # privileges on the account.
    boolean is_admin?;
};

#
public type DSGroupUsersResponse record {
    # The page number.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 page_size?;
    #
    int:Signed32 total_count?;
    # A list of users.
    DSGroupUserResponse[] users?;
};

# A list of asset group accounts.
public type AssetGroupAccountsResponse record {
    # The list of asset group accounts.
    AssetGroupAccountResponse[] assetGroupAccounts?;
};

#
public type PagingResponseProperties record {
    # The number of items in a result set (page).
    int:Signed32 result_set_size?;
    # The index position of the first result in this set.
    int:Signed32 result_set_start_position?;
    # The index position of the last result in this set.
    int:Signed32 result_set_end_position?;
    # The total number of results.
    int:Signed32 total_set_size?;
    # A URL to the next set of results. 
    string next?;
    # A URL to the previous set of results. 
    string previous?;
};

#
public type OrganizationImportResponseRequestor record {
    # The name of the requestor.
    string name?;
    # The unique ID of the requestor.
    # If `type` is `user`, this is the requestor's user ID.
    string id?;
    # The type of the requestor. One of:
    #
    # - `user`
    # - `client_app`
    string 'type?;
    # The email address of the requestor.
    string email?;
};

# Information about a user.
public type UserDrilldownResponse record {
    # The user's unique ID.
    string id?;
    # The site ID of the organization.
    int:Signed32 site_id?;
    # The site name of the account.
    string site_name?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The user's status. One of:
    #
    # - `active`
    # - `created`
    # - `closed`
    string user_status?;
    # The ID of the user's default account.
    string default_account_id?;
    # The name of the user's default account.
    string default_account_name?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    #
    string selected_languages?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # When **true,** the user has organization administration privileges.
    boolean is_organization_admin?;
    # The date the user's account was created.
    string created_on?;
    # This property has been deprecated.
    string last_login?;
    # A list of organizations that have groups that the user is a member of.
    MembershipResponse[] memberships?;
    # A list of identities associated with the user.
    UserIdentityResponse[] identities?;
    #
    boolean device_verification_enabled?;
};

#
public type OrganizationSalesforceAccountManagersResponse record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
    #
    string account_name?;
    #
    string account_type?;
    #
    OSAMR_Contact account_owner?;
    #
    OSAMR_Contact account_manager?;
    #
    OrganizationSalesforceAccountManagersResponse parent_account?;
};

# An object describing the target cloned account.
public type AssetGroupAccountCloneTargetAccount record {
    # The ID of the target account.
    string id?;
    # The name of the target account. This property is required in the request body when cloning an account.
    string name?;
    # The region of the target account. 
    #
    # **Note:** When cloning an account, you must include this property or `countryCode` in the request. If both are provided, `region` will be used.
    string region?;
    # The country code of the target account. The country code for the United States is `en`. 
    #
    # **Note:** When cloning an account, you must include this property or `region`. If both are provided, `region` will be used.
    string countryCode?;
    # The data center site of the account. This property is read-only.
    string site?;
    # An object describing the administrator of the cloned account.
    AssetGroupAccountCloneTargetAccountAdmin admin?;
};

# Methods for exporting a user list.
public type UserExport record {
};

#
public type OrganizationAccountsRequest record {
    #
    OrganizationAccountRequest[] accounts?;
};

# A group for a user to belong to.
public type GroupRequest record {
    # The ID of the group.
    int id;
    # The name of the group.
    string name?;
    # The type of group. One of:
    #
    # - `invalid`
    # - `admin_group`
    # - `everyone_group`
    # - `custom_group`
    string 'type?;
};

# And individual change of email.
public type UpdateUserEmailRequest record {
    # The ID of the users whose email address you want to change.
    string id;
    # The site ID.
    int:Signed32 site_id;
    # The new email address.
    string email;
};

# Methods to delete data for closed users.
public type DataDeletion record {
    #
    string user_id?;
    # Status.
    "unknown"|"pending"|"failure"|"success"|"already_redacted" status?;
    #
    MembershipDataRedactionResponse[] membership_results?;
};

#
public type ProductPermissionProfileResponse record {
    # The ID of the product.
    string product_id?;
    # The human-readable name of the product.
    string product_name?;
    #
    PermissionProfileResponse2_1[] permission_profiles?;
    #
    string error_message?;
};

# An object describing the status of the data deletion request for a specific account.
public type MembershipDataRedactionResponse record {
    # The ID of the account.
    string account_id?;
    # The status of the data deletion request. Valid values:
    # - `success`
    # - `pending`
    # - `failure`
    # - `already_redacted`
    "unknown"|"pending"|"failure"|"success"|"already_redacted" status?;
};

# User identity,
public type UserIdentityRequest record {
    # The ID of the identity.
    string id?;
};

# Request to delete a user's identities,
public type DeleteUserIdentityRequest record {
    # A list of identities.
    UserIdentityRequest[] identities;
};

#
public type OrganizationExportDomain record {
    #
    string domain?;
};

#
public type AddDSGroupAndUsersResponse record {
    #
    DSGroupResponse group?;
    #
    AddDSGroupUsersResponse group_users?;
};

#
public type IndividualMembershipDataRedactionRequest record {
    # The ID of the user whose data you want to delete.
    string user_id?;
};

# A response.
public type UpdateResponse record {
    # The status of the request.
    string status?;
};

#
public type IndividualUserDataRedactionResponse record {
    # The ID of the user.
    string user_id?;
    # The overall status of the data deletion request.
    "unknown"|"pending"|"failure"|"success"|"already_redacted" status?;
    # A list of objects describing the status of the deletion request for each account.
    MembershipDataRedactionResponse[] membership_results?;
};

#
public type DSGroupRequest record {
    #
    string ds_group_id;
};

#
public type OSAMR_Contact record {
    #
    string name?;
    # The email address.
    string email?;
    #
    string title?;
};

#
public type OrganizationImportResponseWarningRollup record {
    # The type of warning.
    string warning_type?;
    # The number of warnings of this type.
    int:Signed32 count?;
};

#
public type OASIRR_ErrorDetails record {
    # The error number.
    string 'error?;
    # A longer description of the error.
    string error_description?;
};

#
public type OrgReportListResponse_Requestor record {
    #
    string id?;
    #
    string name?;
};

#
public type OrganizationImportsResponse record {
    # A list of responses to user import requests.
    OrganizationImportResponse[] imports?;
};

#
public type OrgReportRequest record {
    #
    string report_type?;
    #
    string report_date_range?;
    #
    string[] account_ids?;
    #
    string custom_start_date?;
    #
    string custom_end_date?;
};

# A new user request.
public type NewAccountUserRequest record {
    # A permission profile.
    PermissionProfileRequest permission_profile?;
    # The new user's requested groups.
    GroupRequest[] groups?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address of the user.
    string email;
    # The account ID of the user's default account.
    string default_account_id?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    #
    string selected_languages?;
    # The access code that the user needs to activate an account.
    string access_code?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # When **true,** the user's account is activated automatically.
    boolean auto_activate_memberships?;
};

# A response about member groups. It contains the groups and paging information.
public type MemberGroupsResponse record {
    # A list of the responses.
    MemberGroupResponse[] groups?;
    #
    PagingResponseProperties paging?;
};

# Information about a single identity provider.
public type IdentityProviderResponse record {
    # The unique ID of the identity provider.
    string id?;
    # The human-readable name of the identity provider.
    string friendly_name?;
    # When **true,** users who use this identity provider are automatically provisioned. 
    boolean auto_provision_users?;
    # The type of the identity provider. One of:
    #
    # - `none`
    # - `saml_20`
    # - `saml_11`
    # - `saml_10`
    # - `ws_federation`
    # - `open_id_connect`
    string 'type?;
    # Information about a SAML 2.0 identity provider.
    Saml2IdentityProviderResponse saml_20?;
    # A list of useful URLs.
    LinkResponse[] links?;
};

public type Bulk_users_close_body record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

# A single attribute mapping response.
public type RequiredAttributeMappingResponse record {
    # The unique ID of the attribute.
    int:Signed32 required_attribute_id?;
    # The name of the attribute.
    string required_attribute_name?;
    # The human-readable name of the attribute.
    string required_attribute_friendly_name?;
    # The name of the substitute attribute.
    string substitute_attribute_name?;
};

# A request to update group membership.
public type UpdateMembershipRequest record {
    # The user's unique ID.
    string account_id;
    # A permission profile.
    PermissionProfileRequest permission_profile?;
    # The user's requested groups.
    GroupRequest[] groups?;
    # The user's company name.
    string company_name?;
    # The user's job title.
    string job_title?;
    # When **true,** send an activation request after the update.
    boolean send_activation?;
    # The access code that the user needs to activate an account.
    string access_code?;
};

# The results of changing a user's information.
public type UsersUpdateResponse record {
    # When **true,** the request to change user information succeeded.
    boolean success?;
    # A list of users whose email addresses have been updated.
    UserUpdateResponse[] users?;
};

# Results of deleting identities.
public type DeleteResponse record {
    # When **true,** the request succeeded.
    boolean success?;
    # A list of identities to delete.
    UserIdentityResponse[] identities?;
};

public type Bulk_users_add_body_1 record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

# Information about an individual organization.
public type OrganizationResponse record {
    # The ID of the organization.
    string id?;
    # The name of the organization.
    string name?;
    # A description of the organization.
    string description?;
    # The default account ID of the organization.
    string default_account_id?;
    # The default permission profile ID of the organization.
    int default_permission_profile_id?;
    # The date the organization's account was created.
    string created_on?;
    # The user who created the organization account.
    string created_by?;
    # The date the organization's account was last updated.
    string last_modified_on?;
    # The user who last updated the organization's account.
    string last_modified_by?;
    # A list of organization accounts.
    OrganizationAccountResponse[] accounts?;
    # A list of the organization accounts users.
    OrganizationSimpleIdObject[] users?;
    # A list of reserved domains for the organization.
    DomainResponse[] reserved_domains?;
    # A list of identity providers for the organization.
    IdentityProvidersResponse[] identity_providers?;
    # A list of links for the organization.
    LinkResponse[] links?;
};

#
public type OrganizationAccountSettingsImportRequestorResponse record {
    #
    string id?;
    #
    string 'type?;
    #
    string name?;
    # The email address.
    string email?;
};

# Methods to clone accounts.
public type AccountCloning record {
    # The list of asset group accounts.
    AssetGroupAccountResponse[] assetGroupAccounts?;
};

# And individual group responses,.
public type MemberGroupResponse record {
    # The unique ID of the group.
    int id?;
    # The name of the group.
    string name?;
    # The type of group. One of:
    #
    # - `1 - invalid`
    # - `2 - admin_group`
    # - `3 - everyone_group`
    # - `4 - custom_group`
    int 'type?;
};

# Request to change a user's information.
public type UpdateUserRequest record {
    # The user's unique ID.
    string id;
    # The site ID.
    int:Signed32 site_id;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address.
    string email?;
    # The account ID of the user's default account.
    string default_account_id?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    #
    string selected_languages?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # When **true,** the user will be required to change the account password.
    boolean force_password_change?;
    # A list of group membership requests.
    UpdateMembershipRequest[] memberships?;
    #
    boolean device_verification_enabled?;
};

#
public type ProductPermissionProfilesResponse record {
    # A list of one or more products and their respective permissions.
    ProductPermissionProfileResponse[] product_permission_profiles?;
};

# The account that is cloned.
public type AssetGroupAccountClone record {
    #
    AssetGroupAccountCloneSourceAccount sourceAccount;
    # An object describing the target cloned account.
    AssetGroupAccountCloneTargetAccount targetAccount;
    # The ID of the job that is created by the request. Use this value to retrieve information about the clone request with the [getAssetGroupAccountClone](/docs/admin-api/reference/accountprovisioning/accountcloning/getassetgroupaccountclone/) endpoint.
    string assetGroupWorkId?;
    # The ID of the asset group to which the account belongs. Use this value to retrieve information about the clone request with the [getAssetGroupAccountClone](/docs/admin-api/reference/accountprovisioning/accountcloning/getassetgroupaccountclone/) endpoint.
    string assetGroupId?;
    # The type of asset group work.
    "Undefined"|"GroupAssetFulfillment"|"AccountAssetFulfillment"|"AccountAssetClone"|"AccountAssetCreate" assetGroupWorkType?;
    # The status of the clone request. Valid values:
    # * `Pending`
    # * `Processing`
    # * `PendingError`
    # * `ProcessingError`
    # * `Completed`
    # * `Canceled`
    # * `PermanentFailure`
    "Undefined"|"Pending"|"Processing"|"PendingError"|"ProcessingError"|"Completed"|"Canceled"|"PermanentFailure" status?;
    # Reserved for DocuSign.
    string cloneRequestId?;
    # Reserved for DocuSign.
    string orderId?;
    # The number of retries.
    int:Signed32 attempts?;
    # The date that the clone request was initiated.
    string createdDate?;
    # The name of the user who initiated the clone request.
    string createdByName?;
    # The email address of the user who initiated the clone request.
    string createdByEmail?;
    # A message providing information about the clone request. If the request resulted in an error, this message includes specific information about the error.
    string message?;
    #
    CloneErrorDetails cloneProcessingFailureDetails?;
};

#
public type OrganizationExportsResponse record {
    #
    OrganizationExportResponse[] exports?;
};

#
public type OrgReportConfigurationResponse record {
    #
    boolean is_account_limit_disabled?;
    #
    boolean custom_dates_enabled?;
    #
    int:Signed32[] enabled_report_types?;
};

#
public type DSGroupListResponse record {
    # The page number.
    int:Signed32 page?;
    # The number of items per page.
    int:Signed32 page_size?;
    #
    int:Signed32 total_count?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
    #
    DSGroupResponse[] ds_groups?;
};

#
public type OrganizationExportResponse record {
    # The unique ID of this request.
    string id?;
    # The type of export requested. One of:
    #
    # - `organization_domain_users_export`: All users of the reserved domains.
    # - `organization_external_memberships_export`: Users whose email address domain is *not* linked to the organization. 
    # - `organization_memberships_export`: Every user in every account in the organization. Users in multiple accounts will appear more than once.
    # - `organization_account_settings_export`: This value only applies to requests to export account settings.
    string 'type?;
    #
    OrganizationExportRequestorResponse requestor?;
    # The time and date the request was created. This is a date in ISO 8601 format.
    #
    # Example:  `2019-03-26T19:02:09.8957715Z`
    string created?;
    # The time and date when the request was modified. This is typically the same as `created`.
    string last_modified?;
    # The time and date when the request completed. Null if the request is still in progress.
    string completed?;
    # The time and date when the request expires.
    string expires?;
    # The status of the request. One of:
    #
    # - `failed`
    # - `in_process`
    # - `queued`
    # - `completed`
    string status?;
    #
    OrgExportSelectedAccount[] selected_accounts?;
    #
    OrgExportSelectedDomain[] selected_domains?;
    # A pre-configured GET request to get the status of the export. Generally this is the same URI used to access this endpoint.
    string metadata_url?;
    # An integer between 0 to 100 (inclusive) that reports the progress of the request.
    int:Signed32 percent_completed?;
    # The number of rows returned in this request.
    int number_rows?;
    # The size of the request in bytes.
    int size_bytes?;
    # An array of results. There is one set of results for each server an account is in.
    OrganizationExportTaskResponse[] results?;
    # When **true,** the request succeeded. 
    boolean success?;
};

public type Bulk_users_update_body record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

#
public type DeleteMembershipRequest record {
    # The ID of a user's account you want to close.
    string id;
};

public type Bulk_users_update_body_1 record {
    # CSV file.
    record {byte[] fileContent; string fileName;} file\.csv;
};

# Methods to get a list of identity providers.
public type IdentityProviders record {
};

#
public type IdentityProvidersResponse record {
    #
    IdentityProviderResponse[] identity_providers?;
};

#
public type AddUserResponseAccountProperties record {
    #
    string id?;
    #
    int:Signed32 site_id?;
    # A list of one or more products and their respective permissions.
    ProductPermissionProfileResponse[] product_permission_profiles?;
    #
    DSGroupResponse[] ds_groups?;
    # The user's company name.
    string company_name?;
    # The user's job title.
    string job_title?;
};

#
public type ForceActivateMembershipRequest record {
    #
    int:Signed32 site_id;
};

# Information about users to remove from the group.
public type DSGroupUsersRemoveRequest record {
    # An array of IDs corresponding to users to remove from the group.
    string[] user_ids?;
    # An array of emails associated with users to remove from the group. **Note:** If `user_ids` is also specified, this parameter will be ignored.
    string[] user_emails?;
};

#
public type AssetGroupAccountClones record {
    # The list of asset group accounts.
    AssetGroupAccountClone[] assetGroupWorks?;
};

# Information about an account.
public type OrganizationAccountResponse record {
    # The unique ID of the  account.
    string id?;
    # The name of the account.
    string name?;
    # The external account ID.
    int external_account_id?;
    # The site ID.
    int:Signed32 site_id?;
};

#
public type OrgReportCreateResponse record {
    #
    string report_correlation_id?;
};

#
public type OrgExportSelectedAccount record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified.
    string account_id?;
};

# Methods to get a list of reserved domains.
public type ReservedDomains record {
};

#
public type NewMultiProductUserAddRequest record {
    # A list of one or more products and their respective permissions.
    ProductPermissionProfileRequest[] product_permission_profiles;
    #
    DSGroupRequest[] ds_groups?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The email address.
    string email;
    #
    string default_account_id?;
    # The language and culture of the user.
    #
    # * Chinese Simplified: `zh_CN`
    # * Chinese Traditional: `zh_TW`
    # * Dutch: `nl`
    # * English: `en`
    # * French: `fr`
    # * German: `de`
    # * Italian: `it`
    # * Japanese: `ja`
    # * Korean: `ko`
    # * Portuguese: `pt`
    # * Portuguese Brazil: `pt_BR`
    # * Russian: `ru`
    # * Spanish: `es`
    string language_culture?;
    # The access code that the user needs to activate an account.
    string access_code?;
    # The user's federated status. One of:
    #
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    string federated_status?;
    # When **true,** the user's account is activated automatically.
    boolean auto_activate_memberships?;
};

# Information about a single certificate.
public type CertificateResponse record {
    # The unique ID of the certificate.
    string id?;
    # The certificate issuer.
    string issuer?;
    # The thumbprint of the certificate.
    string thumbprint?;
    # The date when the certificate expires.
    string expiration_date?;
    # When **true,** the certificate is valid.
    boolean is_valid?;
    # A list of useful links.
    LinkResponse[] links?;
};

#
public type AssetGroupAccountCloneSourceAccount record {
    # The ID of the account to clone. This property is required in POST requests.
    string id;
    # The external account ID of the source account.
    int externalAccountId?;
    # The site the source account is on.
    string site?;
    # The name of the source account.
    string name?;
};

#
public type OrganizationExportRequestorResponse record {
    # The name of the requestor.
    string name?;
    # The unique ID of the requestor.
    # If `type` is `user`, this is the requestor's user ID.
    string id?;
    # The type of the requestor. One of:
    #
    # - `user`
    # - `client_app`
    string 'type?;
    # The email address of the requestor.
    string email?;
};

#
public type OrganizationImportResponseErrorRollup record {
    # The type of error. One of:
    #
    #
    # - `no_action_taken_user_exists`
    # - `user_added`
    # - `user_updated`
    # - `invalid_column_header`
    # - `invalid_row_data`
    # - `insufficient_row_data_found`
    # - `extra_row_data_found`
    # - `blank_username`
    # - `invalid_characters_in_username`
    # - `invalid_useremail_address`
    # - `email_domain_is_reserved`
    # - `new_name_with_existing_useremail_not_allowed`
    # - `invalid_characters_in_jobtitle`
    # - `invalid_membership_id`
    # - `membership_not_in_account`
    # - `maximum_users_exceeded`
    # - `invalid_permissionset`
    # - `user_permissionset_problems`
    # - `invalid_group`
    # - `user_group_problems`
    # - `group_and_permissionset_problems`
    # - `column_headers_missing`
    # - `invalid_csv_data_or_syntax`
    # - `invalid_characters_in_companyname`
    # - `invalid_language_code`
    # - `username_column_header_missing`
    # - `useremail_column_header_missing`
    # - `permissionset_column_header_missing`
    # - `membership_id_column_header_usage_not_permitted`
    # - `administrator_group_assignment_not_permitted`
    # - `user_awaiting_activation`
    # - `account_admin_access_denied`
    # - `invalid_characters_in_address`
    # - `permissionset_required`
    # - `apiusername_column_header_missing`
    # - `invalid_apiusername`
    # - `useremail_username_combination_exists`
    # - `permissionset_change_not_allowed`
    # - `username_language_changes_ignored_warning`
    # - `invalid_country_warning`
    # - `invalid_account_id`
    # - `invalid_autoactivate`
    # - `invalid_loginpolicy`
    # - `autoactivate_not_allowed`
    # - `membership_closed`
    # - `membership_closed_or_disabled_warning`
    # - `cannot_close_last_active_admin`
    # - `no_action_taken`
    # - `cannot_close_own_membership`
    # - `unspecified_error`
    string error_type?;
    # The number of errors of this type.
    int:Signed32 count?;
};

#
public type OrganizationAccountSettingsImportResponse record {
    #
    string created?;
    #
    string last_modified?;
    #
    string completed?;
    #
    string expires?;
    #
    int:Signed32 percent_completed?;
    #
    int number_processed_accounts?;
    #
    int number_unprocessed_accounts?;
    #
    OrganizationAccountSettingsImportResultResponse[] results?;
    #
    boolean success?;
    #
    record {|string[]...;|} skipped_settings_by_account?;
    #
    string id?;
    #
    string organization_id?;
    # Status.
    string status?;
    #
    string 'type?;
    #
    OrganizationAccountSettingsImportRequestorResponse requestor?;
};

#
public type PermissionProfileResponse2_1 record {
    # The ID of the permission profile.
    string permission_profile_id?;
    # The human-readable name of the permission profile.
    string permission_profile_name?;
};

# Information about a user.
public type OrganizationUserResponse record {
    # The user's unique ID.
    string id?;
    # The full name of the user.
    string user_name?;
    # The user's first name.
    string first_name?;
    # The user's last name.
    string last_name?;
    # The user's status. One of:
    #
    # - `active`
    # - `created`
    # - `closed`
    string user_status?;
    # The user's membership status. One of:
    #
    # - `activation_required`
    # - `activation_sent`
    # - `active`
    # - `closed`
    # - `disabled`
    string membership_status?;
    # The email address.
    string email?;
    # The date the user's account was created.
    string created_on?;
    # The date on which the user became a member of the organization.
    string membership_created_on?;
    #
    DSGroupResponse[] ds_groups?;
    #
    string membership_id?;
};

#
public type DSGroupUsersAddRequest record {
    #
    string[] user_ids;
};

#
public type OrgReportListResponse record {
    #
    OrgReportListResponse_OrgReport[] reports?;
};

# A permission profile.
public type PermissionProfileRequest record {
    # The ID of the permission profile.
    int id;
    # The name of the permission profile.
    string name?;
};

#
public type RemoveDSGroupUsersResponse record {
    #
    boolean is_success?;
    #
    DSGroupUserResponse[] failed_users?;
};

#
public type OrgExportSelectedDomain record {
    #
    string domain?;
};

public type OkNewUserResponse record {|
    *http:Ok;
    NewUserResponse body;
|};

public type OkUpdateResponse record {|
    *http:Ok;
    UpdateResponse body;
|};

public type OkAddDSGroupAndUsersResponse record {|
    *http:Ok;
    AddDSGroupAndUsersResponse body;
|};

public type OkUserProductPermissionProfilesResponse record {|
    *http:Ok;
    UserProductPermissionProfilesResponse body;
|};

public type OkOrganizationImportResponse record {|
    *http:Ok;
    OrganizationImportResponse body;
|};

public type OkAddUserResponse record {|
    *http:Ok;
    AddUserResponse body;
|};

public type OkDSGroupResponse record {|
    *http:Ok;
    DSGroupResponse body;
|};

public type OkOrganizationExportResponse record {|
    *http:Ok;
    OrganizationExportResponse body;
|};

public type OkOrganizationAccountSettingsImportResponse record {|
    *http:Ok;
    OrganizationAccountSettingsImportResponse body;
|};

public type OkIndividualUserDataRedactionResponse record {|
    *http:Ok;
    IndividualUserDataRedactionResponse body;
|};

public type OkAssetGroupAccountClone record {|
    *http:Ok;
    AssetGroupAccountClone body;
|};

public type OkUsersUpdateResponse record {|
    *http:Ok;
    UsersUpdateResponse body;
|};
