[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
### Secure Azure Data Solutions

<div style="background: lightgreen; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** Below demo steps should be used **as a guideline** for doing your own demos. Please consider contributing to add additional demo steps.
</div>

[comment]: <> (this is the section for the Tip: item; consider adding a Tip, or remove the section between <div> and </div> if there is no tip)

<div style="background: lightblue; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Tip:** 
This template provides essential configuration for your demos but does not load it with data. You can configure provisioned services for your demos manually. The environment can stay in your subscription for a long time and provide access to your custom demos.
</div>

***
### 1. Demo scenario

Latest security changes in Azure subscription required provisioning resources without public access. The following template will help you quickly provision your sandbox resources compliant with security requirements such as:
 - no public access
 - no access with keys
 - no SQL authentication
 - no anonymous access
 - only RBAC managed access integrated with Entra platform.

Following services will be provisioned and protected from public access:

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/schema.png" title="schema" style="width:70%;">

Provisioned services can stay in your subscription safely for a long time and could be a base for your custom demonstration. Because of the low cost you do not need to delete those services after delivery. 


## 2. Provisioned resources

1. Open provisioned resource group. 

2. The following services should be deployed:
- Azure Storage account (ADLS)
- Cosmos DB account and database
- Azure SQL server and database
- Azure Key Vault 

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/rg.png" title="Rg List" style="width:70%;">


## 3. Storage Account Demonstration

1. From the provisioned resource group open storage account.
2. Navigate to the `Networking` settings and confirm that network perimeter connoted.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/storage-networking.png" title="networking for storage account" style="width:50%;">

3. Create new container and upload file to the container. Make sure that file is visible from Azure portal.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/storage-test.png" title="test for storage account" style="width:50%;">

## 4. KeyVault demonstrator

1. From the provisioned resource group open provisioned key vault.

2. Navigate to the `Networking` settings and confirm that public access is disabled.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/keyvault-networking.png" title="networking for keyvault" >

3. Create a new key to make sure that access allowed to your IP and RBAC configured to let you manage keys.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/keyvault-test.png" title="test for keyvault" style="width:70%">

## 5. Cosmos DB demonstration

1. From the provisioned resource group open provisioned Cosmos DB.

2. Navigate to the `Networking` settings and confirm that public access is disabled.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/cosmos-netwokring.png" title="networking for cosmos db" style="width:70%">

3. Navigate to Test container and create a new document. Check if you get permission and connection allowed by firewall.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/cosmos-test.png" title="test for cosmos db" style="width:70%">

## 6. SQL Server Demonstration

1. From the provisioned resource group open provisioned SQL Server and look up for SQL DB.

2. Navigate to the provisioned database and select `Firewall` settings and confirm that public access is disabled. If it doesn't disabled you can disabled it manual. 

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/sql-networking.png" title="networking for sql db" style="width:50%">

3. Open `Query Editor` and signing with your Entra ID account. You can observe the list of views to make sure you have access to the objects and doesn't blocked by firewall.

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/sql-test.png" title="test for sql db" style="width:50%">


[comment]: <> (this is the closing section of the demo steps. Please do not change anything here to keep the layout consistent with the other demoguides.)
<br></br>
***
<div style="background: lightgray; 
            font-size: 14px; 
            color: black;
            padding: 5px; 
            border: 1px solid lightgray; 
            margin: 5px;">

**Note:** This is the end of the current demo guide instructions.
</div>


