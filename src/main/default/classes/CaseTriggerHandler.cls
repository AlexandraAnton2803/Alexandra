/**
 * @description       : 
 * @author            : Alexandra Anton BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Alexandra Anton, BearingPoint GmbH
**/
public with sharing class CaseTriggerHandler {
    public static void setPriorityByAnnualRevenue(List<Case> cases) {
        Set<Id> casesIds = new Set<Id>();
        for (Case cs: cases){
            casesIds.add(cs.AccountId);
        }
        List<Account> casesAccounts = [SELECT Id, AnnualRevenue FROM Account WHERE Id IN :casesIds];
        Map<Id, Decimal> AnnualRevenueByAccountId = new Map<Id, Decimal>();
        for (Account acc : casesAccounts){
            AnnualRevenueByAccountId.put(acc.Id, acc.AnnualRevenue);
        }
        for (Case cs:cases){
            Decimal annualRev = AnnualRevenueByAccountId.get(cs.AccountId);
            String annRevString;

            if (annualRev >= 100000 && annualRev <= 500000){
                annRevString = 'Medium';
            }
            if (annualRev > 500000) {
                annRevString = 'High';
            }
            if (annualRev < 100000){
                annRevString = 'Low';
            }

            if (cs.Priority != annRevString){
                cs.Description = 'The priority has been updated automatically!';
            }

            cs.Priority = annRevString;
        }
    }
}