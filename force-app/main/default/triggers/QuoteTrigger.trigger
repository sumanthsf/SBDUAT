trigger QuoteTrigger on SBQQ__Quote__c (Before Insert,Before Update) {
    If(trigger.isInsert && trigger.isBefore){
        QuoteTriggerUtillityClass.PopulateContactInfoOnQuote(trigger.new);
    }
}