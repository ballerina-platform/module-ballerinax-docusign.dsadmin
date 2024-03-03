## Overview

The Ballerina Docusign Admin Connector efficiently manages DocuSign users and permissions across all your accounts and domains

The Ballerina Docusign Admin module supports [DocuSign Admin API V2](https://github.com/docusign/OpenAPI-Specifications/blob/master/admin.rest.swagger-v2.1.json).

## Setup guide

To utilize the DocuSign Admin connector, you must have access to the DocuSign REST API through a DocuSign account.

### Step 1: Create a DocuSign account

In order to use the DocuSign Admin connector, you need to first create the DocuSign credentials for the connector to interact with DocuSign.

- You can [create an account](https://go.docusign.com/o/sandbox/) for free at the [Developer Center](https://developers.docusign.com/).

    ![Create DocuSign account](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/create-account.png)

### Step 2: Create integration key and secret key

1. **Create an integration key**: Visit the [Apps and Keys](https://admindemo.docusign.com/apps-and-keys) page on DocuSign. Click on `Add App and Integration Key,` provide a name for the app, and click `Create App`. This will generate an `Integration Key`.

    ![Create integration key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/app-and-integration-key.png)

2. **Generate a secret key**: Under the `Authentication` section, click on `Add Secret Key`. This will generate a secret Key. Make sure to copy and save both the `Integration Key` and `Secret Key`.

    ![Add secret key](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/add-secret-key.png)

### Step 3: Generate refresh token

1. **Add a redirect URI**: Click on `Add URI` and enter your redirect URI (e.g., <http://www.example.com/callback>).

    ![Add redirect URI](https://raw.githubusercontent.com/ballerina-platform/module-ballerinax-docusign.dsclick/main/ballerina/resources/add-redirect-uri.png)

2. **Generate the encoded key**: The `Encoded Key` is a base64 encoded string of your `Integration key` and `Secret Key` in the format `{IntegrationKey:SecretKey}`. You can generate this in your web browser's console using the `btoa()` function: `btoa('IntegrationKey:SecretKey')`. You can either generate the encoded key from an online base64 encoder.

3. **Get the authorization code**: Visit the following URL in your web browser, replacing `{iKey}` with your Integration Key and `{redirectUri}` with your redirect URI.

    ```url
    https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation&client_id={iKey}&redirect_uri={redirectUri}
    ```

    This will redirect you to your Redirect URI with a `code` query parameter. This is your `authorization code`.

4. **Get the refresh token**: Use the following `curl` command to get the refresh token, replacing `{encodedKey}` with your Encoded Key and `{codeFromUrl}` with your `authorization code`.

    ```bash
    curl --location 'https://account-d.docusign.com/oauth/token' \
    --header 'Authorization: Basic {encodedKey}' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --data-urlencode 'code={codeFromUrl}' \
    --data-urlencode 'grant_type=authorization_code'
    ```

    The response will contain your refresh token. Use `https://account-d.docusign.com/oauth/token` as the refresh URL.

Remember to replace `{IntegrationKey:SecretKey}`, `{iKey}`, `{redirectUri}`, `{encodedKey}`, and `{codeFromUrl}` with your actual values.

Above is about using the DocuSign Admin API in the developer mode. If your app is ready to go live, you need to follow the guidelines given [here](https://developers.docusign.com/docs/admin-api/go-live/) to make it work.

## Quickstart

To use the DocuSign Click connector in your Ballerina project, modify the `.bal` file as follows.

### Step 1: Import the module

Import the `ballerinax/docusign.dsadmin` module into your Ballerina project.

```ballerina
import ballerinax/docusign.dsadmin;
```

### Step 2: Instantiate a new connector

Create a `dsadmin:ConnectionConfig` with the obtained OAuth2.0 tokens and initialize the connector with it.

```ballerina
configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;

dsadmin:Client docusignClient = check new({
    auth: {
        clientId,
        clientSecret,
        refreshToken,
        refreshUrl
    }
});
```

### Step 3: Invoke the connector operation

You can now utilize the operations available within the connector.

```ballerina
public function main() returns error? {
    dsadmin:Client docusignClient = ...// instantiates the DocuSign Click client

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

### Step 4: Run the Ballerina application

Use the following command to compile and run the Ballerina program.

```bash
bal run
```

## Examples

The DocuSign Admin connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples).

1. [Manage User Information with DocuSign Admin](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/manage-user-information)
    This example shows how to use DocuSign Admin API to to create users and retrieve user informations related to eSignature tasks.

2. [View Permissions in User Accounts](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations)
    This example shows how to use DocuSign Admin API to to view permission details of the user accounts.
