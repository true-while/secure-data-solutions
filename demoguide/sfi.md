[comment]: <> (please keep all comment items at the top of the markdown file)
[comment]: <> (please do not change the ***, as well as <div> placeholders for Note and Tip layout)
[comment]: <> (please keep the ### 1. and 2. titles as is for consistency across all demoguides)
[comment]: <> (section 1 provides a bullet list of resources + clarifying screenshots of the key resources details)
[comment]: <> (section 2 provides summarized step-by-step instructions on what to demo)


[comment]: <> (this is the section for the Note: item; please do not make any changes here)
***
### SFI

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
1. XXXX

</div>

***
### 1. Demo scenario

XXXXXXX




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

## Purpose of the template

Latest changes in MCAPS subscription required provisioning resources with disabled public access. The following template will help you quickly provision your sandbox subscription compliant with SFI requirements.

Provisioned services can stay in your subscription safely for a long time and could be a base for your custom demonstration.  

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/schema.png" title="schema">


## Provisioned resources

1. Open provisioned resource group. 
2. Following services should be deployed.
- Azure Storage account
- Cosmos DB account and database
- Azure SQL server and database
- Azure Key Vault 

<img src="https://raw.githubusercontent.com/true-while/sfi-mcaps/refs/heads/main/demoguide/img/rg.png" title="Rg List">


## Storage Account Demonstration

1. From the provisioned resource group open storage account.
2. Navigate to the `Networking` settings and confirm that network perimter connoted.
3. Create new container and upload file to the container. Make sure that file is visible from Azure portal.

## KeyVault demonstrator



## Cosmos DB demonstration



## SQL Server Demonstration

