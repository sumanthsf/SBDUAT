@isTest
private class AccountManagementTest{

static testMethod void createPlatformRecord_Test() {
    AccountManagement am = new AccountManagement();
}
    /*
static testMethod void createPlatformRecord_Test() {
    List<Account> accList = new List<Account>();
    Map<Id, Account> oldAccMap = new Map<Id,Account>();
    Account acc = new Account();
    acc.Name = 'Polo Inc1';
    acc.Business_Type__c = 'Developer/Publisher';
    acc.PlayStation_3__c =  true;
    acc.PlayStation_4__c = true;
    acc.PlayStation_Vita__c = false;
    acc.service_provider__c = true;
    accList.add(acc);
    insert accList;
    AccountManagement.createPlatformRecord(accList,null);
    acc.PlayStation_Vita__c = true;
    acc.Middleware__c = true;
    acc.Education__c = true;
    update accList;
    List<Platform__c> platformList = [select Id, Name
                                      from Platform__c
                                      where Account__c = :acc.Id];
    oldAccMap.put(acc.Id,acc);     
    AccountManagement.createPlatformRecord(accList,oldAccMap);
    
    
    
    
 }
  static testMethod void developerPublisherUpdate_Test(){
    List<Account> accList = new List<Account>();
    Account acc = new Account();
    acc.Name = 'Polo Inc';
    acc.Business_Type__c = 'Developer/Publisher';
    acc.PlayStation_3__c =  true;
    acc.PlayStation_4__c = true;
    acc.PlayStation_Vita__c = true;
    acc.Middleware__c = true;
    acc.Education__c = true;
    acc.service_provider__c = true;
    accList.add(acc);
    insert accList;
    AccountManagement.developerPublisherUpdate(accList);
    Account acct = new Account();
    Platform__c pltform = new Platform__c();
    pltform.Account__c = acc.Id;
    pltform.Platform_Type__c = 'PLAYSTATION_VITA';
    pltform.License_Type__c = 'Developer';
    acct.Name = 'Cadbury';
    acc.Business_Type__c = 'Developer';
    acct.PlayStation_3__c =  false;
    acct.PlayStation_4__c = false;
    acct.PlayStation_Vita__c = true;
    acct.Education__c = true;
    acct.service_provider__c = true;
    accList.add(acct);
    upsert accList;
    acc.Business_Type__c = 'publisher';
    acct.PlayStation_3__c = true;
    acct.PlayStation_4__c = true;
    acct.PlayStation_Vita__c = true;
    acct.service_provider__c = true;
    update acct;
    update accList;
    AccountManagement.developerPublisherUpdate(accList);
    Account acc1 = new Account();
    Platform__c plt = new Platform__c();
    plt.Account__c = acc.Id;
    plt.Platform_Type__c = 'PLAYSTATION_4';
    
    plt.License_Type__c = 'Developer';
    acc1.Name = 'Cadbury';
    acc1.Business_Type__c = 'Developer';
    acc1.PlayStation_3__c =  false;
    acc1.PlayStation_4__c = false;
    acc1.PlayStation_Vita__c = true;
    acc1.Middleware__c = true;
    acc1.Education__c = true;
    acc1.service_provider__c = true;
    accList.add(acc1);
    upsert accList;
    acc.Business_Type__c = 'publisher';
    acc1.PlayStation_3__c = true;
    acc1.PlayStation_4__c = true;
    acc1.PlayStation_Vita__c = true;
    acc1.service_provider__c = true;
    update acc1;
    update accList;
    AccountManagement.developerPublisherUpdate(accList);
     Account acc2 = new Account();
    Platform__c plt1 = new Platform__c();
    plt1.Account__c = acc.Id;
    plt1.Platform_Type__c = 'PLAYSTATION_3';
    plt1.License_Type__c = 'Developer';
    acc2.Name = 'Cadbury';
    acc2.Business_Type__c = 'Developer';
    acc2.PlayStation_3__c =  false;
    acc2.PlayStation_4__c = false;
    acc2.PlayStation_Vita__c = true;
    acc2.Education__c = true;
    acc2.Middleware__c = true;
    acc2.service_provider__c = true;
    accList.add(acc2);
    upsert accList;
    acc2.Business_Type__c = 'publisher';
    acc2.PlayStation_3__c = true;
    acc2.PlayStation_4__c = true;
    acc2.PlayStation_Vita__c = true;
    acc2.service_provider__c = true;
    update acc2;
    update accList;
    AccountManagement.developerPublisherUpdate(accList);

}*/
}