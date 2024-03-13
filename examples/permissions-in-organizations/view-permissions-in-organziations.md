# Access permissions in user accounts

This guide demonstrates the integration of the DocuSign Admin API in a Ballerina application to manage organizations, users, permissions, and groups. The example covers fetching organizations, creating a new user, retrieving user information, fetching permission profiles, and obtaining groups associated with an account.

## Prerequisites

Follow the guidelines in the [setup guide](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin?tab=readme-ov-file#setup-guide) to get access to DocuSign APIs.

### Configuration

Configure DocuSign API credentials in Config.toml in the example directory.

```toml
accountId = "<ACCOUNT_ID>"
userId = "<USER_ID>"
clientId = "<CLIENT_ID>"
clientSecret = "<CLIENT_SECRET>"
refreshToken = "<REFRESH_TOKEN>"
refreshUrl = "<REFRESH_URL>"
```

## Run the example

Execute the following command to run the example.

```ballerina
bal run
```
