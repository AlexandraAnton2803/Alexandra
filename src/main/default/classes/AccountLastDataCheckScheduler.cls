/**
 * @description       : 
 * @author            : Alexandra Anton BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Alexandra Anton BearingPoint GmbH
**/
public with sharing class AccountLastDataCheckScheduler implements Schedulable {
    public void execute(SchedulableContext sc){
        Database.executeBatch(new AccountLastDataCheckBatch());
    }
}