/**
 * @description       : 
 * @author            : Alexandra Anton BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-23-2023
 * @last modified by  : Alexandra Anton, BearingPoint GmbH
**/
public with sharing class AccountTriggerHandler {
    
    public static void generateCards(List<Account> newAccounts) {
        for (Account acc : newAccounts) {
            System.enqueueJob(new GenerateQrCodeQueueable(acc));
        }
    }
}