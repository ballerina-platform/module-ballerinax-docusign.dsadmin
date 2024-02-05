## Overview

The Ballerina Docusign Admin Connector efficiently manages DocuSign users and permissions across all your accounts and domains

The Ballerina Docusign Admin module supports [DocuSign Admin API V2](https://github.com/docusign/OpenAPI-Specifications/blob/master/admin.rest.swagger-v2.1.json).

## Set up Guide

To utilize the DocuSign Admin connector, you must have access to the DocuSign REST API through a DocuSign account.

### Step 1: Create a DocuSign Account

In order to use the DocuSign Admin connector, you need to first create the DocuSign credentials for the connector to interact with DocuSign.

You can [create an account](https://go.docusign.com/o/sandbox/) for free at the [Developer Center](https://developers.docusign.com/).

### Step 2: Create Integration Key and Secret Key

1. **Create an Integration Key and Secret Key**: Visit the [Apps and Keys](https://admindemo.docusign.com/apps-and-keys) page on DocuSign. Click on "Add App and Integration Key", provide an App name, and click "Create App". This will generate an Integration Key.

2. **Generate a Secret Key**: Under the Authentication section, click on "Add Secret Key". This will generate a Secret Key. Make sure to copy and save both the Integration Key and Secret Key.

### Step 3: Generate Access Token

1. **Add a Redirect URI**: Click on "Add URI" and enter your redirect URI (e.g., <http://www.example.com/callback>).

2. **Generate the Encoded Key**: The Encoded Key is a base64 encoded string of your Integration Key and Secret Key in the format `{IntegrationKey:SecretKey}`. You can generate this in your web browser's console using the `btoa()` function: `btoa('IntegrationKey:SecretKey')`.

3. **Get the Authorization Code**: Visit the following URL in your web browser, replacing `{iKey}` with your Integration Key and `{redirectUri}` with your Redirect URI:

    ```url
    https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation&client_id={iKey}&redirect_uri={redirectUri}
    ```

    This will redirect you to your Redirect URI with a `code` query parameter. This is your Authorization Code.

4. **Get the Access Token**: Use the following `curl` command to get the Access Token, replacing `{encodedKey}` with your Encoded Key and `{codeFromUrl}` with your Authorization Code:

    ```bash
    curl --location 'https://account-d.docusign.com/oauth/token' \
    --header 'Authorization: Basic {encodedKey}' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'code={codeFromUrl}' \
    --data-urlencode 'grant_type=authorization_code'
    ```

    The response will contain your Access Token.

Remember to replace `{IntegrationKey:SecretKey}`, `{iKey}`, `{redirectUri}`, `{encodedKey}`, and `{codeFromUrl}` with your actual values.

## Quickstart

This sample demonstrates a scenario of creating an user in an organization and retrieves the information about the user.

### Step 1: Import the package

Import the `ballerinax/docusign.dsadmin` package into your Ballerina project.

```ballerina
import ballerinax/docusign.dsadmin;
```

### Step 2: Instantiate a new connector

Create a `dsadmin:ConnectionConfig` with the obtained OAuth2.0 tokens and initialize the connector with it.

```ballerina
configurable string accessToken = ?;

dsadmin:ConnectionConfig connectionConfig = {
    auth: {
        token: accessToken
    }
};

public function main() returns error? {
    dsadmin:Client docuSignClient = check new(
        config = connectionConfig
    );
}
```

### Step 3: Invoke the connector operation

You can now utilize the operations available within the connector.

```ballerina
public function main() returns error? {
    dsadmin:Client docusignClient = ...// Initialize the DocuSign Click connector;

    dsadmin:OrganizationsResponse orgResponse = check docuSignClient->/v2/organizations();
    io:println("Organizations: ", orgResponse);

    dsadmin:OrganizationResponse[]? organizations = orgResponse.organizations;
    if organizations !is dsadmin:OrganizationResponse[] {
        io:println("Error: organizations not found");
        return;
    }
    dsadmin:OrganizationResponse organization = organizations[0];
    dsadmin:NewUserResponse newUserResponse = check docuSignClient->/v2/organizations/[<string>organization.id]/users.post(
        {
            user_name: "user1",
            first_name: "name1",
            email: "user1@docusignmail.com",
            accounts: [
                {
                    id: accountId,
                    company_name: "Company"
                }
            ]
        }
    );
    io:println("New user created: ", newUserResponse);
}
```

## Examples

The DocuSign Admin connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples).

1. [Manage User Information with DocuSign Admin](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/manage-user-information)
    This example shows how to use DocuSign Admin APIs to to create users and retrieve user informations related to eSignature tasks.

2. [View Permissions in User Accounts](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations)
    This example shows how to use DocuSign Admin APIs to to view permission details of the user accounts.