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

# A list of accounts to close for a user
public type DeleteMembershipsRequest record {
    # A list of accounts to close for a user
    DeleteMembershipRequest[] accounts;
};

public type AddUserResponse record {
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    string id?;
    AddUserResponseAccountProperties[] accounts?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The email address
    string email?;
};

public type DSGroupAddRequest record {
    @jsondata:Name {value: "group_name"}
    string groupName;
    string description?;
};

# A change email request
public type UpdateUsersEmailRequest record {
    # A list of users whose email address to change
    UpdateUserEmailRequest[] users?;
};

# Information about a newly created user
public type NewUserResponseAccountProperties record {
    # The user's company name
    @jsondata:Name {value: "company_name"}
    string companyName?;
    # The site ID of the account
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # A list of groups that the user belongs to
    MemberGroupResponse[] groups?;
    # The user's unique ID
    string id?;
    @jsondata:Name {value: "permission_profile"}
    PermissionProfileResponse permissionProfile?;
    # The job title of the user
    @jsondata:Name {value: "job_title"}
    string jobTitle?;
};

public type UserProductProfileDeleteRequest record {
    # The user's email address
    @jsondata:Name {value: "user_email"}
    string userEmail?;
    # A list of IDs corresponding to the products for which the user's access will be revoked.
    # 
    # For example:
    # 
    # `["230546a7-xxxx-xxxx-xxxx-af205d5494ad", "984800b7-xxxx-xxxx-xxxx-kt374a5922lk"]`
    @jsondata:Name {value: "product_ids"}
    string[] productIds;
    # The user's unique ID
    @jsondata:Name {value: "user_id"}
    string userId?;
};

public type IndividualUserDataRedactionRequest record {
    # The ID of the user whose data you want to delete
    @jsondata:Name {value: "user_id"}
    string userId?;
    # A list of accounts from which you want to delete the user's data. At least one account is required
    MembershipDataRedactionRequest[] memberships?;
};

public type ProductPermissionProfilesRequest record {
    # A list of one or more products and their respective permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileRequest[] productPermissionProfiles;
};

# Represents the Queries record for the operation: OrganizationProvisionAssetGroup_GetAssetGroupAccountClonesByOrgId
public type OrganizationProvisionAssetGroupGetAssetGroupAccountClonesByOrgIdQueries record {
    # Use this parameter to retrieve only account clones that were created on or after a specified date
    @http:Query {name: "since_updated_date"}
    string sinceUpdatedDate?;
    # When **true,** include additional details for the asset group account clones. The default value is **false.**
    @http:Query {name: "include_details"}
    boolean includeDetails?;
};

# A list of users whose information you want to change
public type UpdateUsersRequest record {
    # A list of users whose information you want to change
    UpdateUserRequest[] users?;
};

# Provides a set of configurations for controlling the behaviours when communicating with a remote HTTP endpoint.
@display {label: "Connection Config"}
public type ConnectionConfig record {|
    # Configurations related to client authentication
    http:BearerTokenConfig|OAuth2RefreshTokenGrantConfig auth;
    # The HTTP version understood by the client
    http:HttpVersion httpVersion = http:HTTP_2_0;
    # Configurations related to HTTP/1.x protocol
    http:ClientHttp1Settings http1Settings = {};
    # Configurations related to HTTP/2 protocol
    http:ClientHttp2Settings http2Settings = {};
    # The maximum time to wait (in seconds) for a response before closing the connection
    decimal timeout = 30;
    # The choice of setting `forwarded`/`x-forwarded` header
    string forwarded = "disable";
    # Configurations associated with Redirection
    http:FollowRedirects followRedirects?;
    # Configurations associated with request pooling
    http:PoolConfiguration poolConfig?;
    # HTTP caching related configurations
    http:CacheConfig cache = {};
    # Specifies the way of handling compression (`accept-encoding`) header
    http:Compression compression = http:COMPRESSION_AUTO;
    # Configurations associated with the behaviour of the Circuit Breaker
    http:CircuitBreakerConfig circuitBreaker?;
    # Configurations associated with retrying
    http:RetryConfig retryConfig?;
    # Configurations associated with cookies
    http:CookieConfig cookieConfig?;
    # Configurations associated with inbound response size limits
    http:ResponseLimitConfigs responseLimits = {};
    # SSL/TLS-related options
    http:ClientSecureSocket secureSocket?;
    # Proxy server related options
    http:ProxyConfig proxy?;
    # Provides settings related to client socket configuration
    http:ClientSocketConfig socketConfig = {};
    # Enables the inbound payload validation functionality which provided by the constraint package. Enabled by default
    boolean validation = true;
    # Enables relaxed data binding on the client side. When enabled, `nil` values are treated as optional, 
    # and absent fields are handled as `nilable` types. Enabled by default.
    boolean laxDataBinding = true;
|};

# Results of closing accounts
public type DeleteMembershipResponse record {
    @jsondata:Name {value: "error_details"}
    ErrorDetails errorDetails?;
    # The ID of an account that could not be closed
    string id?;
};

public type AddDSGroupUsersResponse record {
    @jsondata:Name {value: "TotalCount"}
    int:Signed32 totalCount?;
    @jsondata:Name {value: "is_success"}
    boolean isSuccess?;
    # A list of users
    DSGroupUserResponse[] users?;
};

# An object describing the administrator of the cloned account
public type AssetGroupAccountCloneTargetAccountAdmin record {
    # The first name of the target account administrator. This property is required in the request body when cloning an account
    string firstName?;
    # The last name of the target account administrator. This property is required in the request body when cloning an account
    string lastName?;
    # The locale of the target account administrator. The locale code for the United States is `en`
    "None"|"zh_cn"|"zh_tw"|"nl"|"en"|"fr"|"de"|"it"|"ja"|"ko"|"pt"|"pt_br"|"ru"|"es"|"pl" locale?;
    # The email address of the target account administrator. This property is required in the request body when cloning an account
    string email?;
};

# Information about a SAML 2.0 identity provider
public type Saml2IdentityProviderResponse record {
    # A list of settings
    SettingResponse[] settings?;
    # A list of certificates responses
    CertificateResponse[] certificates?;
    # A list of attribute mappings
    @jsondata:Name {value: "attribute_mappings"}
    RequiredAttributeMappingResponse[] attributeMappings?;
    # The name of the certificate issuer
    string issuer?;
};

# Information about a list of users
public type UsersDrilldownResponse record {
    # A list of users
    UserDrilldownResponse[] users?;
};

# Organization list
public type OrganizationsResponse record {
    # A list of organizations of which the  authenticated user is a member
    OrganizationResponse[] organizations?;
};

# Enables you to specify the kind of export request
public type OrganizationExportRequest record {
    OrganizationExportDomain[] domains?;
    OrganizationExportAccount[] accounts?;
    # The type of export requested. One of:
    # 
    # - `organization_domain_users_export`: All users of the reserved domains.
    # - `organization_external_memberships_export`: Users whose email address domain is *not* linked to the organization. 
    # - `organization_memberships_export`: Every user in every account in the organization. Users in multiple accounts will appear more than once.
    # - `organization_account_settings_export`: This value only applies to requests to export account settings
    string 'type?;
};

# A list of permission profiles for a given account
public type PermissionsResponse record {
    # An array of permission profile responses
    PermissionProfileResponse[] permissions?;
};

# The results of closing a user's account
public type DeleteMembershipsResponse record {
    # When **true,** the request to close the accounts succeeded
    boolean success?;
    # A list of accounts that were closed
    DeleteMembershipResponse[] accounts?;
};

public type OrganizationExportTaskResponse record {
    # The size of the response in bytes
    @jsondata:Name {value: "size_bytes"}
    int sizeBytes?;
    # The number of rows returned in the result
    @jsondata:Name {value: "number_rows"}
    int numberRows?;
    @jsondata:Name {value: "error_details"}
    OETRErrorDetails errorDetails?;
    # The ID of the site the response is for
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The unique ID of the task request
    string id?;
    # The URL that returns the results as a CSV text stream
    string url?;
};

# Error result of attempting to change a user's email address
public type UserUpdateResponse record {
    @jsondata:Name {value: "error_details"}
    ErrorDetails errorDetails?;
    # The site ID
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The ID of the user whose email address has been updated
    string id?;
    # The email address
    string email?;
};

public type MembershipDataRedactionRequest record {
    # The ID of the account from which to delete the user's data
    @jsondata:Name {value: "account_id"}
    string accountId?;
};

# Identifies a product and an associated permission profile
public type ProductPermissionProfileRequest record {
    # The ID of the permission profile for the given product. This property is required
    @jsondata:Name {value: "permission_profile_id"}
    string permissionProfileId;
    # The ID of the product. This property is required
    @jsondata:Name {value: "product_id"}
    string productId;
};

# Information about a newly created user
public type NewUserResponse record {
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # The site ID of the added user
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # The ID of the added user
    string id?;
    # A list of accounts the user belongs to
    NewUserResponseAccountProperties[] accounts?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The primary email address of the user
    string email?;
};

# An ID object
public type OrganizationSimpleIdObject record {
    # The ID
    string id?;
};

public type OrganizationAccountSettingsImportResultResponse record {
    @jsondata:Name {value: "error_details"}
    OASIRRErrorDetails errorDetails?;
    @jsondata:Name {value: "processing_issues_by_account"}
    OASIRROrganizationAccountSettingsErrorDataResponse[] processingIssuesByAccount?;
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    @jsondata:Name {value: "number_processed_accounts"}
    int numberProcessedAccounts?;
    string id?;
    string url?;
    @jsondata:Name {value: "number_unprocessed_accounts"}
    int numberUnprocessedAccounts?;
};

public type UserProductPermissionProfilesRequest record {
    # A list of one or more products and their associated permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileRequest[] productPermissionProfiles;
    # The email address associated with the user whose permissions you want to update. This property is required
    string email;
};

# Information about a new user
public type NewUserRequest record {
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # The access code that the user needs to activate an account
    @jsondata:Name {value: "access_code"}
    string accessCode?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # When **true,** the user's account is activated automatically
    @jsondata:Name {value: "auto_activate_memberships"}
    boolean autoActivateMemberships?;
    # The account ID of the user's default account
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # A list of accounts the user will belong to
    NewUserRequestAccountProperties[] accounts;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The email address
    string email;
    @jsondata:Name {value: "selected_languages"}
    string selectedLanguages?;
};

# An individual new account user
public type NewUserRequestAccountProperties record {
    # The user's company name
    @jsondata:Name {value: "company_name"}
    string companyName?;
    # The new user's requested groups
    GroupRequest[] groups?;
    # The account ID
    string id;
    @jsondata:Name {value: "permission_profile"}
    PermissionProfileRequest permissionProfile?;
    # The user's job title
    @jsondata:Name {value: "job_title"}
    string jobTitle?;
};

# Results of deleting a user identity
public type UserIdentityResponse record {
    # A unique ID to identify the removed user
    @jsondata:Name {value: "immutable_id"}
    string immutableId?;
    # The user ID
    @jsondata:Name {value: "user_id"}
    string userId?;
    @jsondata:Name {value: "error_details"}
    ErrorDetails errorDetails?;
    # The ID of the identity provider
    @jsondata:Name {value: "provider_id"}
    string providerId?;
    # The ID of the result
    string id?;
};

# This object is an individual permission profile response
public type PermissionProfileResponse record {
    # The name of the permission profile. 
    # 
    # Example: `DocuSign Sender`
    string name?;
    # The ID of the permission profile
    int id?;
};

# A link to a useful URL
public type LinkResponse record {
    # The kind of linked item
    string rel?;
    # The URL of the linked item
    string href?;
};

# A response containing information about users
public type OrganizationUsersResponse record {
    PagingResponseProperties paging?;
    # A list of users
    OrganizationUserResponse[] users?;
};

public type PermissionProfileResponse21 record {
    # The ID of the permission profile
    @jsondata:Name {value: "permission_profile_id"}
    string permissionProfileId?;
    # The human-readable name of the permission profile
    @jsondata:Name {value: "permission_profile_name"}
    string permissionProfileName?;
};

public type UserProductPermissionProfilesResponse record {
    # The ID of the account
    @jsondata:Name {value: "account_id"}
    string accountId?;
    # The ID of the user
    @jsondata:Name {value: "user_id"}
    string userId?;
    # A list of one or more products and their respective permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileResponse[] productPermissionProfiles?;
};

public type DSGroupAndUsersResponse record {
    @jsondata:Name {value: "group_users"}
    DSGroupUsersResponse groupUsers?;
    DSGroupResponse group?;
};

# A response about reserved domains
public type DomainsResponse record {
    # Information about reserved domains
    @jsondata:Name {value: "reserved_domains"}
    DomainResponse[] reservedDomains?;
};

public type BulkUsersAddBody record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

# Errors
public type ErrorDetails record {
    # A description of the error
    @jsondata:Name {value: "error_description"}
    string errorDescription?;
    # The code for the error
    string 'error?;
};

public type DSGroupResponse record {
    @jsondata:Name {value: "is_admin"}
    boolean isAdmin?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
    @jsondata:Name {value: "last_modified_on"}
    string lastModifiedOn?;
    @jsondata:Name {value: "user_count"}
    int:Signed32 userCount?;
    @jsondata:Name {value: "external_account_id"}
    int externalAccountId?;
    @jsondata:Name {value: "group_id"}
    string groupId?;
    @jsondata:Name {value: "group_name"}
    string groupName?;
    @jsondata:Name {value: "account_name"}
    string accountName?;
    string description?;
    @jsondata:Name {value: "ds_group_id"}
    string dsGroupId?;
    @jsondata:Name {value: "source_product_name"}
    string sourceProductName?;
};

public type OrganizationExportAccount record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
};

public type DSGroupUserResponse record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
    @jsondata:Name {value: "user_id"}
    string userId?;
    @jsondata:Name {value: "error_details"}
    ErrorDetails errorDetails?;
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    @jsondata:Name {value: "middle_name"}
    string middleName?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # Status
    string status?;
};

public type OASIRRErrorDetails record {
    # A longer description of the error
    @jsondata:Name {value: "error_description"}
    string errorDescription?;
    # The error number
    string 'error?;
};

# Information about a reserved domain
public type DomainResponse record {
    # A list of settings for the reserved domain
    SettingResponse[] settings?;
    # The identity provider ID of the reserved domain
    @jsondata:Name {value: "identity_provider_id"}
    string identityProviderId?;
    # A list of useful links
    LinkResponse[] links?;
    # The ID of the reserved domain
    string id?;
    # The host name of the reserved domain
    @jsondata:Name {value: "host_name"}
    string hostName?;
    # The status of the request. One of:
    # 
    # - `unknown`
    # - `pending`
    # - `active`
    # - `deactivated`
    # - `rejected`
    string status?;
    # A token  in form of text of the reserved domain
    @jsondata:Name {value: "txt_token"}
    string txtToken?;
};

public type OETRErrorDetails record {
    # A longer description of the error
    @jsondata:Name {value: "error_description"}
    string errorDescription?;
    # The error number
    string 'error?;
};

public type OrganizationImportResponse record {
    string 'type?;
    @jsondata:Name {value: "error_count"}
    int:Signed32 errorCount?;
    @jsondata:Name {value: "user_level_warning_rollups"}
    OrganizationImportResponseWarningRollup[] userLevelWarningRollups?;
    @jsondata:Name {value: "imports_timed_out_for_accounts"}
    string importsTimedOutForAccounts?;
    string id?;
    @jsondata:Name {value: "user_level_error_rollups"}
    OrganizationImportResponseErrorRollup[] userLevelErrorRollups?;
    @jsondata:Name {value: "last_modified"}
    string lastModified?;
    @jsondata:Name {value: "updated_user_count"}
    int:Signed32 updatedUserCount?;
    @jsondata:Name {value: "imports_timed_out_for_sites"}
    string importsTimedOutForSites?;
    string created?;
    @jsondata:Name {value: "imports_failed_for_accounts"}
    string importsFailedForAccounts?;
    @jsondata:Name {value: "no_action_required_user_count"}
    int:Signed32 noActionRequiredUserCount?;
    @jsondata:Name {value: "closed_user_count"}
    int:Signed32 closedUserCount?;
    @jsondata:Name {value: "invalid_column_headers"}
    string invalidColumnHeaders?;
    @jsondata:Name {value: "file_level_error_rollups"}
    OrganizationImportResponseErrorRollup[] fileLevelErrorRollups?;
    @jsondata:Name {value: "processed_user_count"}
    int:Signed32 processedUserCount?;
    OrganizationImportResponseRequestor requestor?;
    @jsondata:Name {value: "results_uri"}
    string resultsUri?;
    @jsondata:Name {value: "imports_failed_for_sites"}
    string importsFailedForSites?;
    @jsondata:Name {value: "has_csv_results"}
    boolean hasCsvResults?;
    @jsondata:Name {value: "user_count"}
    int:Signed32 userCount?;
    @jsondata:Name {value: "imports_not_found_or_not_available_for_accounts"}
    string importsNotFoundOrNotAvailableForAccounts?;
    @jsondata:Name {value: "imports_not_found_or_not_available_for_sites"}
    string importsNotFoundOrNotAvailableForSites?;
    @jsondata:Name {value: "warning_count"}
    int:Signed32 warningCount?;
    @jsondata:Name {value: "added_user_count"}
    int:Signed32 addedUserCount?;
    # Status
    string status?;
};

public type OrganizationAccountRequest record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId;
};

public type RemoveUserProductsResponse record {
    # The user's email address
    @jsondata:Name {value: "user_email"}
    string userEmail?;
    # The user's ID
    @jsondata:Name {value: "user_id"}
    string userId?;
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
    @jsondata:Name {value: "user_product_results"}
    record {|string...;|} userProductResults;
    # When **true,** indicates that the user's access to the specified products was successfully revoked
    @jsondata:Name {value: "is_success"}
    boolean isSuccess;
};

# Represents the Queries record for the operation: DocuSignGroupsv21_GetDSGroups_V2_1
public type DocuSignGroupsv21GetDSGroupsV21Queries record {
    # Start page of DSGroups
    int:Signed32 page?;
    # Page size of DSGroups
    @http:Query {name: "page_size"}
    int:Signed32 pageSize?;
};

# Represents the Queries record for the operation: OrganizationUser_OrganizationUsers_GetProfileV2
public type OrganizationUserOrganizationUsersGetProfileV2Queries record {
    # The email address associated with the users you want to retrieve.
    # 
    # **Note:** This property is required
    string email?;
};

public type AssetGroupAccountResponse record {
    # The ID of the account
    string accountId?;
    # The external account ID
    int externalAccountId?;
    # Reserved for DocuSign
    string assetGroupName?;
    # The name of the account
    string accountName?;
    # When **true,** indicates that the account is compliant
    boolean compliant?;
    # Reserved for DocuSign
    int:Signed32 siteId?;
    # Reserved for DocuSign
    string siteName?;
    # The asset group ID
    string assetGroupId?;
};

# A key/value list of settings
public type SettingResponse record {
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
    # The value of the setting
    record {} value?;
    # The key of the setting
    string 'key?;
};

# Represents the Queries record for the operation: OrganizationProvisionAssetGroup_GetAssetGroupAccountsByOrg
public type OrganizationProvisionAssetGroupGetAssetGroupAccountsByOrgQueries record {
    # When **true,** only compliant accounts are returned and account responses do not include the `compliant` field. The default value is **false.**
    boolean compliant?;
};

public type CloneErrorDetails record {
    # The error description
    string errorDescription?;
    # When **true,** indicates that the error was caused by the system. When **false,** indicates that the error was caused by the user
    boolean isSystemError?;
    # The error code
    string 'error?;
};

# Information about group membership
public type MembershipResponse record {
    # When **true,**
    # the user has administration 
    # privileges on the account
    @jsondata:Name {value: "is_admin"}
    boolean isAdmin?;
    # The ID of the account
    @jsondata:Name {value: "account_id"}
    string accountId?;
    # The external account ID
    @jsondata:Name {value: "external_account_id"}
    string externalAccountId?;
    # The date the user's account was created
    @jsondata:Name {value: "created_on"}
    string createdOn?;
    # The name of the account
    @jsondata:Name {value: "account_name"}
    string accountName?;
    # A list of groups the user is a member of in this account,
    MemberGroupResponse[] groups?;
    @jsondata:Name {value: "permission_profile"}
    PermissionProfileResponse permissionProfile?;
    # The email address
    string email?;
    # When **true,**
    # this is an external account
    @jsondata:Name {value: "is_external_account"}
    boolean isExternalAccount?;
    # The status of the user's membership
    string status?;
};

public type DSGroupUsersResponse record {
    @jsondata:Name {value: "total_count"}
    int:Signed32 totalCount?;
    # The page number
    int:Signed32 page?;
    # A list of users
    DSGroupUserResponse[] users?;
    # The number of items per page
    @jsondata:Name {value: "page_size"}
    int:Signed32 pageSize?;
};

# A list of asset group accounts
public type AssetGroupAccountsResponse record {
    # The list of asset group accounts
    AssetGroupAccountResponse[] assetGroupAccounts?;
};

public type PagingResponseProperties record {
    # The index position of the first result in this set
    @jsondata:Name {value: "result_set_start_position"}
    int:Signed32 resultSetStartPosition?;
    # A URL to the next set of results. 
    string next?;
    # A URL to the previous set of results. 
    string previous?;
    # The index position of the last result in this set
    @jsondata:Name {value: "result_set_end_position"}
    int:Signed32 resultSetEndPosition?;
    # The number of items in a result set (page)
    @jsondata:Name {value: "result_set_size"}
    int:Signed32 resultSetSize?;
    # The total number of results
    @jsondata:Name {value: "total_set_size"}
    int:Signed32 totalSetSize?;
};

public type OrganizationImportResponseRequestor record {
    # The name of the requestor
    string name?;
    # The unique ID of the requestor.
    # If `type` is `user`, this is the requestor's user ID
    string id?;
    # The type of the requestor. One of:
    # 
    # - `user`
    # - `client_app`
    string 'type?;
    # The email address of the requestor
    string email?;
};

public type ImportsAccountSettingsBody record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

# Represents the Queries record for the operation: OrganizationUser_OrganizationUsers_GetV2
public type OrganizationUserOrganizationUsersGetV2Queries record {
    # Page size of the response. The default value is 20
    int:Signed32 take?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @http:Query {name: "account_id"}
    string accountId?;
    # Select users that are in the specified domain. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @http:Query {name: "organization_reserved_domain_id"}
    string organizationReservedDomainId?;
    # Select users whose data have been modified since the date specified. `account_id` or `organization_reserved_domain_id` must be specified
    @http:Query {name: "last_modified_since"}
    string lastModifiedSince?;
    # Selects users by pattern matching on the user's email address
    @http:Query {name: "email_user_name_like"}
    string emailUserNameLike?;
    # Index of first item to include in the response. The default value is 0
    int:Signed32 'start?;
    # Index of the last item to include in the response. Ignored if `take` parameter is specified
    int:Signed32 end?;
    # Email address of the desired user. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    string email?;
    # The user's membership status. One of:
    # 
    # - `activation_required`
    # - `activation_sent`
    # - `active`
    # - `closed`
    # - `disabled`
    @http:Query {name: "membership_status"}
    string membershipStatus?;
    # Status
    string status?;
};

# Information about a user
public type UserDrilldownResponse record {
    # The user's status. One of:
    # 
    # - `active`
    # - `created`
    # - `closed`
    @jsondata:Name {value: "user_status"}
    string userStatus?;
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # This property has been deprecated
    @jsondata:Name {value: "last_login"}
    string lastLogin?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # The name of the user's default account
    @jsondata:Name {value: "default_account_name"}
    string defaultAccountName?;
    # The ID of the user's default account
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    @jsondata:Name {value: "device_verification_enabled"}
    boolean deviceVerificationEnabled?;
    # A list of organizations that have groups that the user is a member of
    MembershipResponse[] memberships?;
    @jsondata:Name {value: "selected_languages"}
    string selectedLanguages?;
    # The site name of the account
    @jsondata:Name {value: "site_name"}
    string siteName?;
    # When **true,** the user has organization administration privileges
    @jsondata:Name {value: "is_organization_admin"}
    boolean isOrganizationAdmin?;
    # A list of identities associated with the user
    UserIdentityResponse[] identities?;
    # The date the user's account was created
    @jsondata:Name {value: "created_on"}
    string createdOn?;
    # The site ID of the organization
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # The user's unique ID
    string id?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
};

# An object describing the target cloned account
public type AssetGroupAccountCloneTargetAccount record {
    # The data center site of the account. This property is read-only
    string site?;
    # The country code of the target account. The country code for the United States is `en`. 
    # 
    # **Note:** When cloning an account, you must include this property or `region`. If both are provided, `region` will be used
    string countryCode?;
    # The name of the target account. This property is required in the request body when cloning an account
    string name?;
    # An object describing the administrator of the cloned account
    AssetGroupAccountCloneTargetAccountAdmin admin?;
    # The ID of the target account
    string id?;
    # The region of the target account. 
    # 
    # **Note:** When cloning an account, you must include this property or `countryCode` in the request. If both are provided, `region` will be used
    string region?;
};

public type OrganizationAccountsRequest record {
    OrganizationAccountRequest[] accounts?;
};

# A group for a user to belong to
public type GroupRequest record {
    # The name of the group
    string name?;
    # The ID of the group
    int id;
    # The type of group. One of:
    # 
    # - `invalid`
    # - `admin_group`
    # - `everyone_group`
    # - `custom_group`
    string 'type?;
};

# Represents the Queries record for the operation: OrganizationProvisionAssetGroup_GetAssetGroupAccountClone
public type OrganizationProvisionAssetGroupGetAssetGroupAccountCloneQueries record {
    # When **true,** include additional details about the cloned account. The default value is **false.**
    @http:Query {name: "include_details"}
    boolean includeDetails?;
};

# And individual change of email
public type UpdateUserEmailRequest record {
    # The site ID
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId;
    # The ID of the users whose email address you want to change
    string id;
    # The new email address
    string email;
};

public type ProductPermissionProfileResponse record {
    @jsondata:Name {value: "error_message"}
    string errorMessage?;
    # The ID of the product
    @jsondata:Name {value: "product_id"}
    string productId?;
    @jsondata:Name {value: "permission_profiles"}
    PermissionProfileResponse21[] permissionProfiles?;
    # The human-readable name of the product
    @jsondata:Name {value: "product_name"}
    string productName?;
};

# An object describing the status of the data deletion request for a specific account
public type MembershipDataRedactionResponse record {
    # The ID of the account
    @jsondata:Name {value: "account_id"}
    string accountId?;
    # The status of the data deletion request. Valid values:
    # - `success`
    # - `pending`
    # - `failure`
    # - `already_redacted`
    "unknown"|"pending"|"failure"|"success"|"already_redacted" status?;
};

# User identity,
public type UserIdentityRequest record {
    # The ID of the identity
    string id?;
};

# Request to delete a user's identities,
public type DeleteUserIdentityRequest record {
    # A list of identities
    UserIdentityRequest[] identities;
};

public type OrganizationExportDomain record {
    string domain?;
};

public type AddDSGroupAndUsersResponse record {
    @jsondata:Name {value: "group_users"}
    AddDSGroupUsersResponse groupUsers?;
    DSGroupResponse group?;
};

public type BulkUsersAddBody1 record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

public type IndividualMembershipDataRedactionRequest record {
    # The ID of the user whose data you want to delete
    @jsondata:Name {value: "user_id"}
    string userId?;
};

# A response
public type UpdateResponse record {
    # The status of the request
    string status?;
};

# Represents the Queries record for the operation: OrganizationUser_OrganizationUsers_GetDSProfileByUserId
public type OrganizationUserOrganizationUsersGetDSProfileByUserIdQueries record {
    # When **true,** sorts the results in ascending order by account name
    boolean sort?;
};

public type IndividualUserDataRedactionResponse record {
    # The ID of the user
    @jsondata:Name {value: "user_id"}
    string userId?;
    # A list of objects describing the status of the deletion request for each account
    @jsondata:Name {value: "membership_results"}
    MembershipDataRedactionResponse[] membershipResults?;
    # The overall status of the data deletion request
    "unknown"|"pending"|"failure"|"success"|"already_redacted" status?;
};

public type DSGroupRequest record {
    @jsondata:Name {value: "ds_group_id"}
    string dsGroupId;
};

# Represents the Queries record for the operation: Account_Accounts_GetGroupsV2
public type AccountAccountsGetGroupsV2Queries record {
    # Page size of the response. The default value is 20
    int:Signed32 take?;
    # Index of first item to include in the response. The default value is 0
    int:Signed32 'start?;
    # Index of the last item to include in the response. Ignored if `take` parameter is specified
    int:Signed32 end?;
};

public type OrganizationImportResponseWarningRollup record {
    # The number of warnings of this type
    int:Signed32 count?;
    # The type of warning
    @jsondata:Name {value: "warning_type"}
    string warningType?;
};

public type OrganizationImportsResponse record {
    # A list of responses to user import requests
    OrganizationImportResponse[] imports?;
};

# A new user request
public type NewAccountUserRequest record {
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # The access code that the user needs to activate an account
    @jsondata:Name {value: "access_code"}
    string accessCode?;
    # The new user's requested groups
    GroupRequest[] groups?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # When **true,** the user's account is activated automatically
    @jsondata:Name {value: "auto_activate_memberships"}
    boolean autoActivateMemberships?;
    # The account ID of the user's default account
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    @jsondata:Name {value: "permission_profile"}
    PermissionProfileRequest permissionProfile?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The email address of the user
    string email;
    @jsondata:Name {value: "selected_languages"}
    string selectedLanguages?;
};

# Information about a single identity provider
public type IdentityProviderResponse record {
    # The human-readable name of the identity provider
    @jsondata:Name {value: "friendly_name"}
    string friendlyName?;
    @jsondata:Name {value: "saml_20"}
    Saml2IdentityProviderResponse saml20?;
    # When **true,** users who use this identity provider are automatically provisioned. 
    @jsondata:Name {value: "auto_provision_users"}
    boolean autoProvisionUsers?;
    # A list of useful URLs
    LinkResponse[] links?;
    # The unique ID of the identity provider
    string id?;
    # The type of the identity provider. One of:
    # 
    # - `none`
    # - `saml_20`
    # - `saml_11`
    # - `saml_10`
    # - `ws_federation`
    # - `open_id_connect`
    string 'type?;
};

# A response about member groups. It contains the groups and paging information
public type MemberGroupsResponse record {
    # A list of the responses
    MemberGroupResponse[] groups?;
    PagingResponseProperties paging?;
};

# A single attribute mapping response
public type RequiredAttributeMappingResponse record {
    # The name of the attribute
    @jsondata:Name {value: "required_attribute_name"}
    string requiredAttributeName?;
    # The human-readable name of the attribute
    @jsondata:Name {value: "required_attribute_friendly_name"}
    string requiredAttributeFriendlyName?;
    # The unique ID of the attribute
    @jsondata:Name {value: "required_attribute_id"}
    int:Signed32 requiredAttributeId?;
    # The name of the substitute attribute
    @jsondata:Name {value: "substitute_attribute_name"}
    string substituteAttributeName?;
};

# A request to update group membership
public type UpdateMembershipRequest record {
    # The user's unique ID
    @jsondata:Name {value: "account_id"}
    string accountId;
    # When **true,** send an activation request after the update
    @jsondata:Name {value: "send_activation"}
    boolean sendActivation?;
    # The user's company name
    @jsondata:Name {value: "company_name"}
    string companyName?;
    # The access code that the user needs to activate an account
    @jsondata:Name {value: "access_code"}
    string accessCode?;
    # The user's requested groups
    GroupRequest[] groups?;
    @jsondata:Name {value: "permission_profile"}
    PermissionProfileRequest permissionProfile?;
    # The user's job title
    @jsondata:Name {value: "job_title"}
    string jobTitle?;
};

# The results of changing a user's information
public type UsersUpdateResponse record {
    # When **true,** the request to change user information succeeded
    boolean success?;
    # A list of users whose email addresses have been updated
    UserUpdateResponse[] users?;
};

# Results of deleting identities
public type DeleteResponse record {
    # A list of identities to delete
    UserIdentityResponse[] identities?;
    # When **true,** the request succeeded
    boolean success?;
};

# Information about an individual organization
public type OrganizationResponse record {
    # The date the organization's account was last updated
    @jsondata:Name {value: "last_modified_on"}
    string lastModifiedOn?;
    # A description of the organization
    string description?;
    # The default account ID of the organization
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The user who last updated the organization's account
    @jsondata:Name {value: "last_modified_by"}
    string lastModifiedBy?;
    # The default permission profile ID of the organization
    @jsondata:Name {value: "default_permission_profile_id"}
    int defaultPermissionProfileId?;
    # The user who created the organization account
    @jsondata:Name {value: "created_by"}
    string createdBy?;
    # A list of the organization accounts users
    OrganizationSimpleIdObject[] users?;
    # A list of reserved domains for the organization
    @jsondata:Name {value: "reserved_domains"}
    DomainResponse[] reservedDomains?;
    # The date the organization's account was created
    @jsondata:Name {value: "created_on"}
    string createdOn?;
    # A list of identity providers for the organization
    @jsondata:Name {value: "identity_providers"}
    IdentityProvidersResponse[] identityProviders?;
    # The name of the organization
    string name?;
    # A list of links for the organization
    LinkResponse[] links?;
    # The ID of the organization
    string id?;
    # A list of organization accounts
    OrganizationAccountResponse[] accounts?;
};

public type OrganizationAccountSettingsImportRequestorResponse record {
    string name?;
    string id?;
    string 'type?;
    # The email address
    string email?;
};

# And individual group responses,
public type MemberGroupResponse record {
    # The name of the group
    string name?;
    # The unique ID of the group
    int id?;
    # The type of group. One of:
    # 
    # - `invalid`
    # - `admin_group`
    # - `everyone_group`
    # - `custom_group`
    string 'type?;
};

# Request to change a user's information
public type UpdateUserRequest record {
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # The account ID of the user's default account
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    @jsondata:Name {value: "device_verification_enabled"}
    boolean deviceVerificationEnabled?;
    # A list of group membership requests
    UpdateMembershipRequest[] memberships?;
    @jsondata:Name {value: "selected_languages"}
    string selectedLanguages?;
    # The site ID
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # The user's unique ID
    string id;
    # When **true,** the user will be required to change the account password
    @jsondata:Name {value: "force_password_change"}
    boolean forcePasswordChange?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The email address
    string email?;
};

public type ProductPermissionProfilesResponse record {
    # A list of one or more products and their respective permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileResponse[] productPermissionProfiles?;
};

public type OrganizationExportsResponse record {
    OrganizationExportResponse[] exports?;
};

# The account that is cloned
public type AssetGroupAccountClone record {
    # The name of the user who initiated the clone request
    string createdByName?;
    AssetGroupAccountCloneSourceAccount sourceAccount;
    # Reserved for DocuSign
    string orderId?;
    CloneErrorDetails cloneProcessingFailureDetails?;
    # A message providing information about the clone request. If the request resulted in an error, this message includes specific information about the error
    string message?;
    # The ID of the asset group to which the account belongs. Use this value to retrieve information about the clone request with the [getAssetGroupAccountClone](/docs/admin-api/reference/accountprovisioning/accountcloning/getassetgroupaccountclone/) endpoint
    string assetGroupId?;
    # The type of asset group work
    "Undefined"|"GroupAssetFulfillment"|"AccountAssetFulfillment"|"AccountAssetClone"|"AccountAssetCreate" assetGroupWorkType?;
    # The email address of the user who initiated the clone request
    string createdByEmail?;
    # Reserved for DocuSign
    string cloneRequestId?;
    # The date that the clone request was initiated
    string createdDate?;
    # An object describing the target cloned account
    AssetGroupAccountCloneTargetAccount targetAccount;
    # The ID of the job that is created by the request. Use this value to retrieve information about the clone request with the [getAssetGroupAccountClone](/docs/admin-api/reference/accountprovisioning/accountcloning/getassetgroupaccountclone/) endpoint
    string assetGroupWorkId?;
    # The status of the clone request. Valid values:
    # * `Pending`
    # * `Processing`
    # * `PendingError`
    # * `ProcessingError`
    # * `Completed`
    # * `Canceled`
    # * `PermanentFailure`
    "Undefined"|"Pending"|"Processing"|"PendingError"|"ProcessingError"|"Completed"|"Canceled"|"PermanentFailure" status?;
    # The number of retries
    int:Signed32 attempts?;
};

public type DSGroupListResponse record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
    @jsondata:Name {value: "ds_groups"}
    DSGroupResponse[] dsGroups?;
    @jsondata:Name {value: "total_count"}
    int:Signed32 totalCount?;
    # The page number
    int:Signed32 page?;
    # The number of items per page
    @jsondata:Name {value: "page_size"}
    int:Signed32 pageSize?;
};

public type OrganizationExportResponse record {
    # The time and date when the request expires
    string expires?;
    # The size of the request in bytes
    @jsondata:Name {value: "size_bytes"}
    int sizeBytes?;
    # A pre-configured GET request to get the status of the export. Generally this is the same URI used to access this endpoint
    @jsondata:Name {value: "metadata_url"}
    string metadataUrl?;
    # The time and date the request was created. This is a date in ISO 8601 format.
    # 
    # Example:  `2019-03-26T19:02:09.8957715Z`
    string created?;
    # The time and date when the request completed. Null if the request is still in progress
    string completed?;
    # The type of export requested. One of:
    # 
    # - `organization_domain_users_export`: All users of the reserved domains.
    # - `organization_external_memberships_export`: Users whose email address domain is *not* linked to the organization. 
    # - `organization_memberships_export`: Every user in every account in the organization. Users in multiple accounts will appear more than once.
    # - `organization_account_settings_export`: This value only applies to requests to export account settings
    string 'type?;
    OrganizationExportRequestorResponse requestor?;
    @jsondata:Name {value: "selected_accounts"}
    OrgExportSelectedAccount[] selectedAccounts?;
    # An integer between 0 to 100 (inclusive) that reports the progress of the request
    @jsondata:Name {value: "percent_completed"}
    int:Signed32 percentCompleted?;
    @jsondata:Name {value: "selected_domains"}
    OrgExportSelectedDomain[] selectedDomains?;
    # The number of rows returned in this request
    @jsondata:Name {value: "number_rows"}
    int numberRows?;
    # When **true,** the request succeeded. 
    boolean success?;
    # The unique ID of this request
    string id?;
    # The time and date when the request was modified. This is typically the same as `created`
    @jsondata:Name {value: "last_modified"}
    string lastModified?;
    # An array of results. There is one set of results for each server an account is in
    OrganizationExportTaskResponse[] results?;
    # The status of the request. One of:
    # 
    # - `failed`
    # - `in_process`
    # - `queued`
    # - `completed`
    string status?;
};

public type BulkUsersUpdateBody record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

public type DeleteMembershipRequest record {
    # The ID of a user's account you want to close
    string id;
};

public type IdentityProvidersResponse record {
    @jsondata:Name {value: "identity_providers"}
    IdentityProviderResponse[] identityProviders?;
};

# Represents the Queries record for the operation: OrganizationUser_OrganizationUsers_GetDSProfiles
public type OrganizationUserOrganizationUsersGetDSProfilesQueries record {
    # When **true,** sorts the results in ascending order by account name
    boolean sort?;
    # The email address of the user.
    # 
    # **Note:** This property is required
    string email?;
};

public type OASIRROrganizationAccountSettingsErrorDataResponse record {
    @jsondata:Name {value: "error_key"}
    string errorKey?;
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
    @jsondata:Name {value: "account_name"}
    string accountName?;
    # The error number
    string 'error?;
    @jsondata:Name {value: "setting_key"}
    string settingKey?;
};

# Represents the Queries record for the operation: Organization_Organization_GetListV2
public type OrganizationOrganizationGetListV2Queries record {
    # Specifies how to select the organizations. Valid values:
    # 
    # - `org_admin`: Returns organizations for which the authenticated user is an admin.
    # - `account_membership`: Returns organizations that contain an account of which the authenticated user is a member
    # 
    # Default value: `org_admin`
    string mode?;
};

public type AddUserResponseAccountProperties record {
    @jsondata:Name {value: "ds_groups"}
    DSGroupResponse[] dsGroups?;
    # A list of one or more products and their respective permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileResponse[] productPermissionProfiles?;
    # The user's company name
    @jsondata:Name {value: "company_name"}
    string companyName?;
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    string id?;
    # The user's job title
    @jsondata:Name {value: "job_title"}
    string jobTitle?;
};

public type BulkUsersUpdateBody1 record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

public type ForceActivateMembershipRequest record {
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId;
};

# Information about users to remove from the group
public type DSGroupUsersRemoveRequest record {
    # An array of IDs corresponding to users to remove from the group
    @jsondata:Name {value: "user_ids"}
    string[] userIds?;
    # An array of emails associated with users to remove from the group. **Note:** If `user_ids` is also specified, this parameter will be ignored
    @jsondata:Name {value: "user_emails"}
    string[] userEmails?;
};

# OAuth2 Refresh Token Grant Configs
public type OAuth2RefreshTokenGrantConfig record {|
    *http:OAuth2RefreshTokenGrantConfig;
    # Refresh URL
    string refreshUrl = "https://account.docusign.com/oauth/auth";
|};

public type AssetGroupAccountClones record {
    # The list of asset group accounts
    AssetGroupAccountClone[] assetGroupWorks?;
};

# Information about an account
public type OrganizationAccountResponse record {
    # The external account ID
    @jsondata:Name {value: "external_account_id"}
    int externalAccountId?;
    # The name of the account
    string name?;
    # The site ID
    @jsondata:Name {value: "site_id"}
    int:Signed32 siteId?;
    # The unique ID of the  account
    string id?;
};

public type OrgExportSelectedAccount record {
    # Select users that are members of the specified account. At least one of `email`, `account_id` or `organization_reserved_domain_id` must be specified
    @jsondata:Name {value: "account_id"}
    string accountId?;
};

public type NewMultiProductUserAddRequest record {
    @jsondata:Name {value: "ds_groups"}
    DSGroupRequest[] dsGroups?;
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    # A list of one or more products and their respective permissions
    @jsondata:Name {value: "product_permission_profiles"}
    ProductPermissionProfileRequest[] productPermissionProfiles;
    # The access code that the user needs to activate an account
    @jsondata:Name {value: "access_code"}
    string accessCode?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # When **true,** the user's account is activated automatically
    @jsondata:Name {value: "auto_activate_memberships"}
    boolean autoActivateMemberships?;
    @jsondata:Name {value: "default_account_id"}
    string defaultAccountId?;
    # The language and culture of the user.
    # 
    #   * Chinese Simplified: `zh_CN`
    #   * Chinese Traditional: `zh_TW`
    #   * Dutch: `nl`
    #   * English: `en`
    #   * French: `fr`
    #   * German: `de`
    #   * Italian: `it`
    #   * Japanese: `ja`
    #   * Korean: `ko`
    #   * Portuguese: `pt`
    #   * Portuguese Brazil: `pt_BR`
    #   * Russian: `ru`
    #   * Spanish: `es`
    @jsondata:Name {value: "language_culture"}
    string languageCulture?;
    # The user's federated status. One of:
    # 
    # - `RemoveStatus`
    # - `FedAuthRequired`
    # - `FedAuthBypass`
    # - `Evicted`
    @jsondata:Name {value: "federated_status"}
    string federatedStatus?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The email address
    string email;
};

# Information about a single certificate
public type CertificateResponse record {
    # When **true,** the certificate is valid
    @jsondata:Name {value: "is_valid"}
    boolean isValid?;
    # The thumbprint of the certificate
    string thumbprint?;
    # A list of useful links
    LinkResponse[] links?;
    # The unique ID of the certificate
    string id?;
    # The date when the certificate expires
    @jsondata:Name {value: "expiration_date"}
    string expirationDate?;
    # The certificate issuer
    string issuer?;
};

public type OrganizationExportRequestorResponse record {
    # The name of the requestor
    string name?;
    # The unique ID of the requestor.
    # If `type` is `user`, this is the requestor's user ID
    string id?;
    # The type of the requestor. One of:
    # 
    # - `user`
    # - `client_app`
    string 'type?;
    # The email address of the requestor
    string email?;
};

public type AssetGroupAccountCloneSourceAccount record {
    # The site the source account is on
    string site?;
    # The external account ID of the source account
    int externalAccountId?;
    # The name of the source account
    string name?;
    # The ID of the account to clone. This property is required in POST requests
    string id;
};

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
    @jsondata:Name {value: "error_type"}
    string errorType?;
    # The number of errors of this type
    int:Signed32 count?;
};

public type OrganizationAccountSettingsImportResponse record {
    @jsondata:Name {value: "skipped_settings_by_account"}
    record {|string[]...;|} skippedSettingsByAccount?;
    string expires?;
    string created?;
    string completed?;
    string 'type?;
    @jsondata:Name {value: "number_unprocessed_accounts"}
    int numberUnprocessedAccounts?;
    OrganizationAccountSettingsImportRequestorResponse requestor?;
    @jsondata:Name {value: "percent_completed"}
    int:Signed32 percentCompleted?;
    boolean success?;
    @jsondata:Name {value: "organization_id"}
    string organizationId?;
    @jsondata:Name {value: "number_processed_accounts"}
    int numberProcessedAccounts?;
    string id?;
    @jsondata:Name {value: "last_modified"}
    string lastModified?;
    OrganizationAccountSettingsImportResultResponse[] results?;
    # Status
    string status?;
};

# Represents the Queries record for the operation: OrganizationProductPermissionProfile_GetUserProductPermissionProfilesByEmail
public type OrganizationProductPermissionProfileGetUserProductPermissionProfilesByEmailQueries record {
    # The email address of the user.
    # 
    # **Note:** This property is required
    string email?;
};

# Information about a user
public type OrganizationUserResponse record {
    # The user's status. One of:
    # 
    # - `active`
    # - `created`
    # - `closed`
    @jsondata:Name {value: "user_status"}
    string userStatus?;
    @jsondata:Name {value: "ds_groups"}
    DSGroupResponse[] dsGroups?;
    # The date the user's account was created
    @jsondata:Name {value: "created_on"}
    string createdOn?;
    # The date on which the user became a member of the organization
    @jsondata:Name {value: "membership_created_on"}
    string membershipCreatedOn?;
    # The full name of the user
    @jsondata:Name {value: "user_name"}
    string userName?;
    @jsondata:Name {value: "membership_id"}
    string membershipId?;
    # The user's last name
    @jsondata:Name {value: "last_name"}
    string lastName?;
    # The user's unique ID
    string id?;
    # The user's first name
    @jsondata:Name {value: "first_name"}
    string firstName?;
    # The user's membership status. One of:
    # 
    # - `activation_required`
    # - `activation_sent`
    # - `active`
    # - `closed`
    # - `disabled`
    @jsondata:Name {value: "membership_status"}
    string membershipStatus?;
    # The email address
    string email?;
};

public type DSGroupUsersAddRequest record {
    @jsondata:Name {value: "user_ids"}
    string[] userIds;
};

public type BulkUsersCloseBody record {
    # CSV file
    @jsondata:Name {value: "file.csv"}
    record {byte[] fileContent; string fileName;} fileCsv;
};

# Represents the Queries record for the operation: DocuSignGroupsv21_GetDSGroupUsers_V2_1
public type DocuSignGroupsv21GetDSGroupUsersV21Queries record {
    # Start page of DSGroups
    int:Signed32 page?;
    # Page size of DSGroups
    @http:Query {name: "page_size"}
    int:Signed32 pageSize?;
};

# A permission profile
public type PermissionProfileRequest record {
    # The name of the permission profile
    string name?;
    # The ID of the permission profile
    int id;
};

public type RemoveDSGroupUsersResponse record {
    @jsondata:Name {value: "failed_users"}
    DSGroupUserResponse[] failedUsers?;
    @jsondata:Name {value: "is_success"}
    boolean isSuccess?;
};

public type OrgExportSelectedDomain record {
    string domain?;
};
