public class EventManager {
    public void registerAttendee(Event__c event, Registration__c registration) {
        if (event.Remaining_Capacity__c > 0) {
            // Register attendee logic
            event.Registered_Attendees__c += 1;
            if (event.Remaining_Capacity__c == 0) {
                event.Status__c = 'Full';
            }
            update event;
        } else {
            throw new CapacityExceededException('Event is full.');
        }
    }

    public class CapacityExceededException extends Exception {}
}