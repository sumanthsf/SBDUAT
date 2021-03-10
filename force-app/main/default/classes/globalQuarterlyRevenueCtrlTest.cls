@istest
public class globalQuarterlyRevenueCtrlTest{
    @testSetup
    public static void setUpData(){
        Profile salesprofile = [select id,Name from profile where name = 'System Administrator' LIMIt 1];
        List<User> userRecs = new List<User>();
        List<product2> prodList = new List<Product2>();
        prodList.add(new Product2(Name = 'Sample Product test',isactive = true));
        insert prodList;
        List<Pricebook2> priceBooks = new List<Pricebook2>();
        priceBooks.add(new pricebook2(Name ='Pricebook test',isactive = true));
        insert priceBooks;
        Pricebook2 customPriceBookRec=[select Id from Pricebook2 where id=:pricebooks[0].Id];
        Id stdPriceBookRecId = System.Test.getStandardPricebookId();
        List<PriceBookEntry> PricebookEntries = new List<PriceBookEntry>();
        PricebookEntries.add(new PriceBookEntry(Product2id=prodlist[0].id,currencyISOCode='JPY',PriceBook2Id=stdPriceBookRecId,unitPrice = 3000,isActive = true));
        insert PricebookEntries;
        
        List<PriceBookEntry> PriceBookEntry1= new List<PriceBookEntry>();
        PriceBookEntry1 = [Select id,priceBook2Id, Product2id from PriceBookEntry where id IN: PricebookEntries];
        List<User> managers = new List<User>();
        List<Account> accRecs = new List<Account>();
        List<Opportunity> oppList = new List<Opportunity>();
        List<OpportunityLineitem> optyProds = new List<OpportunityLineitem>();
        
        User SIEAManager1 = new User(FirstName ='Sabine',LastName='Cummins',userName = '11sieaManager11@test.com' ,email = 'Test111@test.com',profileid = salesprofile.id,Alias = 't6',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='ja',LocaleSidKey='ja',TimeZoneSidKey='Asia/Tokyo');
        User SIEeManager2 = new User(FirstName ='Claire',LastName='Kim',userName = '12SIEeManager2@test.com',email = 'Test112@test.com',profileid = salesprofile.id,Alias = 't7',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles');
        User SIEjManager3 = new User(FirstName ='Taku',LastName='Seimiya',userName = '13SIEjManager3@test.com',email = 'Test113@test.com',profileid = salesprofile.id,Alias = 't8',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles');
        managers.add(SIEAManager1);
        managers.add(SIEeManager2);
        managers.add(SIEjManager3);
        insert managers;
        Map<Id,String> regionManagers = new Map<Id,String>();
        for(User u:managers){
            if(u.FirstName =='Sabine'){
                regionManagers.put(u.id,'SIEA');
            }
            else if(u.FirstName =='Claire'){
                regionManagers.put(u.id,'SIEE');
            }
            else{
                regionManagers.put(u.id,'SIEJ');
            }
            
        }
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Ad Sales User Profile'];
        userRecs.add(new User(FirstName ='Test11',LastName='Lname11',userName = '21Test111@test.com',email = 'Test111@test.com',profileid = p.id,managerid = SIEAManager1.id,Alias = 't',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles',CurrencyIsoCode='USD'));
        userRecs.add(new User(FirstName ='Test22',LastName='Lname22',userName = '22Test222@test.com',email = 'Test222@test.com',profileid = p.id,managerid = SIEeManager2.id,Alias = 't2',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles',CurrencyIsoCode='JPY'));
        userRecs.add(new User(FirstName ='Test33',LastName='Lname33',userName = '23Test333@test.com',email = 'Test333@test.com',profileid = p.id,managerid = SIEeManager2.id,Alias = 't3',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles',CurrencyIsoCode ='USD'));
        userRecs.add(new User(FirstName ='Test44',LastName='Lname44',userName = '24Test444@test.com',email = 'Test444@test.com',profileid = p.id,managerid = SIEjManager3.id,Alias = 't4',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles',CurrencyIsoCode ='USD'));
        userRecs.add(new User(FirstName ='Test55',LastName='Lname55',userName = '25Test555@test.com',email = 'Test555@test.com',profileid = p.id,Alias = 't5',EmailEncodingKey='ISO-8859-1',LanguageLocaleKey='en_US',LocaleSidKey='en_US',TimeZoneSidKey='America/Los_Angeles',CurrencyIsoCode ='USD'));
        insert userRecs;
        Map<Id,Id> userManagerIds = new Map<Id,Id>();
        for(User u:userRecs){
            userManagerIds.put(u.id,u.managerId);
        }
        List<User_Goal__c> userGoals = new List<User_Goal__c>();
        for(user u:userRecs){
            if(u.name == 'Test55 Lname55'){
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2021,Q1_Goal__c= 222000,Q2_Goal__c=100000,Q3_Goal__c=200000,Q4_Goal__c=150000,User__c=u.Id));
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2020,Q1_Goal__c= 0,Q2_Goal__c=0,Q3_Goal__c=0,Q4_Goal__c=0,User__c=u.Id));
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2019,Q1_Goal__c= 0,Q2_Goal__c=0,Q3_Goal__c=0,Q4_Goal__c=0,User__c=u.Id)); 
            }else{
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2021,Q1_Goal__c= 222000,Q2_Goal__c=100000,Q3_Goal__c=200000,Q4_Goal__c=150000,User__c=u.Id));
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2020,Q1_Goal__c= 222000,Q2_Goal__c=100000,Q3_Goal__c=200000,Q4_Goal__c=150000,User__c=u.Id));
                userGoals.add(new User_Goal__c(User_Selected_Year__c = 2019,Q1_Goal__c= 222000,Q2_Goal__c=100000,Q3_Goal__c=200000,Q4_Goal__c=150000,User__c=u.Id));
            }
        }
        insert userGoals;
        Id accRecTypeId1 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Agency').getRecordTypeId();
        Id accRecTypeId2 = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Advertiser').getRecordTypeId();
        Id oppRecTypeName1 = Schema.SObjectType.opportunity.getRecordTypeInfosByName().get('Ad Sales Opportunity').getRecordTypeId();
        
        accRecs.add(new Account(Name = 'test Account1',Territory__c = regionManagers.get(userManagerIds.get(userRecs[0].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[0].id));
        accRecs.add(new Account(Name = 'test Account2',Territory__c = regionManagers.get(userManagerIds.get(userRecs[0].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[0].id));
        accRecs.add(new Account(Name = 'test Account3',Territory__c = regionManagers.get(userManagerIds.get(userRecs[1].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[1].id));
        accRecs.add(new Account(Name = 'test Account4',Territory__c = regionManagers.get(userManagerIds.get(userRecs[1].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[1].id));
        accRecs.add(new Account(Name = 'test Account5',Territory__c = regionManagers.get(userManagerIds.get(userRecs[1].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[1].id));
        accRecs.add(new Account(Name = 'test Account6',Territory__c = regionManagers.get(userManagerIds.get(userRecs[2].id)),recordtypeId = accRecTypeId1,ownerId =userRecs[2].id));
        accRecs.add(new Account(Name = 'test Account7',Territory__c = regionManagers.get(userManagerIds.get(userRecs[2].id)),recordtypeId = accRecTypeId2,ownerId =userRecs[2].id));
        accRecs.add(new Account(Name = 'test Account8',Territory__c = regionManagers.get(userManagerIds.get(userRecs[3].id)),recordtypeId = accRecTypeId2,ownerId =userRecs[3].id));
        accRecs.add(new Account(Name = 'test Account9',Territory__c = regionManagers.get(userManagerIds.get(userRecs[3].id)),recordtypeId = accRecTypeId2,ownerId =userRecs[3].id));
        accRecs.add(new Account(Name = 'test Account10',Territory__c = 'SIEA',recordtypeId = accRecTypeId2,ownerId =userRecs[4].id));
        insert accRecs;
        
        oppList.add(new Opportunity(AccountId = accRecs[0].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test11',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'Incubation',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[0].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[0].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test12',CloseDate=System.today(),Amount = 60000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'In Development',Opportunity_Start_Date__c = system.today().addMonths(-10),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[0].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[1].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test13',CloseDate=System.today(),Amount = 70000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'In Development',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(11),ownerId = accRecs[1].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[1].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test14',CloseDate=System.today(),Amount = 80000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'Incubation',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[1].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[3].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test15',CloseDate=System.today(),Amount = 90000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'In Development',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[3].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[0].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test19',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,Actual_Close_Date__c= system.today().addDays(1),Bill_To__c=accRecs[0].id,stageName = 'Closed Won',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[0].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[0].id,CurrencyIsoCode='JPY',pricebook2Id = stdPriceBookRecId,Name = 'Test20',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'In Development',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[0].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[4].id,CurrencyIsoCode='USD',pricebook2Id = stdPriceBookRecId,Name = 'Test16',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,stageName = 'In Development',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[4].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[4].id,CurrencyIsoCode='USD',Name = 'Test17',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,Actual_Close_Date__c= system.today().addDays(1),Bill_To__c=accRecs[4].id,stageName = 'Closed Won',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[4].ownerid));
        oppList.add(new Opportunity(AccountId = accRecs[4].id,CurrencyIsoCode='USD',Name = 'Test18',CloseDate=System.today(),Amount = 50000,RecordTypeId = oppRecTypeName1,probability = 10,Actual_Close_Date__c= system.today().addDays(1),Bill_To__c=accRecs[4].id,stageName = 'Closed Won',Opportunity_Start_Date__c = system.today().addMonths(-5),Opportunity_End_Date__c = system.today().addMonths(7),ownerId = accRecs[4].ownerid));
        
        insert oppList;
        
        Integer i;
        for(Opportunity opp:oppList){
            opp.Pricebook2Id = stdPriceBookRecId;
            
        }
        Update oppList;
        List<Opportunity> Opp1 = [Select ID,PriceBook2Id from Opportunity where ID IN: oppList AND CurrencyIsoCode!='USD'];
        
        integer j=0;
        for(Opportunity opp:Opp1){
            if(j<=7){
                for(i=1;i<=4;i++){
                    optyProds.add(new OpportunityLineitem(OpportunityId = opp.Id,Quantity= 6000*i,PriceBookEntryId=PriceBookEntry1[0].id,TotalPrice= 2000*i,Start_Date_Custom__c = system.today().addMonths(-12+i),End_Date_Custom__c = system.today().addMonths(6+i)));
                }
            }
            j=+1;
        }
        insert optyProds;
        
    }
    public static testMethod void postiveSenerios(){
        List<User> userList = [select id,FirstName,Name,Managerid,Manager.Name from user where userName='21Test111@test.com'];
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Manager.Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE name='test Account2'];
        List<opportunity> opportuities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN: accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN : opportuities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN : opportuities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c WHERE user__c = :userList[0].Id];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ',accounts[0].Owner.Manager.Name,'Working','2020',true);
        revData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revData);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata);
        delete optyProds;
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata8 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('',opportuities[0].Owner.Manager.Name,'','',true);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData8 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata8);
        
    }
    public static testMethod void elseCaseSenerios(){
        List<User> userList = [select id,FirstName,Name,Managerid,Manager.Name from user where userName='21Test111@test.com'];
        
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Manager.Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE name='test Account10'];
        List<opportunity> opportuities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN: accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN : opportuities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN : opportuities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c WHERE user__c = :userList[0].Id];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ',accounts[0].Owner.Manager.Name,'Working','2020',true);
        revData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revData);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata);
        delete optyProds;
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata8 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('',accounts[0].Owner.Manager.Name,'','',true);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData8 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata8);
        
    }
    
    public static testmethod void unittest2(){
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE Name='test Account2'];
        List<opportunity> opportuities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity  WHERE AccountId IN :accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN :opportuities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN :opportuities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('','','','',true);
        revData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revData);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata7 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('','','','',false);
        
    }
    
    public static testmethod void unittest3(){
        List<User> userList = [select id,Name,Managerid,Manager.Name from user];
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE Name='test Account3'];
        List<opportunity> opportunities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN :accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN :opportunities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN:opportunities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata8 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ','Claire Kim','Working','2021',true);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData8 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata8);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata9 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('','','Booked','2020',true);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData9 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata9);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata10 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ','','','2020',true);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData10 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata10);
    }
    
    public static testmethod void unittest4(){
        List<User> userList = [select id,FirstName,Name,Managerid,Manager.Name from user where ID=:UserInfo.getUserID()];
        
        userList[0].CurrencyIsoCode ='JPY';
        update userList[0];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c];
        
        system.runas(userList[0]){
            
            List<Account> accounts = [select Territory__c,ID,Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE Name='test Account10'];
            List<opportunity> opportunities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN :accounts];
            for(Opportunity op1:opportunities){
                op1.currencyIsoCode = 'JPY';
            }
            update opportunities;
            
            List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN :opportunities];
            List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN:opportunities];
            
            List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
            List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata5 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEA','Claire Kim','Working','2021',true);
            List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData5 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata5);
            List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata6 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEA','Taku Seimiya','Working','2021',true);
            List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData6 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata6);
            
            
        }}
    public static testmethod void unittest5(){
        List<User> userList = [select id,FirstName,Name,Managerid,Manager.Name from user where userName='21Test111@test.com'];
        
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Manager.Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE owner.Id=:userList[0].Id];
        List<opportunity> opportuities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN: accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN : opportuities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN : opportuities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c WHERE user__c = :userList[0].Id];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ',accounts[0].Owner.Manager.Name,'Working','2019',false);
        revData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revData);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata);
        delete optyProds;
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata8 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('',accounts[0].Owner.Manager.Name,'','2021',false);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData8 = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata8);
    }
    public static testmethod void unittest6(){
        List<User> userList = [select id,FirstName,Name,Managerid,Manager.Name from user where userName='25Test555@test.com'];
        List<Account> accounts = [select Territory__c,ID,Name,Owner.Manager.Name,Owner.Id,Owner.Name,No_Of_Opportunities__c from account WHERE Name='test Account5'];
        List<opportunity> opportuities = [select id,Opportunity_Start_Date__c,Owner.Manager.Name,stageName,Amount,Opportunity_End_Date__c,Account.Owner.Name,probability,Jan__c,Feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunity WHERE AccountId IN: accounts];
        List<opportunitylineItem> optyProds = [select id,Start_Date_Custom__c,End_Date_Custom__c,Jan__c,feb__c,Mar__c,Apr__c,May__c,Jun__c,Jul__c,Aug__c,Sep__c,Oct__c,Nov__c,Dec__c from opportunitylineItem WHERE OpportunityId IN : opportuities];
        List<opportunitySplit> OppSplit = [SELECT ID,SplitPercentage,SplitOwner.Name from OpportunitySplit WHERE OpportunityId IN : opportuities];
        
        List<User_Goal__c> ug1 = [SELECT ID,User_Selected_Year__c,Q1_Goal__c,Q2_Goal__c,Q3_Goal__c,Q4_Goal__c,user__c FROM User_Goal__c WHERE user__c = :userList[0].Id];
        List<String> managerNames = globalQuarterlyRevenueBasesOnRegionCtrl.getOptyOwnerManagerData();
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('SIEJ',accounts[0].Owner.Manager.Name,'Working','2020',false);
        revData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revData);
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> optyData = globalQuarterlyRevenueBasesOnRegionCtrl.calculateGrandTotal(revdata);
        delete optyProds;
        List<globalQuarterlyRevenueBasesOnRegionCtrl.reportWrapper1> revdata8 = globalQuarterlyRevenueBasesOnRegionCtrl.prepareWrapperData('',accounts[0].Owner.Manager.Name,'','',false);
        
    }
    
}