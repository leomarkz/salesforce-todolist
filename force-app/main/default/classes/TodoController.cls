public with sharing class TodoController {

    @AuraEnabled(Cacheable=true)
    public static Todo__c[] searchTodos(String searchTerm) {
        searchTerm = searchTerm.trim();

        if (String.isEmpty(searchTerm)) {
            return [SELECT Id, Name, Concluded__c FROM Todo__c ORDER BY Name];
        }

        searchTerm = '%'+searchTerm+'%';

        return [SELECT Id, Name, Concluded__c FROM Todo__c WHERE Name LIKE :searchTerm ORDER BY Name];
    }

    @AuraEnabled
    public static void markTodo(String id, Boolean checked) {
        update new Todo__c(Id=id, Concluded__c=checked);
    }

    @AuraEnabled
    public static void deleteTodo(String id){
        delete new Todo__c(Id=id);
    }
}
