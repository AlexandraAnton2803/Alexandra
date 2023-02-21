/**
 * @description       : 
 * @author            : Alexandra Anton BearingPoint GmbH
 * @group             : 
 * @last modified on  : 02-21-2023
 * @last modified by  : Alexandra Anton, BearingPoint GmbH
**/
trigger CaseTrigger on Case (before insert) {
    CaseTriggerHandler.setPriorityByAnnualRevenue(Trigger.new);
}