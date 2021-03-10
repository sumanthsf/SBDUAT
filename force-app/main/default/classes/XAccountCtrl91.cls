public with sharing class XAccountCtrl91 {
    public static List<SBQQ__Quote__c> getXAcctCtrl91() {
        // adding a meaningless comment
        return [select id, SBQQ__LineItemCount__c, (Select id, SBQQ__ProductName__c from SBQQ__LineItems__r),SBQQ__Opportunity2__r.name,SBQQ__Opportunity2__r.Bill_To__c from SBQQ__Quote__c];
    }
}