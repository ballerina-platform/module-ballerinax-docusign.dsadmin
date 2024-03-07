# Access permissions in user accounts

This guide demonstrates the integration of the DocuSign Admin API in a Ballerina application to manage organizations, users, permissions, and groups. The example covers fetching organizations, creating a new user, retrieving user information, fetching permission profiles, and obtaining groups associated with an account.

## Step 1: Import DocuSign connector

Import the `ballerinax/docusign.dsadmin` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsadmin;
import ballerina/io;
```

## Step 2: Setup DocuSign admin connection

Define configurable parameters such as `accessToken` and `accountId` to set up the DocuSign Admin connection.

```ballerina
configurable string accessToken = ?;
configurable string accountId = ?;
```

## Step 3: Create DocuSign Admin client

Initialize the DocuSign Admin client with the specified service URL, connection configuration, and account ID.

```ballerina
dsadmin:Client docuSignClient = check new (
    {
        auth: {
            token: accessToken
        }
    },
    serviceUrl = "https://api-d.docusign.net/management"
);
```

## Step 4: Fetch organizations

Retrieve information about organizations associated with the provided access token.

```ballerina
dsadmin:OrganizationsResponse orgResponse = check docuSignClient->/v2/organizations();
io:println("Organizations: ", orgResponse);
```

## Step 5: Create a new user

Create a new user within the organization and associate them with the specified account.

```ballerina
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

dsadmin:NewUserResponse newUserResp = check docuSignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
io:println("New user created: ", newUserResp);
```

## Step 6: Retrieve user information

Retrieve information about a specific user within the organization and account.

```ballerina
dsadmin:OrganizationUsersResponse userInformation = check docuSignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = "user1@docusignmail.com");
io:println("User Information in the Organization: ", userInformation);
```

## Step 7: Fetch permission profiles

Retrieve permission profiles associated with the specified organization and account.

```ballerina
dsadmin:PermissionsResponse permissionsResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/permissions();
io:println("Permission Profiles: ", permissionsResponse);
```

## Step 8: Obtain groups

Fetch groups associated with the specified organization and account.

```ballerina
dsadmin:MemberGroupsResponse groupsResponse = check docuSignClient->/v2/organizations/[organizationId]/accounts/[accountId]/groups();
io:println("Groups: ", groupsResponse);
```
