Public Class QuoteTriggerUtillityClass{
    Public static Void PopulateContactInfoOnQuote(List<SBQQ__Quote__c> quoteNewList){
        Set<ID> oppIDSet = new Set<ID>();
        Map<ID,ID> OppContRoleToMediaContact = new Map<ID,ID>();
        Map<ID,ID> OppContRoleToBillingContact = new Map<ID,ID>();
        
        for(SBQQ__Quote__c qt : quoteNewList){
            oppIDSet.add(qt.SBQQ__Opportunity2__c);
        }
        
        
        for(OpportunityContactRole opcontrole: [Select id,OpportunityId,ContactId,Role from OpportunityContactRole where OpportunityId in :oppIDSet order by Createddate asc] ){
            if(opcontrole.Role == 'Media Contact' && OppContRoleToMediaContact.containsKey(opcontrole.OpportunityId) == false){
                OppContRoleToMediaContact.put(opcontrole.OpportunityId,opcontrole.ContactId);
            }else if(opcontrole.Role == 'Billing' && OppContRoleToBillingContact.containsKey(opcontrole.OpportunityId) == false){
                OppContRoleToBillingContact.put(opcontrole.OpportunityId,opcontrole.ContactId);
            }
        }
        
        for(SBQQ__Quote__c qtUpdate : quoteNewList){
            if (OppContRoleToMediaContact.containsKey(qtUpdate.SBQQ__Opportunity2__c) == true){
                qtUpdate.SBQQ__PrimaryContact__c = OppContRoleToMediaContact.get(qtUpdate.SBQQ__Opportunity2__c);
            }
            if (OppContRoleToBillingContact.containsKey(qtUpdate.SBQQ__Opportunity2__c) == true){
                qtUpdate.Billing_Contact__c = OppContRoleToBillingContact.get(qtUpdate.SBQQ__Opportunity2__c);
            }
            
        }
    }
}