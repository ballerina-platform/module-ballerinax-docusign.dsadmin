# Manage user information with DocuSign Admin

This Ballerina program demonstrates the integration of the DocuSign Admin API to create a new user within an organization and retrieve information about that user. The example covers fetching organizations, creating a new user, and retrieving user details.

## Step 1: Import DocuSign connector

Import the `ballerinax/docusign.dsadmin` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsadmin;
import ballerina/io;
```

## Step 2: Setup DocuSign Admin connection

Define configurable parameters such as `accessToken`, `accountId`, and `email` to set up the DocuSign Admin connection.

```ballerina
configurable string accessToken = ?;
configurable string accountId = ?;
configurable string email = ?;
```

## Step 3: Create DocuSign Admin client

Initialize the DocuSign Admin client with the specified service URL, connection configuration, and account ID.

```ballerina
dsadmin:Client docuSignClient = check new(
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
dsadmin:OrganizationResponse[]? organizations = orgResponse.organizations;
if organizations !is dsadmin:OrganizationResponse[] {
    io:println("Error: organizations not found");
    return;
}

dsadmin:OrganizationResponse organization = organizations[0];
string? organizationId = organization.id;
if organizationId == () {
    io:println("Error: organization id not found");
    return;
}

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

dsadmin:NewUserResponse newUserResponse = check docuSignClient->/v2/organizations/[organizationId]/users.post(newUserReq);
io:println("New user created: ", newUserResponse);
```

## Step 6: Retrieve user information

Retrieve information about a specific user within the organization and account.

```ballerina
string? userId = newUserResponse.id;
if userId == () {
    io:println("Error: user id not found");
    return;
}

dsadmin:OrganizationUsersResponse userInformation = check docuSignClient->/v2/organizations/[organizationId]/users(account_id = accountId, email = email);
io:println("User Information in the Organization: ", userInformation);
```
