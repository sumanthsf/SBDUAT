public class LeadManagement {
public LeadManagement (){}
 /* public static void beforeLeadUpdate(List<Lead> leadList) {
    createOpportunityOnLeadConvert(leadList);
    createSecondaryContactOnLeadConvert(leadList);
  }
  
  public static void createOpportunityOnLeadConvert(List<Lead> leadList){
    List<Opportunity> opportunityList = new List<Opportunity>();
    for(Lead ld : leadList) {
        System.Debug('!!!!!!!!!!!!' + ld.Area_Of_Interest__c);
         System.Debug('Lead Status!' + ld.status);
        // following if condition added by Shruti 05/30/2013 to set Oppty Stage based on recordtype
        if(ld.Status != 'Licensed'){  
           System.Debug('Inside if' + ld.status);
         if (ld.Area_Of_Interest__c != 'TOOLS' && 
          ld.Area_Of_Interest__c != 'UNIVERSITY' &&
          ld.Area_Of_Interest__c != 'GAMES') {
        if(ld.IsConverted) {
            if (ld.PlayStation3__c) {
              Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            
            oppty.LeadSource = ld.LeadSource;
            oppty.Name = ld.Company + ' PS3';
            oppty.CloseDate = System.today().addDays(365);
            oppty.StageName = 'Technical Evaluation';
            oppty.description = 'Test description';
            /*oppty.App_Type__c = ld.App_Type__c;
            
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
            oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;*/
         /*   oppty.Platform_Type__c = 'PlayStation®3';
            opportunityList.add(oppty);
          }
          if (ld.PlayStation4__c) {
            Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            oppty.LeadSource = ld.LeadSource;
            oppty.Name = ld.Company + ' PS4';
            oppty.CloseDate = System.today().addDays(365);
            oppty.StageName = 'Technical Evaluation';
            oppty.description = 'Test description';
            /*oppty.App_Type__c = ld.App_Type__c;
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
            oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;
            oppty.Platform_Type__c = 'PlayStation®4';*/
        /*    opportunityList.add(oppty);
          }
          if (ld.PlayStation_Vita__c) {
            Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            oppty.description = 'Test description';
            /*oppty.LeadSource = ld.LeadSource;
            oppty.Name = ld.Company + ' PS Vita';
            oppty.CloseDate = System.today().addDays(365);
            oppty.StageName = 'Technical Evaluation';
            oppty.App_Type__c = ld.App_Type__c;
            
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
              oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;
            oppty.Platform_Type__c = 'PlayStation®Vita';*/
        /*    opportunityList.add(oppty);
          }
        }
        }
    
    } else {  
          System.Debug('Inside Else!' + ld.status);
       if (ld.PlayStation3__c) {
              Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            oppty.LeadSource = ld.LeadSource;
            oppty.Name = ld.Company + ' PS3';
            oppty.description = 'Test description';
            oppty.CloseDate = System.today().addDays(365);
            oppty.StageName = 'Assessment/ Org Mapping';
           /* oppty.App_Type__c = ld.App_Type__c;
            
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
            oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;*/
     /*       oppty.Platform_Type__c = 'PlayStation®3';
            opportunityList.add(oppty);
          }
          if (ld.PlayStation4__c) {
            Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            oppty.LeadSource = ld.LeadSource;
            oppty.description = 'Test description';
            oppty.Name = ld.Company + ' PS4';
            oppty.CloseDate = System.today().addDays(365);
            oppty.StageName = 'Assessment/ Org Mapping';
            /*oppty.App_Type__c = ld.App_Type__c;
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
            oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;
            oppty.Platform_Type__c = 'PlayStation®4';*/
       /*     opportunityList.add(oppty);
          }
          if (ld.PlayStation_Vita__c) {
            Opportunity oppty = new Opportunity();
            oppty.AccountId = ld.ConvertedAccountId;
            //oppty.Base_Title__c = ld.App_Name__c;
            oppty.Base_Title__c = 'Test Base title';
            oppty.LeadSource = ld.LeadSource;
            oppty.Name = ld.Company + ' PS Vita';
            oppty.CloseDate = System.today().addDays(365);
            oppty.description = 'Test description';
            oppty.StageName = 'Assessment/ Org Mapping';
            /*oppty.App_Type__c = ld.App_Type__c;
            
            oppty.App_Video_Type__c = ld.App_Video_Type__c;
            oppty.Consumer_Access__c = ld.Consumer_Access__c;
              oppty.Consumer_Value_Proposition__c = 
              ld.Consumer_Value_Proposition__c;
            oppty.Business_Model__c = ld.Service_Description_Biz_Model__c;
            oppty.Platform_Type__c = 'PlayStation®Vita';*/
      /*      opportunityList.add(oppty);
          }
        }
        } // else added by Shruti 05/30/2013
    
       
    Database.insert(opportunityList);
  }
  public static void createSecondaryContactOnLeadConvert(List<Lead> leadList){
    List<Contact> secondaryContactList = new List<Contact>();
    for (Lead ld : leadList) {
      if (ld.IsConverted) {
        if (!ld.Same_Secondary_Contact__c) {
          Contact secondContact = new Contact(); 
          secondContact.AccountId = ld.ConvertedAccountId;
          if (ld.Secondary_Contact_First_Name__c != null) {
            secondContact.FirstName = ld.Secondary_Contact_First_Name__c;   
          }
          if (ld.Secondary_Contact_Last_Name__c != null) {
            secondContact.LastName = ld.Secondary_Contact_Last_Name__c; 
          }
          if (ld.Secondary_Contact_Job_Title__c != null) {
            secondContact.Title = ld.Secondary_Contact_Job_Title__c;    
          }
          if (ld.Secondary_Contact_Phone__c != null) {
            secondContact.Phone = ld.Secondary_Contact_Phone__c;    
          }
          if (ld.Secondary_Contact_Email__c != null) {
            secondContact.Email = ld.Secondary_Contact_Email__c;    
          } 
          if (ld.Secondary_Contact_Fax__c != null) {
            secondContact.Fax = ld.Secondary_Contact_Fax__c;    
          }
          secondaryContactList.add(secondContact);        
        }       
      }
    }
    Database.insert(secondaryContactList);
  }*/
}