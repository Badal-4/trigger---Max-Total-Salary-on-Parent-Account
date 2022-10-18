trigger AccountSalaryTrigger on Account_Salary__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isUpdate){
        AccountSalaryHelper.updateAccount(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isDelete){
       AccountSalaryHelper.updateAccount(Trigger.old, null);
    } else {
       AccountSalaryHelper.updateAccount(Trigger.new, null);
    }
}
