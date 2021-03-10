public with sharing class OpportunityManagementTest {
    
    static testMethod void updatePlatformRecord_Test() {
        OpportunityManagement op = new OpportunityManagement();
    }
    
   /* static testMethod void updatePlatformRecord_Test() {
    List<Account> accList = new List<Account>();
    Account acc = new Account();
    acc.Name = 'Polo Inc';
    acc.Business_Type__c = 'Developer/Publisher';
    acc.PlayStation_3__c =  true;
    acc.PlayStation_4__c = true;
    acc.PlayStation_Vita__c = false;
    accList.add(acc);
    
    insert accList;
    
    
    
    
    Opportunity opp = new Opportunity();
    opp.Name = acc.Name + 'PS3';
    opp.Description  = 'Test opportunity';
    opp.Account = acc;
    opp.Base_Title__C = 'Test Base title';
    opp.Platform_Type__c = 'PlayStation®3';
    opp.CloseDate =  date.today().addDays(150);
    opp.StageName= 'Technical Evaluation';
    insert opp;
    
        
    List<opportunity> oppList = new List<opportunity>();
    oppList.add(opp);
    OpportunityManagement.afterOpportunityInsert(oppList); 
      
       
    /*List<Platform__c> platformList = [select Id,Platform_Type__c,Name, Opportunity__c 
                                      from Platform__c
                                      where Account__c = :acc.Id];*/
                                  
                                      
                                    
    
 /* }*/

}