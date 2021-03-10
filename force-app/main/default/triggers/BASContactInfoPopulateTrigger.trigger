trigger BASContactInfoPopulateTrigger on CAS_BAS__c (before insert,before update) {
  /*Set<String> oppIdSet = new Set<String>();
     Set<ID> accountIdSet = new Set<ID>();
            for(CAS_BAS__c CB : trigger.new) {

                 if(CB.Opportunity_Name__c != null){
                 oppIdSet.add(CB.Opportunity_Name__c);
                 }
     }
            
                         List<Opportunity> opportunityObj = new List<Opportunity>();

                         try{
                         opportunityObj = [SELECT Id, Name,opportunity.accountid,account.name,Base_Title__c,platform__c,Status_Notes__c,Description FROM Opportunity where Id in :oppIdSet];
                         for(CAS_BAS__c CB : trigger.new){

                         for(opportunity opty : opportunityObj){
                         system.debug('opportunity id:' + opty.accountid);
                         accountIdSet.add(opty.accountId);
                         CB.Base_Title__c = opty.Base_Title__c;

                         CB.Platform__c = opty.Platform__c;
                         CB.Status_Notes__c = opty.Status_Notes__c;
                         CB.Description_Service_Outline__c = opty.Description;
                         CB.Account_Name__c = opty.account.name;
                         }
                         }
                         }

                         catch(Exception ex){
                         System.debug(ex.getMessage());
                         }
                         /*Project record fetch
                         List<project_cloud__Project__c> ProjectObj = new List<project_cloud__Project__c>();

                         try{
                         ProjectObj = [SELECT Id,Title_ID__c,Name,SDK__c FROM Project_cloud__Project__c where opportunity__c in :oppIdSet];
                         for(CAS_BAS__c CB : trigger.new){

                         for(project_cloud__Project__c project : ProjectObj){
                         system.debug('ProjectObj id:' + project.SDK__C);
                         CB.SDK__c = project.SDK__c;
                         CB.Title_ID__c = project.Title_ID__c;

                         }
                         }
                         }*/
                         /*catch(Exception ex){
                         System.debug(ex.getMessage());
                         }*/

                    /*     Contact c = null;
                         try{             
                          c = [select FirstName,LastName,Department,Email,Phone,contact.account.name,contact.account.BillingCity,contact.account.BillingState,contact.account.BillingCountry from contact where contact.accountid in :accountIdSet AND contact_Type__C =: 'Business'];

                         }
                         catch(Exception ex){
                         c = null;
                         }if(c!=null){
                         for(CAS_BAS__c CB : trigger.new){

                         CB.Phone__c = c.Phone;
                         CB.Email__c = c.Email;
                         //CB.Account_Name__c = c.account.name; 
                         CB.Department__c = c.Department;

                         system.debug(c.Department);
                         CB.State__c = c.account.BillingState;
                         CB.City__c = c.account.BillingCity;
                         CB.Country__c = c.account.BillingCountry;

                         CB.Name_Of_Contact__c = c.FirstName + ' '+ c.LastName;
                         }
                         }*/
                         }