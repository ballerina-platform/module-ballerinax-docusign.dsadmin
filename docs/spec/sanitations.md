# Sanitations for OpenAPI specification

_Authors_: @Nuvindu \
_Reviewers_: @shafreenAnfar @ThisaruGuruge \
_Created_: 2024/03/13 \
_Updated_: 2024/02/13 \
_Edition_: Swan Lake

## Introduction

The Ballerina DocuSign Admin connector facilitates integration with the [DocuSign Admin API](https://developers.docusign.com/docs/admin-api/reference) through the generation of client code using the [OpenAPI specification](https://github.com/ballerina-platform/module-ballerinax-docusign.dsadmin/blob/main/docs/spec/openapi.json). To enhance usability, the following modifications have been applied to the original specification.

1. Response descriptions
Previously, all responses for resource functions were labeled with a generic "Successful Response". This has been revised to "A successful response or an error".

2. Avoid path segments with backslashes
To prevent errors associated with backslashes in the resource path, the functions in the format, `get v2\.1/accounts/.../` have been modified as `get accounts/.../` to avoid broken paths in the API calls.

## OpenAPI cli command

```bash
bal openapi -i docs/spec/openapi.json --mode client -o ballerina
```
