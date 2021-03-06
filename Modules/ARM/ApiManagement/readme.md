# Api Management

This module deploys an API management.

## Resource types

| Resource Type | Api Version |
| :-- | :-- |
| `Microsoft.ApiManagement/service/providers/diagnosticsettings` | 2017-05-01-preview |
| `Microsoft.ApiManagement/service` | 2020-06-01-preview |
| `Microsoft.Resources/deployments` | 2020-06-01 |
| `providers/locks` | 2016-09-01 |

### Resource dependency

The following resources are required to be able to deploy this resource.

- *None*

## Parameters

| Parameter Name | Type | Default Value | Possible values | Description |
| :-- | :-- | :-- | :-- | :-- |
| `additionalLocations` | array | System.Object[] |  | Optional. Additional datacenter locations of the API Management service. |
| `apiManagementServiceName` | string |  |  | Required. The name of the of the Api Management service. |
| `certificates` | array | System.Object[] |  | Optional. List of Certificates that need to be installed in the API Management service. Max supported certificates that can be installed is 10. |
| `cuaId` | string |  |  | Optional. Customer Usage Attribution id (GUID). This GUID must be previously registered |
| `customProperties` | object |  |  | Optional. Custom properties of the API Management service. |
| `diagnosticLogsRetentionInDays` | int | 365 |  | Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely. |
| `diagnosticStorageAccountId` | string |  |  | Optional. Resource identifier of the Diagnostic Storage Account. |
| `disableGateway` | bool | False |  | Optional. Property only valid for an Api Management service deployed in multiple locations. This can be used to disable the gateway in master region. |
| `enableClientCertificate` | bool | False |  | Optional. Property only meant to be used for Consumption SKU Service. This enforces a client certificate to be presented on each request to the gateway. This also enables the ability to authenticate the certificate in the policy on the gateway. |
| `eventHubAuthorizationRuleId` | string |  |  | Optional. Resource ID of the event hub authorization rule for the Event Hubs namespace in which the event hub should be created or streamed to. |
| `eventHubName` | string |  |  | Optional. Name of the event hub within the namespace to which logs are streamed. Without this, an event hub is created for each log category. |
| `hostnameConfigurations` | array | System.Object[] |  | Optional. Custom hostname configuration of the API Management service. |
| `identity` | object |  |  | Optional. Managed service identity of the Api Management service. |
| `location` | string | [resourceGroup().location] |  | Optional. Location for all Resources. |
| `lockForDeletion` | bool | False |  | Optional. Switch to lock Key Vault from deletion. |
| `minApiVersion` | string |  |  | Optional. Limit control plane API calls to API Management service with version equal to or newer than this value. |
| `notificationSenderEmail` | string | apimgmt-noreply@mail.windowsazure.com |  | Optional. The notification sender email address for the service. |
| `publisherEmail` | string |  |  | Required. The email address of the owner of the service. |
| `publisherName` | string |  |  | Required. The name of the owner of the service. |
| `restore` | bool | False |  | Optional. Undelete Api Management Service if it was previously soft-deleted. If this flag is specified and set to True all other properties will be ignored. |
| `sku` | string | Developer | System.Object[] | Optional. The pricing tier of this Api Management service. |
| `skuCount` | string | 1 | System.Object[] | Optional. The instance size of this Api Management service. |
| `subnetResourceId` | string |  |  | Optional. The full resource ID of a subnet in a virtual network to deploy the API Management service in. |
| `tags` | object |  |  | Optional. Tags of the resource. |
| `virtualNetworkType` | string | None | System.Object[] | Optional. The type of VPN in which API Management service needs to be configured in. None (Default Value) means the API Management service is not part of any Virtual Network, External means the API Management deployment is set up inside a Virtual Network having an Internet Facing Endpoint, and Internal means that API Management deployment is setup inside a Virtual Network having an Intranet Facing Endpoint only. |
| `workspaceId` | string |  |  | Optional. Resource identifier of Log Analytics. |
| `zones` | array | System.Object[] |  | Optional. A list of availability zones denoting where the resource needs to come from. |

### Parameter Usage: `tags`

Tag names and tag values can be provided as needed. A tag can be left without a value.

```Json
"tags": {
    "value": {
        "Environment": "Non-Prod",
        "Contact": "test.user@testcompany.com",
        "PurchaseOrder": "1234",
        "CostCenter": "7890",
        "ServiceName": "DeploymentValidation",
        "Role": "DeploymentValidation"
    }
}
```

## Outputs

| Output Name | Type | Description |
| :-- | :-- | :-- |
| `apimServiceName` | string | The Api Management Service Name |
| `apimServiceResourceGroup` | string | The name of the Resource Group with the Api Management Service |
| `apimServiceResourceId` | string | The Resource Id of the Api Management Service |

## Considerations

- *None*

## Additional resources

- [Use tags to organize your Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-using-tags)
- [Azure Resource Manager template reference](https://docs.microsoft.com/en-us/azure/templates/)
- [Deployments](https://docs.microsoft.com/en-us/azure/templates/Microsoft.Resources/2020-06-01/deployments)
- [Service](https://docs.microsoft.com/en-us/azure/templates/Microsoft.ApiManagement/2020-06-01-preview/service)