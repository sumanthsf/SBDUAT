public with sharing class YAccountCtrl91 {
    public static List<SBQQ__Quote__c> getYAcctCtrl91() {
        return [select id, SBQQ__LineItemCount__c, (Select id, SBQQ__ProductName__c from SBQQ__LineItems__r),SBQQ__Opportunity2__r.name,SBQQ__Opportunity2__r.Bill_To__c from SBQQ__Quote__c LIMIT 3];
    }
}