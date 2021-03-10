public class OpportunityManagement {
public OpportunityManagement (){}
 /* public static void afterOpportunityInsert (List<Opportunity> opptyList) {
    updatePlatform(opptyList);
  }
  public static void updatePlatform (List<Opportunity> opptyList) {
    Set<Id> accountIdSet = new Set<Id>();
    for (Opportunity opp : opptyList) {
      accountIdSet.add(opp.AccountId);
    }
    List<Platform__c> pltformListUpdate = new List<Platform__c>();
    List<Platform__c> pltformList = [select Id, Platform_Type__c, Account__c 
                                     from Platform__c
                                     where Account__c in :accountIdSet];
    for (Opportunity opp : opptyList) {
      for(Platform__c pltfrm : pltformList) {       
        if (opp.Platform_Type__c == pltfrm.Platform_Type__c 
          && opp.AccountId == pltfrm.Account__c) {
          pltfrm.Opportunity__c = opp.Id;
          pltformListUpdate.add(pltfrm);
        }
      }
    }
    Database.update(pltformListUpdate);
  }*/
}