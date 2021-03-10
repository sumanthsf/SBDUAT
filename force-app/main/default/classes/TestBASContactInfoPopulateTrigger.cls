@isTest
private class TestBASContactInfoPopulateTrigger {
    /*static testMethod void  BASContactInfoPopulateTest(){
    
         Set<ID>oppIdSet = new Set<ID>();
         Set<ID> accountIdSet = new Set<ID>();

         Account acc = new Account();
         acc.Name = 'Polo Inc';
         acc.Business_Type__c = 'Developer/Publisher';
         acc.PlayStation_3__c =  true;
         acc.PlayStation_4__c = true;

         acc.PlayStation_Vita__c = false;
         insert acc;
         acc.PlayStation_Vita__c = false;
         accountIdSet.add(acc.Id);
         opportunity opportObj = new Opportunity();
         opportObj.Name = 'Test Oppty';

         opportObj.account = acc;
         opportObj.Base_Title__c = 'Title Base Test';
         opportObj.platform__c = 'PS3';
         opportObj.Status_Notes__c = 'Test Status Notes';
         opportObj.description = 'Test description';

         opportObj.StageName = 'NDA';
         opportObj.Platform_Type__c = 'PlayStation®4';
         opportObj.closeDate = date.parse('12/27/2009');
         opportObj.RecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Opportunity'and Name = 'SBD'];

         insert opportObj;
         //oppIdSet.add(opportObj.Id);
         
         
        Contact c = new Contact();
         c.FirstName = 'Test FristName';
         c.LastName = 'Test LastName';

         c.Department = 'Test Department';
         c.Email ='Test@test.com';
         c.Phone = '333000';
         c.account = acc;
         c.account.BillingCity = 'Test City';
         c.Contact_Type__c = 'Business';

         c.account.BillingState = 'Test state';
         c.account.BillingCountry = 'Test country';
         insert c;
         
         List<project_cloud__Project__c> ProjectObjList = new List<project_cloud__Project__c>();
         
         project_cloud__Project__c projcloudObj = new  project_cloud__Project__c();
         projcloudObj.Name ='Test Project';
         projcloudObj.SDK__C = 'PS3 Native';
         projcloudObj.Opportunity__c = opportObj.Id;

         ProjectObjList.add(projcloudObj);
         insert projcloudObj; 
         
         CAS_BAS__C CB = new CAS_BAS__C();
         List<CAS_BAS__C> CBList = new List<CAS_BAS__C>();
         CB.Opportunity_Name__C = opportObj.ID;

         if(c!=null){
         CB.Phone__C = c.Phone;
         CB.Email__C = c.Email;
         CB.Base_Title__c = opportObj.Base_Title__C;
         CB.Platform__C = opportObj.Platform__C;
         CB.Status_Notes__C = opportObj.Status_Notes__C;
                  
          CB.Name_Of_Contact__c = c.FirstName + ' '+ c.LastName;
         CB.Account_Name__c = c.account.name; 
         CB.Department__c = c.Department;
         CB.State__c = c.account.BillingState;

         CB.City__c = c.account.BillingCity;
         CB.Country__c = c.account.BillingCountry;
         CB.SDK__C = projcloudObj.SDK__C;
         oppIdSet.add(opportObj.Id);
         CBList.add(CB);
         }
         try

         {

          insert CBList;
         }
                  
         
        catch(System.DMLException e)
        {
         System.assertEquals(CB.Email__C,c.Email);
         system.debug(e.getMessage());

        }
    

         
        }*/
        }