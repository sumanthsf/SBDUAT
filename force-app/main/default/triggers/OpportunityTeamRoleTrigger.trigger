trigger OpportunityTeamRoleTrigger on OpportunityTeamMember (before insert) {
    
    system.debug('coming inside');
    OpportunityTeamRoleHelper helper=new OpportunityTeamRoleHelper();
    helper.autoAssignTeamrole(Trigger.new);
}