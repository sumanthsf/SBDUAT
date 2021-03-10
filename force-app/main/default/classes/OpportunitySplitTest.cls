@isTest
public class OpportunitySplitTest {
    
    @testSetup static void setupData() {
        System.runAs ( new User(Id = UserInfo.getUserId()) ) {
        Opportunity oppRec=new Opportunity(name='abcOpp', StageName='In Contract', AdSales_CF_Start_Date__c = date.today(),  CloseDate =date.today()+20);
        insert oppRec;
            
      	Opportunity oppRec1=new Opportunity(name='puser000@amamama', StageName='In Contract', AdSales_CF_Start_Date__c = date.today(),  CloseDate =date.today()+20);
        insert oppRec1;
        User u = new User(
     	ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'].Id,
     	LastName = 'last',
     	Email = 'puser000@amamama.com',
     	Username = 'puser000@amamama.com' + System.currentTimeMillis(),
     	CompanyName = 'TEST',
     	Title = 'title',
     	Alias = 'alias',
     	TimeZoneSidKey = 'America/Los_Angeles',
     	EmailEncodingKey = 'UTF-8',
     	LanguageLocaleKey = 'en_US',
     	LocaleSidKey = 'en_US', UserRoleId=[Select Id, DeveloperName from UserRole where DeveloperName = 'Client_partners'].Id

);
        insert u;
             OpportunityTeamMember teamMember1 = new OpportunityTeamMember();
    		teamMember1.OpportunityId = oppRec1.Id;
    		teamMember1.OpportunityAccessLevel = 'Edit';
    		teamMember1.TeamMemberRole = 'Client Partner';
    		teamMember1.UserId = u.Id;
			insert teamMember1;
        OpportunitySplit split=new OpportunitySplit(SplitOwnerId= u.id, SplitPercentage=100, OpportunityId=oppRec1.Id );
        insert split;
        }  
    }

	@isTest static void testMethod1() {
         Opportunity oppRec=[select Id from Opportunity where name='abcOpp'];
       User u=[select Id from user where email='puser000@amamama.com' LIMIT 1];
        
        OpportunityTeamMember teamMember1 = new OpportunityTeamMember();
    		teamMember1.OpportunityId = oppRec.Id;
    		teamMember1.OpportunityAccessLevel = 'Edit';
    		teamMember1.TeamMemberRole = 'Client Partner';
    		teamMember1.UserId = u.Id;
			insert teamMember1;
        
        OpportunitySplit split=new OpportunitySplit(SplitOwnerId= u.id, SplitPercentage=100, OpportunityId=oppRec.Id );
        insert split;
        
        split.SplitNote='abc';
        update split;
       //OpportunitySplit split=[select Id,  SplitOwnerId, SplitPercentage from OpportunitySplit LIMIT 1];
        //Update split;
    }

    
    
   
}