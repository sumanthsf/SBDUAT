public class AgreementStatus {
public AgreementStatus (){}
/*public static void afterAgreementStatusInsert (List<Agreement_Status__c> AgreeList ) {
     updateContract(AgreeList);
  }

  public static void updateContract (List<Agreement_Status__c> AgreeList) {
    Set<Id> AgreeContractIdSet = new Set<Id>();
    for (Agreement_Status__c Agree : AgreeList) {
      AgreeContractIdSet.add(Agree.Contract__c);
    }
       //System.debug('AgreeContractIdSet ' + AgreeContractIdSet  );
    List<Contract> ContractListUpdate = new List<Contract>();
    List<Contract> ContractList = [select Id
                                     from Contract
                                     where Id in :AgreeContractIdSet];
    for (Agreement_Status__c Agree : AgreeList) {
      for(Contract Con : ContractList) {      
          Con.Agreement_Status__c = Agree.Agreement_Status__c;
          Con.Agreement_Date__c = Agree.Agreement_Status_Date__c;
          ContractListUpdate.add(Con);
        }
    }
    Database.update(ContractListUpdate);
  }*/
  }