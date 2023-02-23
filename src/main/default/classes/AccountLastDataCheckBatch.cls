/**
 * @description       : 
 * @author            : Alexandra Anton BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Alexandra Anton, BearingPoint GmbH
**/

public with sharing class AccountLastDataCheckBatch implements Database.Batchable<SObject> {

    /*
        *@description: Extract a list of accounts which have the date from LastDataCheck__c field more than 2 years ago.
        *@author Alexandra Anton, BearingPoint
        *@date 2023-02-23
    */

    public Database.QueryLocator start(Database.BatchableContext bc) {
        Date twoYearsAgo = Date.today().addDays(-2);
        return Database.getQueryLocator([SELECT Id FROM Account WHERE Account.LastDataCheck__c < :twoYearsAgo]);
    }

    /*
        *@description: Creates a task for each account from the list received.
        *@param list of accounts which need to be updated with a new task.
        *@author Alexandra Anton, BearingPoint
        *@date 2023-02-23
    */

    public void execute(Database.BatchableContext bc, List<Account> accounts) {
        List<Task> tasksToBeAssigned = new List<Task>();
        for (Account acc : accounts){
            Task taskToBeAssigned = new Task();
            taskToBeAssigned.Subject = 'Check if the contact information (email, phone, address, revenue) is still up to date';
            taskToBeAssigned.WhatId = acc.Id;
            tasksToBeAssigned.add(taskToBeAssigned);
        }

        insert tasksToBeAssigned;
    }

    public void finish(Database.BatchableContext bc){
        //code from Dev Console
        /*
            AccountLastDataCheckScheduler schedulerJob = new AccountLastDataCheckScheduler();
            String sch = '0 0 6 * * ?';
            String jobId = System.schedule('Assign task for accounts which have the date from LastDataCheck__c field more than 2 years ago.',  sch, schedulerJob);
         */
    }
}