trigger SalaryTrigger on Account_Salary__c(after Insert,after Update,after Delete,after Undelete)
{
    if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate))
    {
        trgController.trgMethod(trigger.new,null,trigger.oldMap);
    }
    else if(trigger.isAfter && trigger.isDelete)
    {
        trgController.trgMethod(null,trigger.old,null);
    }
}
