trigger AccountSalaryTrigger on Account_Salary__c (after insert, after update, after delete, after undelete) {
    if (Trigger.isUpdate){
        AccountSalaryHelper.updateAccount(Trigger.new, Trigger.oldMap);
    } else if (Trigger.isDelete){
       AccountSalaryHelper.updateAccount(Trigger.old, null);
    } else {
       AccountSalaryHelper.updateAccount(Trigger.new, null);
    }
}







trigger SalaryTrigger on Account_Salary__c(after Insert,after Update,after Delete,after Undelete)
{
    Set<Id> acctIdSet = new Set<Id>();
    
    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete))
    {
        for(Account_Salary__c ast : trigger.new)
        {
            if(ast.Account__c != null)
            {
                acctIdSet.add(ast.Account__c);
            }
        }
    }
    
    if(trigger.isAfter && trigger.isUpdate)
    {
        for(Account_Salary__c ast : trigger.new)
        {
            if(ast.Account__c != trigger.oldMap.get(ast.Id).Account__c)
            {
                acctIdSet.add(ast.Account__c);
                acctIdSet.add(ast.Account__c);
            }
            else
            {
                acctIdSet.add(ast.Account__c);
            }
        }
    }
    
    if(trigger.isAfter && trigger.isDelete)
    {
        for(Account_Salary__c ast : trigger.old)
        {
            if(ast.Account__c != null)
            {
                acctIdSet.add(ast.Account__c);
            }
        }
    }

Map<Id, Account> accountsToUpdateMap = new Map<Id, Account>();

for(Id acctId :acctIdSet){
    accountsToUpdateMap.put(acctId, 
       
        new Account(
            Id = acctId,
            Min_Salary__c = 0,
            Max_Salary__c = 0
        )
    );
}
List<AggregateResult> aggrList = [Select Account__c acId,max(Salary__c) maxSalary,min(Salary__c) minSalary from Account_Salary__c
                                 where Account__c IN : acctIdSet group by Account__c];
    
for(AggregateResult result : aggrList)
{
    accountsToUpdateMap.put((Id)result.get('acId'),
    new Account
    (
            Id = (Id)result.get('acId'),
            Min_Salary__c = (Decimal)result.get('minSalary'),
            Max_Salary__c = (Decimal)result.get('maxSalary')
    )
    );
}

update accountsToUpdateMap.values();
}
