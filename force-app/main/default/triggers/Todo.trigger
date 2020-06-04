trigger Todo on Todo__c (before delete) {

    for (Todo__c todo : Trigger.old) {
        if (todo.Concluded__c) {
            todo.addError('It is not possible to delete a completed task');
        }
    }
}