# Managing DocuSign Organizations and Users with Admin API in Ballerina

This guide demonstrates the integration of the DocuSign Admin API in a Ballerina application to manage organizations, users, permissions, and groups. The example covers fetching organizations, creating a new user, retrieving user information, fetching permission profiles, and obtaining groups associated with an account.

## Step 1: Import DocuSign Connector

Import the `ballerinax/docusign.dsadmin` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsadmin;
import ballerina/io;
```

## Step 2: Set Up DocuSign Admin Connection

Define configurable parameters such as `accessToken` and `accountId` to set up the DocuSign Admin connection.

```ballerina
configurable string accessToken = ?;
configurable string accountId = ?;
```

## Step 3: Create DocuSign Admin Client

Initialize the DocuSign Admin client with the specified service URL, connection configuration, and account ID.

```ballerina
dsadmin:Client docusignClient = check new (
    {
        auth: {
            token: accessToken
        }
    },
    serviceUrl = "https://api-d.docusign.net/management"
);
```

## Step 4: Fetch Organizations

Retrieve information about organizations associated with the provided access token.

```ballerina
dsadmin:OrganizationsResponse orgResponse = check docusignClient->/v2/organizations();
io:println("Organizations: ", orgResponse);
```

## Step 5: Create a New User

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

dsadmin:NewUserResponse newUserResp = check docusignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
io:println("New user created: ", newUserResp);
```

## Step 6: Retrieve User Information

Retrieve information about a specific user within the organization and account.

```ballerina
dsadmin:OrganizationUsersResponse userInformation = check docusignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = "user1@docusignmail.com");
io:println("User Information in the Organization: ", userInformation);
```

## Step 7: Fetch Permission Profiles

Retrieve permission profiles associated with the specified organization and account.

```ballerina
dsadmin:PermissionsResponse permissionsResponse = check docusignClient->/v2/organizations/[organizationId]/accounts/[accountId]/permissions();
io:println("Permission Profiles: ", permissionsResponse);
```

## Step 8: Obtain Groups

Fetch groups associated with the specified organization and account.

```ballerina
dsadmin:MemberGroupsResponse groupsResponse = check docusignClient->/v2/organizations/[organizationId]/accounts/[accountId]/groups();
io:println("Groups: ", groupsResponse);
```
