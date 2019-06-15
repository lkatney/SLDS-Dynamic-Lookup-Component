# SLDS-Dynamic-Lookup-Component
A package with a component that can be easily used to create lookup fields on VF page using Salesforce Lightning Design System(SLDS)   

Author [Lakshay Katney](http://blog.lkatney.com/about/)
  
## Setup
1. This repo is ready to deploy package in any Salesforce organization. Use any metadata tool to deploy it
2. There is an unmanaged version of this package too. Use below links to install it  
**[Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t280000003LDx)**
**[Production/Developer](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t280000003LDx)**

## Usage
On VF page, just add a static resource and component with appropriare attributes

**Static Resource**
```
<apex:includeScript value="{!$Resource.SLDSDynamicLookupScript}"/>
```

**Component Usage**
```
<c:SLDSDynamicLookup SLDSResourceName="{!$Resource.SLDS}" ObjectApiName="User" DisplayFieldApiNames="Username,Name" DisplayFieldsPattern="Name - Username"  photo="field->smallPhotoUrl" LabelName="Set User" SetValueToField="{!con.OwnerId}"/>
```

## Attributes Usage

 Attribute     				| Requirement   | Description  																																						
:--------------------------:|:------------:|:--------------------------------
 **SLDSResourceName**  		| Required 		| Attribute in which name of your static resource to be passed which contains Salesforce Lightning Design System(SLDS)												
 **ObjectApiName**     		| Required      | Api name of component on which search should happen.
 **DisplayFieldApiNames**	| Required      | Attribute to get fields Api Names whose value needs to be displayed while searching. These are seperated by comma. For example : 'firstname,lastname'
 **LabelName** 				| Required 		| Attribute to display label along with custom lookup field made by this component
 **SetValueToField** 		| Required 		| Attribute that will tell where to put selected value. Also populates the default value if field has value.
 **DisplayFieldsPattern**	| Optional		| Attribute to get pattern to display value.You can combine two fields with pattern.  For example : 'firstname - lastname'. By default it will take pattern as comma seperated fields
 **photo** 					| Optional 		| Attribute that will tell if photo needs to be added to records while searching.  For fields to be used, pattern should be 'field->fieldAPiName'. For url, pattern should be 'url->pathofimage'
 **FilterOn** | Optional | Attribute that will filter the list of records in results
 **RenderOnComplete** | Optional | Attribute that will run an action function/javascript on complete


## Screenshots

![Demo Page](/images/DemoPage.png "Demo Page")  
![Search](/images/DemoPage.png "Search")  
![Selection](/images/DemoPage.png "Selection")  


## Versions

### Version 1.4
Introduction of dependent lookups
Allow filters on lookups on basis of parent lookup

### Version 1.3    
##### Improvements  
Allow default values to show if passed  

### Version 1.2   
First version to add lookup fields in SLDS styling on Visual force pages  


