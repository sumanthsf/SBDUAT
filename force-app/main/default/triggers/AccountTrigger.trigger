trigger AccountTrigger on Account (after insert, after update, before delete, 
  before insert, before update) {
  /*
  if (Trigger.isBefore) {
    if (Trigger.isInsert) {
      AccountManagement.beforeAccountInsert(Trigger.new); 
    } else if (Trigger.isUpdate){
      AccountManagement.beforeAccountUpdate(Trigger.new);
    }
  } else if (Trigger.isAfter) {
    if (Trigger.isInsert) {
     AccountManagement.afterAccountInsert(Trigger.new);   
    } else if (Trigger.isUpdate) {
    AccountManagement.afterAccountUpdate(Trigger.new, Trigger.oldMap); 
    } 
  }*/
}