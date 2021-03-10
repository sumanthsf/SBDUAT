@isTest
private class LeadManagementTest {
    static testMethod void createOpportunityOnLeadConvert_Test() {
        LeadManagement lm = new LeadManagement();
    }

  /*static testMethod void createOpportunityOnLeadConvert_Test() {
    List<Lead> listLead = new List<Lead>();
    Lead ld = new Lead();
    ld.FirstName = 'Debarshi';
    ld.LastName = 'Barat';
    ld.Title = 'Developer';
    ld.Email = 'xxx@cccc.com';
    ld.Company = 'Polo Inc';
    ld.Area_Of_Interest__c = 'Non Game App';       
    ld.Business_Type__c = 'Publisher';
    ld.PlayStation3__c = true;
    ld.PlayStation4__c = true;
    ld.PlayStation_Vita__c = true;
    ld.App_Type__c = 'Non Game';
    ld.Status = 'Licensed';
    ld.Non_Game_App_Type__c = 'Communication';
    ld.Same_Secondary_Contact__c = false;
    ld.Secondary_Contact_First_Name__c = 'Shruti';
    ld.Secondary_Contact_Last_Name__c = 'Paranjape';
    ld.Secondary_Contact_Job_Title__c = 'IT Manager';
    ld.Secondary_Contact_Phone__c = '3109908324';
    ld.Secondary_Contact_Email__c = 'xyz@yahoo.com';
    ld.Secondary_Contact_Fax__c = '2020202022';
    
    insert ld;
    listLead.add(ld);
    
    /*Code added by Preetu: 11/11/2013 to increase code coverage */
     
   /* Database.LeadConvert lc = new Database.LeadConvert();
    lc.setLeadId(ld.Id);
    lc.setConvertedStatus('Technical Evaluation');
    lc.setDoNotCreateOpportunity(true);
    Database.LeadConvertResult lcr = Database.convertLead(lc);
    /*List<Opportunity> oppList = [select Id, Name
                                 from Opportunity
                                 where AccountId = :lcr.getAccountId()];
  
    System.AssertEquals(3, oppList.size());
    
    List<Contact> contList = [select Id, Name from Contact
                                 where AccountId = :lcr.getAccountId()];
    System.AssertEquals(2, contList.size());*/
  /*  LeadManagement.createOpportunityOnLeadConvert(listLead);
    
    
    
    LeadManagement.createOpportunityOnLeadConvert(listLead);
     
   
    
     
    }
    
  
    static testMethod void createSecondaryContactOnLeadConvert_Test(){
    List<Lead> listLead = new List<Lead>();
    Lead ld = new Lead();
    ld.FirstName = 'Debarshi';
    ld.LastName = 'Barat';
    ld.Title = 'Developer';
    ld.Email = 'xxx@cccc.com';
    ld.Company = 'Polo Inc';
    ld.Area_Of_Interest__c = 'Non Game App';       
    ld.Business_Type__c = 'Publisher';
    ld.PlayStation3__c = true;
    ld.PlayStation4__c = true;
    ld.PlayStation_Vita__c = true;
    ld.App_Type__c = 'Non Game';
    ld.Non_Game_App_Type__c = 'Communication';
    ld.Same_Secondary_Contact__c = false;
    ld.Secondary_Contact_First_Name__c = 'Shruti';
    ld.Secondary_Contact_Last_Name__c = 'Paranjape';
    ld.Secondary_Contact_Job_Title__c = 'IT Manager';
    ld.Secondary_Contact_Phone__c = '3109908324';
    ld.Secondary_Contact_Email__c = 'xyz@yahoo.com';
    ld.Secondary_Contact_Fax__c = '2020202022';
    insert ld;
    LeadManagement.createSecondaryContactOnLeadConvert(listLead);
  }
  */
}