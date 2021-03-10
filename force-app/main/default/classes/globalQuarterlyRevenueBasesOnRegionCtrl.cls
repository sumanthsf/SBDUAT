/*************************************************************************************************
Apex Class Name :  globalQuarterlyRevenueBasesOnRegionCtrl
Version         : 1.0 
Created Date    : 26 JAN 2021
Function        : Class used to create a custom report for Region based Quarterly Revenue.  

Modification Log :
-----------------------------------------------------------------------------
* Developer                   Date                          Description
* ----------------------------------------------------------------------------                 
* *                         01/26/2021                 Original Version
* Sahithi                   01/27/2021              added filters in the report
* Geetha                    01/28/2021              modified the logic to show reports.. 
* Geetha                    01/29/2021              changed the first report logic to show required group by columns.. 
* Geetha                    02/05/2021              Converting the currency based on user's currency.                                               
**************************************************************************************************/
public class globalQuarterlyRevenueBasesOnRegionCtrl {
    //Below Method is used to query the optys' manager names and show as values in the LWC UI picklist 
    @AuraEnabled(cacheable=true)
    public static List<String> getOptyOwnerManagerData(){
        Set<String> lstManagerName=new Set<String>();
        Map<ID,Opportunity> mapOpp=new Map<ID,Opportunity>([SELECT Owner.ManagerID,Owner.Manager.Name from Opportunity WHERE RecordType.DeveloperName='AdSales_RT_Opportunity']); 
        if(mapOpp.size()>0){
            for(ID ManagerID:mapOpp.keySet()){                
                lstManagerName.add(mapOpp.get(managerID).Owner.Manager.Name);   
            }
        }
        List<String> lstOfNames = new List<String>(lstManagerName);
        return lstOfNames;
    }
    //Main Method which is getting called from lwc by passing inputs
    @AuraEnabled
    public static List<reportWrapper1> prepareWrapperData(String region,String manager,String stageBucket,String selectedYear,Boolean flag){
        system.debug(region+'manager-- '+manager+' stage-- '+stageBucket+ 'year-- '+selectedYear+flag);
        List<reportWrapper1> lstWrapper= new List<reportWrapper1>();
        Map<String,List<Opportunity>> oppAccMap = new Map<String,List<Opportunity>>();
        List<Opportunity> lstOpp= new List<Opportunity>();
        List<Opportunity> lstOpps = new List<Opportunity>();
        List<Account> lstAccounts=new List<Account>();
        Map<String,List<Account>> mapAccountsByRegion = new Map<String,List<Account>>();
        Map<Id,Map<String,List<Account>>> mapAccountsByRegionByOwner = new Map<Id,Map<String,List<Account>>>();
        Map<Id,List<Opportunity>> accountOppMap = new Map<Id,List<Opportunity>>();
        
        if(String.isNotBlank(selectedYear)){
            User_Selected_Year__c setting = User_Selected_Year__c.getOrgDefaults();
            setting.User_Selected_FY__c = Integer.valueOf(selectedYear);
            upsert setting;
        }else{
            
            Decimal year;
            if(Date.Today().Month()>=4){
                year=system.today().year();
                
            }else{
                year=system.today().year()-1;
            }
            User_Selected_Year__c setting = User_Selected_Year__c.getOrgDefaults();
            setting.User_Selected_FY__c = year;
            upsert setting;
            
            selectedYear = String.valueOf(year);
        }
        if(String.isNotBlank(region) && (region=='SIEA'  || region=='SIEE' || region=='SIEJ')){
            lstAccounts = [select Territory__c,ID,Name,Owner.Id,Owner.Name from account where Territory__c =:region AND Territory__c != null AND RecordType.DeveloperName IN ('SIE_RT_Agency','SIE_RT_Advertiser') AND No_Of_Opportunities__c>0 AND Owner.Profile.Name='Ad Sales User Profile'];
        }
        else{
            lstAccounts = [select Territory__c,ID,Name,Owner.Id,Owner.Name from account where Territory__c IN ('SIEA','SIEE','SIEJ') AND Territory__c != null AND RecordType.DeveloperName IN ('SIE_RT_Agency','SIE_RT_Advertiser') AND No_Of_Opportunities__c>0 AND Owner.Profile.Name='Ad Sales User Profile'];
            region='All Regions';
        }
        
        if(lstAccounts.size()>0){
            if(stageBucket=='Working'){
                lstOpp = [select AccountId,Owner.Name,Name,CurrencyIsoCode,probability,(SELECT ID,SplitOwner.Name,SplitPercentage,SplitOwner.Id from OpportunitySplits WHERE SplitPercentage>0),Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,Account.Name,Opportunity_Start_Date__c,Opportunity_End_Date__c,Amount,ID,(select Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,CurrencyIsoCode from OpportunityLineItems where Start_Date_Custom__c !=null AND End_Date_Custom__c!=null),Account.owner.Id from opportunity where AccountId IN:lstAccounts
                          AND stageName NOT IN ('Release','Closed Won','License Granted (Closed Won)','Inactive','Dead','License Denied (Closed Lost)','Closed Lost') AND RecordType.DeveloperName='AdSales_RT_Opportunity' AND Opportunity_Start_Date__c !=null AND Opportunity_End_Date__c!=null];
                
            }else if(stageBucket=='Booked'){
                lstOpp = [select AccountId,Owner.Name,CurrencyIsoCode,Jan__c,(SELECT ID,SplitOwner.Name,SplitPercentage,SplitOwner.Id from OpportunitySplits WHERE SplitPercentage>0),probability,Name,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,Account.Name,Opportunity_Start_Date__c,Opportunity_End_Date__c,Amount,(select Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,CurrencyIsoCode from OpportunityLineItems where Start_Date_Custom__c !=null AND End_Date_Custom__c!=null),account.owner.Id from opportunity where AccountId IN:lstAccounts
                          AND StageName ='Closed Won' AND RecordType.DeveloperName='AdSales_RT_Opportunity' AND Opportunity_Start_Date__c!=null AND Opportunity_End_Date__c!=null ];
            }else{
                lstOpp = [select AccountId,CurrencyIsoCode,Owner.Name,Jan__c,(SELECT ID,SplitPercentage,SplitOwner.Name,SplitOwner.Id from OpportunitySplits WHERE SplitPercentage>0),probability,Name,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,Account.Name,ID,Account.Owner.Name,Opportunity_Start_Date__c,Opportunity_End_Date__c,Amount,(select Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,CurrencyIsoCode from OpportunityLineItems where Start_Date_Custom__c !=null AND End_Date_Custom__c!=null),account.owner.Id from opportunity where AccountId IN:lstAccounts
                          AND RecordType.DeveloperName='AdSales_RT_Opportunity' AND stageName NOT IN ('Release','Inactive','Dead','License Denied (Closed Lost)','Closed Lost') AND Opportunity_Start_Date__c!=null AND Opportunity_End_Date__c!=null];
            }
            if(String.isNotBlank(manager) && manager!='All' && manager!='Taku Seimiya'){
                lstOpps = [SELECT AccountId,Owner.Name,CurrencyIsoCode,Probability,Name,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,(select Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,CurrencyIsoCode from OpportunityLineItems where Start_Date_Custom__c !=null AND End_Date_Custom__c!=null),
                           Account.Name,(SELECT ID,SplitPercentage,SplitOwner.Name,SplitOwner.Id from OpportunitySplits WHERE SplitPercentage>0),ID,Account.Owner.Name,Opportunity_Start_Date__c,Opportunity_End_Date__c,Amount FROM Opportunity WHERE Id IN : lstOpp AND Owner.Manager.Name=: manager AND Owner.Manager.Name!=null AND (Opportunity_Start_Date__c!=null AND Opportunity_End_Date__c!=null)];
            }else if(manager == 'Taku Seimiya'){
                lstOpps = [SELECT AccountId,Owner.Name,CurrencyIsoCode,Probability,Name,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,(select Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c,CurrencyIsoCode from OpportunityLineItems where Start_Date_Custom__c !=null AND End_Date_Custom__c!=null),
                           Account.Name,(SELECT ID,SplitPercentage,SplitOwner.Name,SplitOwner.Id from OpportunitySplits WHERE SplitPercentage>0),ID,Account.Owner.Name,Opportunity_Start_Date__c,Opportunity_End_Date__c,Amount FROM Opportunity WHERE Id IN : lstOpp AND Owner.Name=: manager AND (Opportunity_Start_Date__c!=null AND Opportunity_End_Date__c!=null)];
            }
            if(lstOpps.size()>0 && !lstOpps.isEmpty()){
                lstOpp=lstOpps;
            }
            system.debug('lstOpp-'+lstOpp.size());
            mapAccountsByRegion = prepareAccountsByRegion(lstAccounts);
            oppAccMap=prepareOppByAccounts(lstOpp); 
            if(flag == true){
                lstWrapper=preparereportWrapper1Data(mapAccountsByRegion,oppAccMap,selectedYear,region);
                lstWrapper = calculateGrandTotal(lstWrapper);
            }else if(flag == false){
                lstWrapper=preparereportWrapper1sForDetailRows(mapAccountsByRegion,oppAccMap,region); 
            }
        }
        return lstWrapper;
    }
    public static Map<String,List<Account>> prepareAccountsByRegion(List<Account> lstAccounts){
        Map<String,List<Account>> mapAccountsByRegion = new Map<String,List<Account>>();
        for(Account account:lstAccounts){
            if(!mapAccountsByRegion.containsKey(account.Territory__c)){
                mapAccountsByRegion.put(account.Territory__c,new List<Account>{account} );
                
            }
            else{
                mapAccountsByRegion.get(account.Territory__c).add(account);
            } 
        }
        return mapAccountsByRegion;
    }
    public static Map<String,List<Opportunity>> prepareOppByAccounts(List<Opportunity> lstOpp){
        Map<String,List<Opportunity>> mapOppByAccounts = new Map<String,List<Opportunity>>();
        for(Opportunity opp:lstOpp){
            if(!mapOppByAccounts.containsKey(opp.Account.Name)){
                mapOppByAccounts.put(opp.Account.Name,new List<Opportunity>{opp});
                
            }
            else{
                mapOppByAccounts.get(opp.Account.Name).add(opp);
            }
        }
        return mapOppByAccounts;
    }
    public Static Map<String,List<String>> prepareRegionsByUserId(List<list<Account>> lstAccounts){
        Map<String,List<String>> mapRegionsByUserId = new Map<String,List<String>>();
        for(List<Account> lstAccount:lstAccounts){
            for(Account account:lstAccount){
                if(!mapRegionsByUserId.containsKey(account.Owner.Name)){
                    mapRegionsByUserId.put(account.Owner.Name,new List<String>{account.Territory__c});
                }
                else{
                    mapRegionsByUserId.get(account.Owner.Name).add(account.Territory__c);
                }
            }
        }
        return mapRegionsByUserId;
    }
    public Static Map<String,List<User_Goal__c>> prepareGoalsByUserId(Set<String> userlst,String selectedYear){
        Map<String,List<User_Goal__c>> mapGoalsByUserId = new Map<String,List<User_Goal__c>>();
        List<User> lstUser= [SELECT Id,Name,(SELECT ID,User_Selected_Year__c,CurrencyIsoCode,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c FROM User_Goals__r) FROM User WHERE Name IN: userlst ];
        for(User user:lstUser){
            if(user.User_Goals__r.size()>0){
                for(User_Goal__c usergoals: user.User_Goals__r){
                    if(usergoals.User_Selected_Year__c == Decimal.valueOf(selectedYear)){
                        if(!mapGoalsByUserId.containsKey(user.Name)){
                            mapGoalsByUserId.put(user.Name,new List<User_Goal__c>{usergoals});
                            
                        }
                        else{
                            mapGoalsByUserId.get(user.Name).add(usergoals);
                        }
                    }
                }
                
            }
            
        }
        return mapGoalsByUserId;
    }
    
    
    public static Decimal convertCurrency(String oCurrency, String nCurrency, Decimal amount,Map<String,Decimal> conversion_rates){
        
        Set<String> isoCodes = new Set<String>();
        
        //Convert incoming Opportuntiy Amount into USD…
        Double conversionRate = conversion_rates.get(oCurrency);
        
        if(amount!=NULL && conversionRate!=NULL){
            amount = amount / conversionRate;
            if(nCurrency != 'USD'){
                conversionRate = conversion_rates.get(nCurrency);
                amount = amount * conversionRate;
            }
            
        }
        else
        {
            amount = 0;
        }
        //convert amount as per new currency. 
        
        return amount;
    }
    public static Map<String,Decimal> prepareIsoMap(){
        
        Map<String,Decimal> conversion_rates = new Map<String,Decimal>();
        
        for(CurrencyType curr: [SELECT IsoCode,ConversionRate 
                                
                                FROM CurrencyType]){          
                                    
                                    conversion_rates.put(curr.IsoCode,curr.ConversionRate);        
                                }
        return conversion_rates;
    }
    public Static List<reportWrapper1> preparereportWrapper1Data(Map<String,List<Account>> mapAccountsByRegion,Map<String,List<Opportunity>> oppAccMap,String selectedYear,String selectedRegion){
        system.debug('method calling---'+mapAccountsByRegion.size());
        system.debug('oppAccMap--'+oppAccMap);
            system.debug('selectedYear--'+selectedYear+'region--'+selectedRegion);
        Map<String,List<String>> mapRegionsByUserId = prepareRegionsByUserId(mapAccountsByRegion.values());
        Map<String,List<User_Goal__c>> mapGoalsByUserId = new Map<String,List<User_Goal__c>>();
        mapGoalsByUserId = prepareGoalsByUserId(mapRegionsByUserId.keySet(),selectedYear);
        Map<String,Decimal> conversion_rates = new Map<String,Decimal>();
        conversion_rates =prepareIsoMap();
        String userCurrency = UserInfo.getDefaultCurrency();
        List<reportWrapper1> lstreportWrapper1 = new List<reportWrapper1>();
        reportWrapper1 reportwrap;
        for(String region:mapAccountsByRegion.keySet()){
            reportwrap = new reportWrapper1();
            reportwrap.region=region; 
            for(String userName:mapRegionsByUserId.keySet()){
                reportwrap.userName=userName;
                Boolean accountHasOpptyFlag= false;
                reportwrap.userId=mapAccountsByRegion.get(region)[0].Owner.Id;
                Decimal Q1Forecast=0,Q2Forecast=0,Q3Forecast=0,Q4Forecast=0;
                Decimal Q1_Goal_Difference=0,Q2_Goal_Difference=0,Q3_Goal_Difference=0,Q4_Goal_Difference=0;
                Decimal Q1_Goal_percentage=0,Q2_Goal_percentage=0,Q3_Goal_percentage=0,Q4_Goal_percentage=0;
                for(Account account:mapAccountsByRegion.get(region)){
                    if(userName==account.Owner.Name){
                        
                        reportwrap.accountName=account.Name;
                        reportwrap.accountId=account.Id;
                        if(oppAccMap.ContainsKey(account.Name) && oppAccMap.size()>0){
                            
                            for(Opportunity opp:oppAccMap.get(account.Name)){
                                
                                if(opp.Owner.Name == userName){
                                    Decimal Q1=0,Q2=0,Q3=0,Q4=0 ;
                                    accountHasOpptyFlag = true;
                                    system.debug('opp--'+opp.Id);
                                    if(opp.OpportunityLineItems.size()>0){
                                        for(OpportunityLineItem optyLineItem :opp.OpportunityLineItems){
                                            if(optyLineItem.CurrencyIsoCode !='USD')
                                            {
                                                Q1= Q1+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Apr__c+optyLineItem.May__c+optyLineItem.Jun__c),conversion_rates).setScale(2);
                                                Q2= Q2+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Jul__c+optyLineItem.Aug__c+optyLineItem.Sep__c),conversion_rates).setScale(2);
                                                Q3= Q3+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Oct__c+optyLineItem.Nov__c+optyLineItem.Dec__c),conversion_rates).setScale(2);                      
                                                Q4= Q4+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Jan__c+optyLineItem.Feb__c+optyLineItem.Mar__c),conversion_rates).setScale(2);
                                            }
                                            else{
                                                Q1= (Q1+optyLineItem.Apr__c+optyLineItem.May__c+optyLineItem.Jun__c).setScale(2);
                                                Q2= (Q2+optyLineItem.Jul__c+optyLineItem.Aug__c+optyLineItem.Sep__c).setScale(2);
                                                Q3= (Q3+optyLineItem.Oct__c+optyLineItem.Nov__c+optyLineItem.Dec__c).setScale(2);                      
                                                Q4= (Q4+optyLineItem.Jan__c+optyLineItem.Feb__c+optyLineItem.Mar__c).setScale(2);
                                            }
                                            
                                        }
                                        Q1Forecast=(Q1Forecast+(Q1*opp.OpportunitySplits[0].SplitPercentage)).setScale(2);
                                        Q2Forecast=(Q2Forecast+(Q2*opp.OpportunitySplits[0].SplitPercentage)).setScale(2);
                                        Q3Forecast=(Q3Forecast+(Q3*opp.OpportunitySplits[0].SplitPercentage)).setScale(2);
                                        Q4Forecast=(Q4Forecast+(Q4*opp.OpportunitySplits[0].SplitPercentage)).setScale(2);
                                    }else{
                                        if(opp.CurrencyIsoCode != 'USD')
                                        { 
                                            Q1Forecast=(Q1Forecast+convertCurrency(opp.CurrencyIsoCode,'USD',((opp.Apr__c+opp.May__c+opp.Jun__c)*opp.OpportunitySplits[0].SplitPercentage),conversion_rates).setScale(2)).setScale(2);
                                            Q2Forecast=(Q2Forecast+convertCurrency(opp.CurrencyIsoCode,'USD',((opp.Jul__c+opp.Aug__c+opp.Sep__c)*opp.OpportunitySplits[0].SplitPercentage),conversion_rates).setScale(2)).setScale(2);
                                            Q3Forecast=(Q3Forecast+convertCurrency(opp.CurrencyIsoCode,'USD',((opp.Oct__c+opp.Nov__c+opp.Dec__c)*opp.OpportunitySplits[0].SplitPercentage),conversion_rates).setScale(2)).setScale(2);
                                            Q4Forecast=(Q4Forecast+convertCurrency(opp.CurrencyIsoCode,'USD',((opp.Jan__c+opp.Feb__c+opp.Mar__c)*opp.OpportunitySplits[0].SplitPercentage),conversion_rates).setScale(2)).setScale(2);
                                        }
                                        else{
                                            Q1Forecast=(Q1Forecast+((opp.Apr__c+opp.May__c+opp.Jun__c)*opp.OpportunitySplits[0].SplitPercentage).setScale(2)).setScale(2);
                                            Q2Forecast=(Q2Forecast+((opp.Jul__c+opp.Aug__c+opp.Sep__c)*opp.OpportunitySplits[0].SplitPercentage).setScale(2)).setScale(2);
                                            Q3Forecast=(Q3Forecast+((opp.Oct__c+opp.Nov__c+opp.Dec__c)*opp.OpportunitySplits[0].SplitPercentage).setScale(2)).setScale(2);
                                            Q4Forecast=(Q4Forecast+((opp.Jan__c+opp.Feb__c+opp.Mar__c)*opp.OpportunitySplits[0].SplitPercentage).setScale(2)).setScale(2);
                                        }
                                        
                                    }
                                    
                                }
                                
                            }
                        }
                        
                    }
                    
                }
                if(accountHasOpptyFlag == true){
                    if(mapGoalsByUserId.ContainsKey(userName)){
                        if(mapGoalsByUserId.get(userName)[0].Q1_Goal__c==0 && mapGoalsByUserId.get(userName)[0].Q2_Goal__c==0  && mapGoalsByUserId.get(userName)[0].Q3_Goal__c==0 && mapGoalsByUserId.get(userName)[0].Q4_Goal__c==0 ){
                            
                        }else{
                            if( mapGoalsByUserId.get(userName)[0].Q1_Goal__c>0){
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    reportwrap.Q1_Goal_percentage=(Q1Forecast/(convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q1_Goal__c),conversion_rates)).setScale(2));
                                    reportwrap.Q1_Goal_Difference = (convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q1_Goal__c ).setScale(2),conversion_rates)-Q1Forecast).setScale(2);
                                }
                                else{
                                    reportwrap.Q1_Goal_percentage=(Q1Forecast/mapGoalsByUserId.get(userName)[0].Q1_Goal__c);
                                    reportwrap.Q1_Goal_Difference = (mapGoalsByUserId.get(userName)[0].Q1_Goal__c.setScale(2) -Q1Forecast.setScale(2)).setScale(2);
                                }
                            }
                            else{
                                reportwrap.Q1_Goal_percentage=0;
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){   
                                    reportwrap.Q1_Goal_Difference=(0 -convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',Q1Forecast,conversion_rates));
                                }else{
                                    reportwrap.Q1_Goal_Difference=0-Q1Forecast;
                                }
                            }
                            if(mapGoalsByUserId.get(userName)[0].Q2_Goal__c>0){
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    reportwrap.Q2_Goal_percentage=(Q2Forecast/(convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q2_Goal__c),conversion_rates)).setScale(2));
                                    reportwrap.Q2_Goal_Difference = (convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q2_Goal__c ).setScale(2),conversion_rates)-Q2Forecast).setScale(2);
                                }
                                else{
                                    reportwrap.Q2_Goal_percentage=(Q2Forecast/mapGoalsByUserId.get(userName)[0].Q2_Goal__c);
                                    reportwrap.Q2_Goal_Difference=(mapGoalsByUserId.get(userName)[0].Q2_Goal__c .setScale(2)-Q2Forecast.setScale(2)).setScale(2);
                                }  
                                
                            }else{
                                reportwrap.Q2_Goal_percentage=0;
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    
                                    reportwrap.Q2_Goal_Difference=(0 -convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',Q2Forecast,conversion_rates).setScale(2));
                                }else{
                                    reportwrap.Q2_Goal_Difference=(0-Q2Forecast).setScale(2);
                                }                            }
                            if(mapGoalsByUserId.get(userName)[0].Q3_Goal__c>0){
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    reportwrap.Q3_Goal_percentage=(Q3Forecast/(convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q3_Goal__c),conversion_rates)).setScale(2));
                                    reportwrap.Q3_Goal_Difference = (convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q3_Goal__c ),conversion_rates).setScale(2)-Q3Forecast).setScale(2);
                                }else{
                                    reportwrap.Q3_Goal_percentage=(Q3Forecast/mapGoalsByUserId.get(userName)[0].Q3_Goal__c);
                                    reportwrap.Q3_Goal_Difference=(mapGoalsByUserId.get(userName)[0].Q3_Goal__c.setScale(2) -Q3Forecast.setScale(2)).setScale(2);
                                }  
                            }else{
                                reportwrap.Q3_Goal_percentage=0;
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    
                                    reportwrap.Q3_Goal_Difference=(0 -convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',Q3Forecast,conversion_rates).setScale(2));
                                }else{
                                    reportwrap.Q3_Goal_Difference=(0-Q3Forecast.setScale(2));
                                } 
                            }
                            
                            if(mapGoalsByUserId.get(userName)[0].Q4_Goal__c>0){
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    reportwrap.Q4_Goal_percentage=(Q4Forecast/(convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q4_Goal__c),conversion_rates)).setScale(2));
                                    reportwrap.Q4_Goal_Difference =( convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',(mapGoalsByUserId.get(userName)[0].Q4_Goal__c ),conversion_rates).setScale(2)-Q4Forecast).setScale(2);
                                }
                                else{
                                    reportwrap.Q4_Goal_percentage=(Q4Forecast/mapGoalsByUserId.get(userName)[0].Q4_Goal__c);
                                    reportwrap.Q4_Goal_Difference=(mapGoalsByUserId.get(userName)[0].Q4_Goal__c.setScale(2) -Q4Forecast.setScale(2)).setScale(2);
                                }
                            }else{
                                reportwrap.Q4_Goal_percentage=0;
                                if(mapGoalsByUserId.get(userName)[0].currencyIsoCode!='USD'){
                                    
                                    reportwrap.Q4_Goal_Difference=(0 -convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',Q4Forecast,conversion_rates).setScale(2));
                                }else{
                                    reportwrap.Q4_Goal_Difference=(0-Q4Forecast.setScale(2));
                                }                            }
                            reportwrap.Q1_Forecast=Q1Forecast.setScale(2);
                            reportwrap.Q2_Forecast=Q2Forecast.setScale(2);
                            reportwrap.Q3_Forecast=Q3Forecast.setScale(2);
                            reportwrap.Q4_Forecast=Q4Forecast.setScale(2);
                            // reportwrap.CurrencyIsoCode = userCurrency;
                            if(mapGoalsByUserId.get(userName)[0].currencyIsoCode !='USD'){
                                reportwrap.Q1_Goal= convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',mapGoalsByUserId.get(userName)[0].Q1_Goal__c,conversion_rates).setScale(2) ;                       
                                reportwrap.Q2_Goal= convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',mapGoalsByUserId.get(userName)[0].Q2_Goal__c,conversion_rates).setScale(2) ;                       
                                reportwrap.Q3_Goal= convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',mapGoalsByUserId.get(userName)[0].Q3_Goal__c,conversion_rates).setScale(2);                       
                                reportwrap.Q4_Goal= convertCurrency(mapGoalsByUserId.get(userName)[0].currencyIsoCode,'USD',mapGoalsByUserId.get(userName)[0].Q4_Goal__c,conversion_rates).setScale(2) ;                       
                            }
                            else{
                                reportwrap.Q1_Goal= (mapGoalsByUserId.get(userName)[0].Q1_Goal__c).setScale(2) ;                       
                                reportwrap.Q2_Goal= (mapGoalsByUserId.get(userName)[0].Q2_Goal__c).setScale(2) ;                       
                                reportwrap.Q3_Goal= (mapGoalsByUserId.get(userName)[0].Q3_Goal__c).setScale(2);                       
                                reportwrap.Q4_Goal= (mapGoalsByUserId.get(userName)[0].Q4_Goal__c).setScale(2) ;  
                                
                            }
                            lstreportWrapper1.add(reportwrap);
                            reportwrap = new reportWrapper1();
                        }
                    }
                }
            }
            
            
            
        }
        system.debug('last stmnt--'+lstreportWrapper1);
        return lstreportWrapper1;     
    }
    
    @AuraEnabled
    public Static List<reportWrapper1> calculateGrandTotal(List<reportWrapper1> lstWrapper){
        String userCurrency = UserInfo.getDefaultCurrency();
        Map<String,Decimal> conversion_rates = new Map<String,Decimal>();
        conversion_rates =prepareIsoMap();
        if(lstWrapper.size()>0){
            String code;
            Decimal Q1Forecast=0,Q2Forecast=0,Q3Forecast=0,Q4Forecast=0;
            Decimal Q1_Goal_Difference=0,Q2_Goal_Difference=0,Q3_Goal_Difference=0,Q4_Goal_Difference =0,Q1_Goal_percentage=0,Q2_Goal_percentage=0,Q3_Goal_percentage=0,Q4_Goal_percentage=0;
            for(reportWrapper1 rewrap:lstWrapper){
                if(userCurrency !='USD'){
                    rewrap.Q1_Forecast =convertCurrency('USD',userCurrency,rewrap.Q1_Forecast,conversion_rates).setScale(2);
                    rewrap.Q2_Forecast =convertCurrency('USD',userCurrency,rewrap.Q2_Forecast,conversion_rates).setScale(2);
                    rewrap.Q3_Forecast =convertCurrency('USD',userCurrency,rewrap.Q3_Forecast,conversion_rates).setScale(2);
                    rewrap.Q4_Forecast =convertCurrency('USD',userCurrency,rewrap.Q4_Forecast,conversion_rates).setScale(2);
                    if(rewrap.Q1_Goal_Difference!=0){
                        rewrap.Q1_Goal_Difference =convertCurrency('USD',userCurrency,rewrap.Q1_Goal_Difference,conversion_rates).setScale(2);
                    }
                    
                    if(rewrap.Q2_Goal_Difference!=0){
                        rewrap.Q2_Goal_Difference =convertCurrency('USD',userCurrency,rewrap.Q2_Goal_Difference,conversion_rates).setScale(2);
                    }
                    if(rewrap.Q3_Goal_Difference!=0){
                        
                        rewrap.Q3_Goal_Difference =convertCurrency('USD',userCurrency,rewrap.Q3_Goal_Difference,conversion_rates).setScale(2);
                    }
                    if(rewrap.Q4_Goal_Difference!=0){
                        rewrap.Q4_Goal_Difference =convertCurrency('USD',userCurrency,rewrap.Q4_Goal_Difference,conversion_rates).setScale(2);
                    }
                    
                    rewrap.Q1_Goal =convertCurrency('USD',userCurrency,rewrap.Q1_Goal,conversion_rates).setScale(2);
                    rewrap.Q2_Goal =convertCurrency('USD',userCurrency,rewrap.Q2_Goal,conversion_rates).setScale(2);
                    rewrap.Q3_Goal =convertCurrency('USD',userCurrency,rewrap.Q3_Goal,conversion_rates).setScale(2);
                    rewrap.Q4_Goal =convertCurrency('USD',userCurrency,rewrap.Q4_Goal,conversion_rates).setScale(2);
                    
                    
                }
                // rewrap.CurrencyIsoCode = userCurrency;
                Q1Forecast=Q1Forecast+rewrap.Q1_Forecast;
                Q2Forecast=Q2Forecast+rewrap.Q2_Forecast;
                Q3Forecast=Q3Forecast+rewrap.Q3_Forecast;
                Q4Forecast=Q4Forecast+rewrap.Q4_Forecast;
                if(rewrap.Q1_Goal_Difference!=null){
                    Q1_Goal_Difference=Q1_Goal_Difference+rewrap.Q1_Goal_Difference;}
                if(rewrap.Q2_Goal_Difference!=null){
                    Q2_Goal_Difference=Q2_Goal_Difference+rewrap.Q2_Goal_Difference;}
                if(rewrap.Q3_Goal_Difference!=null){
                    Q3_Goal_Difference=Q3_Goal_Difference+rewrap.Q3_Goal_Difference;} 
                if(rewrap.Q4_Goal_Difference!=null){
                    Q4_Goal_Difference=Q4_Goal_Difference+rewrap.Q4_Goal_Difference;}
                if(rewrap.Q1_Goal_percentage!=null){
                    Q1_Goal_percentage=Q1_Goal_percentage+rewrap.Q1_Goal_percentage;}
                if(rewrap.Q2_Goal_percentage!=null){
                    Q2_Goal_percentage=Q2_Goal_percentage+rewrap.Q2_Goal_percentage;}
                if(rewrap.Q3_Goal_percentage!=null){
                    Q3_Goal_percentage=Q3_Goal_percentage+rewrap.Q3_Goal_percentage;}
                if(rewrap.Q4_Goal_percentage!=null){
                    Q4_Goal_percentage=Q4_Goal_percentage+rewrap.Q4_Goal_percentage;}
                
                
            }
            reportWrapper1 repWrap = new reportWrapper1();
            repWrap.accountName = 'Total ';
            repWrap.currencyIsoCode = userCurrency;
            repWrap.Q1_Forecast= Q1Forecast.setScale(2);
            repWrap.Q2_Forecast= Q2Forecast.setScale(2);
            repWrap.Q3_Forecast=Q3Forecast.setScale(2);
            repWrap.Q4_Forecast=Q4Forecast.setScale(2);
            repWrap.Q1_Goal_percentage=Q1_Goal_percentage;
            repWrap.Q2_Goal_percentage=Q2_Goal_percentage;
            repWrap.Q3_Goal_percentage=Q3_Goal_percentage;
            repWrap.Q4_Goal_percentage=Q4_Goal_percentage;
            repWrap.Q1_Goal_Difference=Q1_Goal_Difference.setScale(2);
            repWrap.Q2_Goal_Difference=Q2_Goal_Difference.setScale(2);
            repWrap.Q3_Goal_Difference=Q3_Goal_Difference.setScale(2);
            repWrap.Q4_Goal_Difference=Q4_Goal_Difference.setScale(2);
            
            lstWrapper.add(repWrap);
            
        }
        return lstWrapper;
        
    }
    
    
    public Static List<reportWrapper1> preparereportWrapper1sForDetailRows(Map<String,List<Account>> mapAccountsByRegion,Map<String,List<Opportunity>> oppAccMap,String selectedRegion){
        Map<String,List<String>> mapRegionsByUserId = prepareRegionsByUserId(mapAccountsByRegion.values());
        List<reportWrapper1> lstreportWrapper1 = new List<reportWrapper1>();
        String userCurrency = UserInfo.getDefaultCurrency();
        Map<String,Decimal> conversion_rates = new Map<String,Decimal>();
        conversion_rates =prepareIsoMap();
        reportWrapper1 reportwrap;
        for(String region:mapAccountsByRegion.keySet()){
            reportwrap = new reportWrapper1();
            reportwrap.region=region; 
            for(String userName:mapRegionsByUserId.keySet()){
                reportwrap.userName=userName;
                reportwrap.userId=mapAccountsByRegion.get(region)[0].Owner.Id;
                for(Account account:mapAccountsByRegion.get(region)){
                    if(userName==account.Owner.Name){
                        
                        reportwrap.accountName=account.Name;
                        reportwrap.accountId=account.Id;
                        if(oppAccMap.ContainsKey(account.Name) && oppAccMap.size()>0){
                            
                            
                            for(Opportunity opp:oppAccMap.get(account.Name)){
                                Decimal Jan=0,Feb=0,Mar=0,Apr=0,May=0,Jun=0,Jul=0,Aug=0,Sep=0,Oct=0,Nov=0,Dec=0;
                                reportwrap.oppId=opp.Id;
                                reportwrap.opportunityName=opp.Name;
                                if(opp.Probability>0){
                                    reportwrap.probability= Integer.valueOf(opp.Probability);}
                                reportwrap.optyStartDate=opp.Opportunity_Start_Date__c;
                                reportwrap.optyEndDate=opp.Opportunity_End_Date__c;
                                if(opp.OpportunityLineItems.size()>0){
                                    for(OpportunityLineItem optyLineItem :opp.OpportunityLineItems){
                                        if(optyLineItem.CurrencyIsoCode !='USD'){
                                            Jan=Jan+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Jan__c),conversion_rates).setScale(2);
                                            Feb=Feb+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Feb__c),conversion_rates).setScale(2);
                                            Mar=Mar+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Mar__c),conversion_rates).setScale(2);
                                            Apr=Apr+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Apr__c),conversion_rates).setScale(2);
                                            May=May+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.May__c),conversion_rates).setScale(2);
                                            Jun=Jun+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Jun__c),conversion_rates).setScale(2);
                                            Jul=Jul+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Jul__c),conversion_rates).setScale(2);
                                            Aug=Aug+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Aug__c),conversion_rates).setScale(2);
                                            Sep=Sep+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Sep__c),conversion_rates).setScale(2);
                                            Oct=Oct+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Oct__c),conversion_rates).setScale(2);
                                            Nov=Nov+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Nov__c),conversion_rates).setScale(2);
                                            Dec=Dec+convertCurrency(optyLineItem.CurrencyIsoCode,'USD',(optyLineItem.Dec__c),conversion_rates).setScale(2);
                                        }
                                        else{
                                            Jan=Jan+optyLineItem.Jan__c;
                                            Feb=Feb+optyLineItem.Feb__c;
                                            Mar=Mar+optyLineItem.Mar__c;
                                            Apr=Apr+optyLineItem.Apr__c;
                                            May=May+optyLineItem.May__c;
                                            Jun=Jun+optyLineItem.Jun__c;
                                            Jul=Jul+optyLineItem.Jul__c;
                                            Aug=Aug+optyLineItem.Aug__c;
                                            Sep=Sep+optyLineItem.Sep__c;
                                            Oct=Oct+optyLineItem.Oct__c;
                                            Nov=Nov+optyLineItem.Nov__c;
                                            Dec=Dec+optyLineItem.Dec__c;
                                        }
                                        
                                    }
                                }else{
                                    if(opp.CurrencyIsoCode !='USD'){
                                        
                                        Jan=Jan+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Jan__c),conversion_rates).setScale(2);
                                        Feb=Feb+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Feb__c),conversion_rates).setScale(2);
                                        Mar=Mar+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Mar__c),conversion_rates).setScale(2);
                                        Apr=Apr+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Apr__c),conversion_rates).setScale(2);
                                        May=May+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.May__c),conversion_rates).setScale(2);
                                        Jun=Jun+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Jun__c),conversion_rates).setScale(2);
                                        Jul=Jul+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Jul__c),conversion_rates).setScale(2);
                                        Aug=Aug+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Aug__c),conversion_rates).setScale(2);
                                        Sep=Sep+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Sep__c),conversion_rates).setScale(2);
                                        Oct=Oct+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Oct__c),conversion_rates).setScale(2);
                                        Nov=Nov+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Nov__c),conversion_rates).setScale(2);
                                        Dec=Dec+convertCurrency(opp.CurrencyIsoCode,'USD',(opp.Dec__c),conversion_rates).setScale(2);
                                    }else{
                                        Jan=(Jan+opp.Jan__c.setScale(2)).setScale(2);
                                        Feb=(Feb+opp.Feb__c.setScale(2)).setScale(2);
                                        Mar=(Mar+opp.Mar__c.setScale(2)).setScale(2);
                                        Apr=(Apr+opp.Apr__c.setScale(2)).setScale(2);
                                        May=(May+opp.May__c.setScale(2)).setScale(2);
                                        Jun=(Jun+opp.Jun__c.setScale(2)).setScale(2);
                                        Jul=(Jul+opp.Jul__c.setScale(2)).setScale(2);
                                        Aug=(Aug+opp.Aug__c.setScale(2)).setScale(2);
                                        Sep=(Sep+opp.Sep__c.setScale(2)).setScale(2);
                                        Oct=(Oct+opp.Oct__c.setScale(2)).setScale(2);
                                        Nov=(Nov+opp.Nov__c.setScale(2)).setScale(2);
                                        Dec=(Dec+opp.Dec__c.setScale(2)).setScale(2);
                                    }
                                }
                                // reportwrap.CurrencyIsoCode = userCurrency;
                                reportwrap.Jan=Jan.setScale(2);
                                reportwrap.Feb=Feb.setScale(2);
                                reportwrap.Mar=Mar.setScale(2);
                                reportwrap.Apr=Apr.setScale(2);
                                reportwrap.May=May.setScale(2);
                                reportwrap.Jun=Jun.setScale(2);
                                reportwrap.Jul=Jul.setScale(2);
                                reportwrap.Aug=Aug.setScale(2);
                                reportwrap.Sep=Sep.setScale(2);
                                reportwrap.Oct=Oct.setScale(2);
                                reportwrap.Nov=Nov.setScale(2);
                                reportwrap.Dec=Dec.setScale(2);
                                
                                if(reportwrap.Jan == 0 && reportwrap.Feb == 0  && reportwrap.Mar == 0 && reportwrap.Apr ==0 && reportwrap.May == 0 && reportwrap.Jun ==0 && reportwrap.Jul ==0 && reportwrap.Aug ==0 && reportwrap.Sep ==0 && reportwrap.Oct== 0 && reportwrap.Nov ==0 && reportwrap.Dec ==0){
                                    reportwrap = new reportWrapper1();
                                    
                                }else{
                                    lstreportWrapper1.add(reportwrap);
                                    reportwrap = new reportWrapper1();
                                }
                            }
                            
                        }
                        
                    }
                    
                }
            }
            
            
            
        }
        
        if(lstreportWrapper1.size()>0){
            Decimal Jan=0,Feb=0,Mar=0,Apr=0,May=0,Jun=0,Jul=0,Aug=0,Sep=0,Oct=0,Nov=0,Dec=0;
            Decimal Probability = 0;
            for(reportWrapper1 rewrap:lstreportWrapper1 ){
                rewrap.CurrencyIsoCode=userCurrency;
                Probability = Probability+rewrap.Probability;
                if(userCurrency!= 'USD'){
                    rewrap.Jan=convertCurrency('USD',userCurrency,rewrap.Jan,conversion_rates).setScale(2);
                    rewrap.Feb=convertCurrency('USD',userCurrency,rewrap.Feb,conversion_rates).setScale(2);
                    rewrap.Mar=convertCurrency('USD',userCurrency,rewrap.Mar,conversion_rates).setScale(2);
                    rewrap.Apr=convertCurrency('USD',userCurrency,rewrap.Apr,conversion_rates).setScale(2);
                    rewrap.May=convertCurrency('USD',userCurrency,rewrap.May,conversion_rates).setScale(2);
                    rewrap.Jun=convertCurrency('USD',userCurrency,rewrap.Jun,conversion_rates).setScale(2);
                    rewrap.Jul=convertCurrency('USD',userCurrency,rewrap.Jul,conversion_rates).setScale(2);
                    rewrap.Aug=convertCurrency('USD',userCurrency,rewrap.Aug,conversion_rates).setScale(2);
                    rewrap.Sep=convertCurrency('USD',userCurrency,rewrap.Sep,conversion_rates).setScale(2);
                    rewrap.Oct=convertCurrency('USD',userCurrency,rewrap.Oct,conversion_rates).setScale(2);
                    rewrap.Nov=convertCurrency('USD',userCurrency,rewrap.Nov,conversion_rates).setScale(2);
                    rewrap.Dec=convertCurrency('USD',userCurrency,rewrap.Dec,conversion_rates).setScale(2);
                    
                    
                }
                Jan=Jan+rewrap.Jan;
                Feb=Feb+rewrap.Feb;
                Mar=Mar+rewrap.Mar;
                Apr=Apr+rewrap.Apr;
                May=May+rewrap.May;
                Jun=Jun+rewrap.Jun;
                Jul=Jul+rewrap.Jul;
                Aug=Aug+rewrap.Aug;
                Sep=Sep+rewrap.Sep;
                Oct=Oct+rewrap.Oct;
                Nov=Nov+rewrap.Nov;
                Dec=Apr+rewrap.Dec;
                
                
                
            }
            reportWrapper1 repWrap = new reportWrapper1();
            repWrap.accountName = 'Total ';
            //repWrap.CurrencyIsoCode = userCurrency ;
            repWrap.Probability= Probability;
            repWrap.Jan=Jan.setScale(2);
            repWrap.Feb=Feb.setScale(2);
            repWrap.Mar=Mar.setScale(2);
            repWrap.Apr=Apr.setScale(2);
            repWrap.May=May.setScale(2);
            repWrap.Jun=Jun.setScale(2);
            repWrap.Jul=Jul.setScale(2);
            repWrap.Aug=Aug.setScale(2);
            repWrap.Sep=Sep.setScale(2);
            repWrap.Oct=Oct.setScale(2);
            repWrap.Nov=Nov.setScale(2);
            repWrap.Dec=Dec.setScale(2);
            
            lstreportWrapper1.add(repWrap);
            
        }
        return lstreportWrapper1;     
    }
    
    //Wrapper class to send info to ligtning Component
    public class reportWrapper1{
        @AuraEnabled
        public string region;
        @AuraEnabled
        public String userId;
        @AuraEnabled
        public String userName;
        @AuraEnabled
        public String accountId;
        @AuraEnabled
        public String accountName;
        @AuraEnabled
        public Decimal Q1_Forecast;
        @AuraEnabled
        public Decimal Q2_Forecast;
        @AuraEnabled
        public Decimal Q3_Forecast;
        @AuraEnabled
        public Decimal Q4_Forecast;
        @AuraEnabled
        public Decimal Q1_Goal;
        @AuraEnabled
        public Decimal Q2_Goal;
        @AuraEnabled
        public Decimal Q3_Goal;
        @AuraEnabled
        public Decimal Q4_Goal;
        @AuraEnabled
        public String oppId;
        @AuraEnabled
        public String opportunityName;
        @AuraEnabled
        public Decimal Jan;
        @AuraEnabled
        public Decimal Feb;
        @AuraEnabled
        public Decimal Mar;
        @AuraEnabled
        public Decimal Apr;
        @AuraEnabled
        public Decimal May;
        @AuraEnabled
        public Decimal Jun;
        @AuraEnabled
        public Decimal Jul;
        @AuraEnabled
        public Decimal Aug;
        @AuraEnabled
        public Decimal Sep;
        @AuraEnabled
        public Decimal Oct;
        @AuraEnabled
        public Decimal Nov;
        @AuraEnabled
        public Decimal Dec;
        @AuraEnabled
        public Date optyStartDate;
        @AuraEnabled
        public Date optyEndDate;
        @AuraEnabled
        public Decimal probability;
        @AuraEnabled
        public Decimal Q1_Goal_percentage;
        @AuraEnabled
        public Decimal Q2_Goal_percentage;
        @AuraEnabled
        public Decimal Q3_Goal_percentage;
        @AuraEnabled
        public Decimal Q4_Goal_percentage;
        @AuraEnabled
        public Decimal Q1_Goal_Difference;
        @AuraEnabled
        public Decimal Q2_Goal_Difference;
        @AuraEnabled
        public Decimal Q3_Goal_Difference;
        @AuraEnabled
        public Decimal Q4_Goal_Difference;
        @AuraEnabled
        public String CurrencyIsoCode;        
        
        
    }
}