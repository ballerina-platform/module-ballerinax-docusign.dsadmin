## Examples

The DocuSign Admin connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples).

1. [Manage user information with DocuSign Admin](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/manage-user-information)
    This example shows how to use DocuSign Admin API to to create users and retrieve user informations related to eSignature tasks.

2. [Access permissions in user accounts](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/tree/main/examples/permissions-in-organizations)
    This example shows how to use DocuSign Admin API to to view permission details of the user accounts.

## Prerequisites

1. Follow the [instructions](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin#set-up-guide) to set up the DocuSign Admin API.

2. For each example, create a `Config.toml` file with your OAuth2 tokens, client ID, and client secret. Here's an example of how your `Config.toml` file should look:

    ```toml
    clientId="<Client ID>"
    clientSecret="<Client Secret>"
    refreshToken="<Refresh Token>"
    refreshUrl="<Refresh URL>"
    accountId = "<Account ID>"
    ```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
