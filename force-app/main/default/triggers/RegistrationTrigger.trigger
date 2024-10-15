trigger RegistrationTrigger on Registration__c (after insert, after update, after delete) {
    List<Event__c> eventsToUpdate = new List<Event__c>();

    if (Trigger.isInsert || Trigger.isUpdate) {
        for (Registration__c reg : Trigger.new) {
            Event__c event = [SELECT Id, Capacity__c, Registered_Attendees__c FROM Event__c WHERE Id = :reg.Event__c];
            if (event.Remaining_Capacity__c == 0) {
                event.Status__c = 'Full';
                eventsToUpdate.add(event);
            }
        }
    }

    if (eventsToUpdate.size() > 0) {
        update eventsToUpdate;
    }
}