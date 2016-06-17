# SLDS-Dynamic-Lookup-Component
A package with a component that can be easily used to create lookup fields on VF page using Salesforce Lightning Design System(SLDS)   

Author [Lakshay Katney](http://blog.lkatney.com/about/)
  
## Setup
1. This repo is ready to deploy package in any Salesforce organization. Use any metadata tool to deploy it
2. There is an unmanaged version of this package too. Use below links to install it
[Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t280000003L0R) [Production/Developer](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t280000003L0R)

## Usage
On VF page, just add a static resource and component with appropriare attributes

**Static Resource**
```
<apex:includeScript value="{!$Resource.SLDSDynamicLookupScript}"/>
```

**Component Usage**
<c:SLDSDynamicLookup SLDSResourceName="{!$Resource.SLDS}" ObjectApiName="User" DisplayFieldApiNames="Username,Name" DisplayFieldsPattern="Name - Username"  photo="field->smallPhotoUrl" LabelName="Set User" SetValueToField="{!con.OwnerId}"/>
```

## Attributes Usage

SLDSResourceName(required): Attribute in which name of your static resource to be passed which contains Salesforce Lightning Design System(SLDS)  
ObjectApiName(required): Api name of component on which search should happen


| Attribute     	| Requirement   	| Description  	|
| ----------------- |:-----------------:| -------------:|
| SLDSResourceName  | required 			| $1600 		|
| col 2 is      	| centered      	|   $12 		|
| zebra stripes 	| are neat      	| $1    		|
