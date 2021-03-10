public class OpportunitySplitHelper {
    Public static boolean firstRun=true;
    public void restrictOtherUserIntoSplit(List<OpportunitySplit> newSplit)
    {
        Map<boolean, OpportunitySplit> maptosendMail=new Map<boolean, OpportunitySplit>();
        Boolean OwnerAllowed=false;
        List<Id> opportunityId=new List<Id>();
       for(OpportunitySplit split: newSplit)
        {
            system.debug('newSplit:'+split);       
            Opportunity oppRec=[Select Id, OwnerId  from Opportunity where Id =: split.OpportunityId];
            Integer count=0;
            List<OpportunitySplit> existingSplit=[Select Id, SplitOwnerId, OpportunityId from OpportunitySplit where OpportunityId=:oppRec.Id ];
            System.debug('existingSplit.size'+existingSplit.size());
            
            if(!existingSplit.isEmpty())
            {
                 if(oppRec.OwnerId==split.SplitOwnerId)
                OwnerAllowed=true;
                    for(OpportunitySplit oppsplit:existingSplit)
                    {
                        System.debug('oppsplit'+oppsplit);
                     User usr=[Select Id, Name, UserRoleId From User where Id=: oppsplit.SplitOwnerId];
                        System.debug('usr'+usr.Name);
                      
                    UserRole role=null;
                    if(usr.UserRoleId!=null)
                    role=[Select Id, DeveloperName from UserRole where Id=: usr.UserRoleId];  
                        
                        if(role!=null)
                        {
                            System.debug(role.DeveloperName);
                            if(role.DeveloperName=='Client_partners')
                            {
                                count=count+1;
                                system.debug('count:'+count);
                               // maptosendMail.put(true, split);
                               // sendMailCheck=true;
                               //if(count!=1)
                                //sendMail(split);
                            }
                        }
                    }
                 }
           
            
            User usr=[Select Id, UserRoleId From User where Id=: split.SplitOwnerId];
            UserRole role=null;
            if(usr.UserRoleId!=null)
            role=[Select Id, DeveloperName,Name from UserRole where Id=: usr.UserRoleId];
            
            if(role!=null && oppRec!=null)
            {
                if (role.DeveloperName!='Client_partners' && count<=2 && !OwnerAllowed)
                {
                    split.AddError(role.Name+ ' user is not allowed for opportunity share');
                }
                System.debug('role.DeveloperName+ count'+role.DeveloperName+count);
                if(role.DeveloperName=='Client_partners' && count>2 && !OwnerAllowed)
                {
                    split.AddError('Split can have only 2 CP users');
                }
                if(role.DeveloperName=='Client_partners' && count<=2 && !OwnerAllowed)
                {
                    sendMail(split);
                }
            }
            
           
        }
    //return maptosendMail;
    }
    
    Public void sendMail(OpportunitySplit newSplit)
    {
        EmailTemplate et = [SELECT Id FROM EmailTemplate WHERE DeveloperName =:'AdSales_ET_Split_creation_notification'];
        User usr=[Select Id, Name, Email, UserRoleId From User where Id=: newSplit.SplitOwnerId];
       List<String> toAddresses=new List<String>();
        system.debug('user email'+usr.Email);
        toAddresses.add(usr.Email);
        toAddresses.add('truptali.paidalwar@gmail.com');
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTemplateId(et.Id);
            //mail.setToAddresses(toAddresses);
            system.debug('user ID'+usr.Id);
        system.debug('user split ID'+newSplit.Id);
            mail.setTargetObjectId(usr.Id);
            mail.setWhatId(newSplit.Id);
        
            mail.setSaveAsActivity(false);
            mail.setUseSignature(false);
     
        
        try {
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { mail });
          //  Messaging.sendEmail(allmsg,false);
            System.debug('message sent');
            return;
        } catch (Exception e) {
            System.debug(e.getMessage());
        }
    }
}