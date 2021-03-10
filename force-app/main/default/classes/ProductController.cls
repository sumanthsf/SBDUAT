public class ProductController {
    public ProductController(){}
   /* @AuraEnabled
    public static  List<OpportunityLineItem> getTasks(){
        List<OpportunityLineItem> result =  [SELECT Id,AdSales_FF_CSM_Name__c,AdSales_FF_Account_Name__c,OpportunityId,CreatedDate,Product2Id,Product2.Name,Opportunity.StageName,Opportunity.Owner.Name,Opportunity.Name,Opportunity.Id,AdSales_CF_Start_Date__c,AdSales_CF_End_Date__c FROM OpportunityLineItem WHERE Product2.AdSales_CF_Cost_Model__c='Flat Rate' ];
        return result; 
    } */
}