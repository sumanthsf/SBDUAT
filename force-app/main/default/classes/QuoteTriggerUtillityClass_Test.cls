@isTest

private class QuoteTriggerUtillityClass_Test
{
    static testMethod void testQuoteTrigger()
    {
        Account ac = new Account();
        ac.name = 'testAccouunt';
        insert ac;
        
        Contact con1 = new Contact();
        con1.accountid = ac.id;
        con1.lastname = 'testcontact1';
        insert con1;
        
        Contact con2 = new Contact();
        con2.accountid = ac.id;
        con2.lastname = 'testcontact2';
        insert con2;
        
        Opportunity opp = new opportunity();
        opp.accountid = ac.id;
        opp.Name = 'testopp';
        opp.StageName = 'Opportunity Created';
        opp.AdSales_CF_Start_Date__c = date.today();
        opp.Opportunity_End_Date__c = Date.newInstance(2019, 12, 12);
        opp.CloseDate = date.today();
        insert opp;
        
        OpportunityContactRole oppconrole1 = new OpportunityContactRole();
        oppconrole1.ContactId = con1.id;
        oppconrole1.OpportunityId = opp.id;
        oppconrole1.Role = 'Media Contact';
        insert oppconrole1 ;
        
        OpportunityContactRole oppconrole2 = new OpportunityContactRole();
        oppconrole2.ContactId = con2.id;
        oppconrole2.OpportunityId = opp.id;
        oppconrole2.Role = 'Billing';
        insert oppconrole2 ;
        
        SBQQ__Quote__c qt = new SBQQ__Quote__c();
        qt.SBQQ__Opportunity2__c =opp.id;
        insert qt;
        
    }
}