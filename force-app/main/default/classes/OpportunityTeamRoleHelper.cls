public class OpportunityTeamRoleHelper {
    public void autoAssignTeamrole(List<OpportunityTeamMember> teamRecs)
    {
        For(OpportunityTeamMember teamRec:teamRecs)
        {
            if(teamRec.TeamMemberRole==null)
            {
                teamRec.TeamMemberRole='Client Partner';	
            }
        }   
    }
}