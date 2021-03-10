public class AccountManagement {
public AccountManagement (){}
  /*public static final String PLAYSTATION_4 = 'PlayStation®4';
  public static final String PLAYSTATION_VITA = 'PlayStation®Vita';
  public static final String PLAYSTATION_3 = 'PlayStation®3';
  public static final String PLAYSTATION_PSM= 'PlayStation®PSM';
  
  public static void beforeAccountInsert(List<Account> accList) {
    developerPublisherUpdate(accList);  
  }
  public static void beforeAccountUpdate(List<Account> accList) {
    developerPublisherUpdate(accList);  
  }
  
  public static void afterAccountInsert(List<Account> accList) {
    createPlatformRecord(accList, null);    
  }
  
  public static void afterAccountUpdate(
    List<Account> accList, Map<Id, Account> oldAccMap) {
    createPlatformRecord(accList, oldAccMap);   
  }
  
  public static void developerPublisherUpdate(List<Account> accList) {
    for (Account acc : accList) {
        if (acc.Business_Type__c == 'Developer') {
            acc.Developer__c = true;
        }
        if (acc.Business_Type__c == 'Publisher') {
            acc.Publisher__c = true;
        }
        if (acc.Business_Type__c == 'Developer/Publisher') {
            acc.Publisher__c = true;
            acc.Developer__c = true;
        }
    }   
  }
  
  public static void createPlatformRecord(
    List<Account> accList, Map<Id, Account> oldAccMap) {
    List<Platform__c> platformList = new List<Platform__c>();

    for (Account acc : accList) {
        if (acc.Developer__c == true) {
        if (oldAccMap == null) {
          if (acc.PlayStation_4__c) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Developer';
            platformList.add(pltform);
          } 
          if (acc.PlayStation_3__c) {
            Platform__c platform = new Platform__c();
            platform.Account__c = acc.Id;
            platform.Platform_Type__c = PLAYSTATION_3;
            platform.License_Type__c = 'Developer';
            platformList.add(platform);
          }
          if (acc.PlayStation_Vita__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_VITA;
            platfrm.License_Type__c = 'Developer';
            platformList.add(platfrm);
          }
          //Code added by Preetu 1/6/2014 for PSM platform type
          if (acc.PSM__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_PSM;
            platfrm.License_Type__c = 'Developer';
            platformList.add(platfrm);
          } 
        } else if (oldAccMap != null) {
          if ((acc.PlayStation_4__c && !oldAccMap.get(acc.Id).PlayStation_4__c)
            || (acc.PlayStation_4__c && !oldAccMap.get(acc.Id).Developer__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Developer';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_3__c && !oldAccMap.get(acc.Id).PlayStation_3__c)
            || (acc.PlayStation_3__c && !oldAccMap.get(acc.Id).Developer__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_3;
            pltform.License_Type__c = 'Developer';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).PlayStation_Vita__c) 
            || (acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).Developer__c)){
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_VITA;
            pltform.License_Type__c = 'Developer';
            platformList.add(pltform);  
          }
          //Code added by Preetu 1/6/2014 for PSM platform type
          if ((acc.PSM__c && 
            !oldAccMap.get(acc.Id).PSM__c) 
            || (acc.PSM__c && 
            !oldAccMap.get(acc.Id).Developer__c)){
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_PSM;
            pltform.License_Type__c = 'Developer';
            platformList.add(pltform);  
          }
          
        }
        }
        if (acc.Publisher__c == true) {
        if (oldAccMap == null) {
          if (acc.PlayStation_4__c) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Publisher';
            platformList.add(pltform);
          } 
          if (acc.PlayStation_3__c) {
            Platform__c platform = new Platform__c();
            platform.Account__c = acc.Id;
            platform.Platform_Type__c = PLAYSTATION_3;
            platform.License_Type__c = 'Publisher';
            platformList.add(platform);
          }
          if (acc.PlayStation_Vita__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_VITA;
            platfrm.License_Type__c = 'Publisher';
            platformList.add(platfrm);
          } 
        } else if (oldAccMap != null) {
          if ((acc.PlayStation_4__c && !oldAccMap.get(acc.Id).PlayStation_4__c) 
            || (acc.PlayStation_4__c && !oldAccMap.get(acc.Id).Publisher__c)){
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Publisher';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_3__c && !oldAccMap.get(acc.Id).PlayStation_3__c)
            || (acc.PlayStation_3__c && !oldAccMap.get(acc.Id).Publisher__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_3;
            pltform.License_Type__c = 'Publisher';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).PlayStation_Vita__c)
            || (acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).Publisher__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_VITA;
            pltform.License_Type__c = 'Publisher';
            platformList.add(pltform);  
          }
        }
      }
      if (acc.Middleware__c == true) {
        if (oldAccMap == null) {
          if (acc.PlayStation_4__c) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Middleware';
            platformList.add(pltform);
          } 
          if (acc.PlayStation_3__c) {
            Platform__c platform = new Platform__c();
            platform.Account__c = acc.Id;
            platform.Platform_Type__c = PLAYSTATION_3;
            platform.License_Type__c = 'Middleware';
            platformList.add(platform);
          }
          if (acc.PlayStation_Vita__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_VITA;
            platfrm.License_Type__c = 'Middleware';
            platformList.add(platfrm);
          } 
        } else if (oldAccMap != null) {
          if ((acc.PlayStation_4__c && !oldAccMap.get(acc.Id).PlayStation_4__c)
          || (acc.PlayStation_4__c && !oldAccMap.get(acc.Id).Middleware__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Middleware';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_3__c && !oldAccMap.get(acc.Id).PlayStation_3__c)
            || (acc.PlayStation_3__c && !oldAccMap.get(acc.Id).Middleware__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_3;
            pltform.License_Type__c = 'Middleware';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).PlayStation_Vita__c)
            || (acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).Middleware__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_VITA;
            pltform.License_Type__c = 'Middleware';
            platformList.add(pltform);  
          }
        }
      }
      if (acc.Education__c == true) {
        if (oldAccMap == null) {
          if (acc.PlayStation_4__c) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Education';
            platformList.add(pltform);
          } 
          if (acc.PlayStation_3__c) {
            Platform__c platform = new Platform__c();
            platform.Account__c = acc.Id;
            platform.Platform_Type__c = PLAYSTATION_3;
            platform.License_Type__c = 'Education';
            platformList.add(platform);
          }
          if (acc.PlayStation_Vita__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_VITA;
            platfrm.License_Type__c = 'Education';
            platformList.add(platfrm);
          } 
        } else if (oldAccMap != null) {
          if ((acc.PlayStation_4__c && !oldAccMap.get(acc.Id).PlayStation_4__c)
          || (acc.PlayStation_4__c && !oldAccMap.get(acc.Id).Education__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Education';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_3__c && !oldAccMap.get(acc.Id).PlayStation_3__c)
          || (acc.PlayStation_3__c && !oldAccMap.get(acc.Id).Education__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_3;
            pltform.License_Type__c = 'Education';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).PlayStation_Vita__c) 
            || (acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).Education__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_VITA;
            pltform.License_Type__c = 'Education';
            platformList.add(pltform);  
          }
        }
      }
      if (acc.Service_Provider__c == true) {
        if (oldAccMap == null) {
          if (acc.PlayStation_4__c) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Service Provider';
            platformList.add(pltform);
          } 
          if (acc.PlayStation_3__c) {
            Platform__c platform = new Platform__c();
            platform.Account__c = acc.Id;
            platform.Platform_Type__c = PLAYSTATION_3;
            platform.License_Type__c = 'Service Provider';
            platformList.add(platform);
          }
          if (acc.PlayStation_Vita__c) {
            Platform__c platfrm = new Platform__c();
            platfrm.Account__c = acc.Id;
            platfrm.Platform_Type__c = PLAYSTATION_VITA;
            platfrm.License_Type__c = 'Service Provider';
            platformList.add(platfrm);
          } 
        } else if (oldAccMap != null) {
          if ((acc.PlayStation_4__c && !oldAccMap.get(acc.Id).PlayStation_4__c)
          || (acc.PlayStation_4__c && 
          !oldAccMap.get(acc.Id).Service_Provider__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_4;
            pltform.License_Type__c = 'Service Provider';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_3__c && !oldAccMap.get(acc.Id).PlayStation_3__c)
          || (acc.PlayStation_3__c && 
          !oldAccMap.get(acc.Id).Service_Provider__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_3;
            pltform.License_Type__c = 'Service Provider';
            platformList.add(pltform);  
          }
          if ((acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).PlayStation_Vita__c)
            || (acc.PlayStation_Vita__c && 
            !oldAccMap.get(acc.Id).Service_Provider__c)) {
            Platform__c pltform = new Platform__c();
            pltform.Account__c = acc.Id;
            pltform.Platform_Type__c = PLAYSTATION_VITA;
            pltform.License_Type__c = 'Service Provider';
            platformList.add(pltform);  
          }
        }
      }
    }
    
    Database.insert(platformList);
  }*/
}