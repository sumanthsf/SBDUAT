trigger OpportunitySplitTrigger on OpportunitySplit (after insert) {

     
    
    List<OpportunitySplit> listTosendMail=new List<OpportunitySplit>();
    Public boolean sendMailCheck;
    OpportunitySplitHelper helper=new OpportunitySplitHelper();
  
   
    if(Trigger.isAfter )
    {
        if(Trigger.isInsert && OpportunitySplitHelper.firstRun)
        {
            OpportunitySplitHelper.firstRun=false;
       helper.restrictOtherUserIntoSplit(Trigger.new);
       }
    }
   /* if(!Trigger.isUpdate && Trigger.isInsert && firstRun && )
    {
         firstRun=false;
       helper.restrictOtherUserIntoSplit(Trigger.new);
	}
   /* if(!Trigger.isUpdate && Trigger.isInsert && firstRun && Trigger.isAfter)
    {
        firstRun=false;
       	if(!listTosendMail.isEmpty())
        {
            System.debug('inside list');
            for(OpportunitySplit split: listTosendMail)
            {
                helper.sendMail(split);
            }
        }
	}*/
}