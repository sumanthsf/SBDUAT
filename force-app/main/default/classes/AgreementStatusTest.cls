@isTest
private class AgreementStatusTest {
static testMethod void UpdateContract_Test() {
AgreementStatus at=new AgreementStatus();
}

 /* static testMethod void UpdateContract_Test() {
  
    List<Agreement_Status__c> AgreeList = new List<Agreement_Status__c>();
    Set<Id> AgreeContractIdSet = new Set<Id>(); 
    List<Contract> ConttractList = new List<Contract>(); 
    Account aa = new Account(Name='Test Account',Playstation_3__c = true); 
    insert aa;
    Opportunity OO = new Opportunity(Name='Test Account PS3',AccountId=aa.Id,stageName='Technical Evaluation', closeDate = date.today());
    Contract cc = new Contract(Name='Test Contract',Opportunity__c = OO.Id, Agreement_Status__c = 'Test', Agreement_Date__c = date.today());
    Agreement_Status__c  Agree= new Agreement_Status__c();
    Agree.Agreement_Status__c = 'Test';
    Agree.Agreement_Status_Date__c =  date.today();
    Agree.Contract__c = cc.ContractNumber;
    AgreeList.add(Agree);
    insert AgreeList;
    AgreeContractIdSet.add(Agree.Contract__c);       
    List<Contract> ContractList = [select Id, Name,Agreement_Status__c
                                      from Contract
                                      where ContractNumber = :Agree.Contract__c ]; 
                                      
   
   insert ConttractList;                                  
   AgreementStatus.UpdateContract(AgreeList);   
                                
                                         
                            
      
                                   
    
     
  }*/
}