# Manage user information with DocuSign Admin

This Ballerina program demonstrates the integration of the DocuSign Admin API to create a new user within an organization and retrieve information about that user. The example covers fetching organizations, creating a new user, and retrieving user details.

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
