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



trigger AccountSalaryTrigger on Account_Salary__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isUpdate){
        AccountSalaryHelper.updateAccount(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isDelete){
       AccountSalaryHelper.updateAccount(Trigger.old, null);
    } else {
       AccountSalaryHelper.updateAccount(Trigger.new, null);
    }
}
