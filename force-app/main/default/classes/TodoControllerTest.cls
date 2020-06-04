@isTest
class TodoControllerTest {
    
    @testSetup
    static void makeData(){
        Todo__c todo1 = new Todo__c(Name='Task 1');
        Todo__c todo2 = new Todo__c(Name='Task 2', Concluded__c=true);
        
        insert new Todo__c[]{todo1, todo2};
    }

    @isTest
    static void searchAll() {
        Test.startTest();
        List <Todo__c> todos = TodoController.searchTodos('');    
        Test.stopTest();

        System.assertEquals(2, todos.size());
    }

    @isTest
    static void searchTodo() {
        Test.startTest();
        List <Todo__c> todos = TodoController.searchTodos('Task 2');    
        Test.stopTest();

        System.assertEquals(1, todos.size());
    }

    @isTest
    static void markTodo() {
        Todo__c todo = [SELECT Id, Concluded__c FROM Todo__c WHERE Name = 'Task 1'];

        Test.startTest();
        TodoController.markTodo(todo.Id, true);
        Test.stopTest();

        Todo__c afterTodo = [SELECT Id, Concluded__c FROM Todo__c WHERE Name = 'Task 1'];

        System.assertEquals(true, afterTodo.Concluded__c);
    }

    @isTest
    static void deleteTodo() {
        Todo__c todo = [SELECT Id, Concluded__c FROM Todo__c WHERE Name = 'Task 1'];

        Test.startTest();
        TodoController.deleteTodo(todo.Id);
        Test.stopTest();

        List<Todo__c> afterTodo = [SELECT Id, Concluded__c FROM Todo__c WHERE Name = 'Task 1'];

        System.assertEquals(0, afterTodo.size());

    }

    @isTest
    static void deleteTodoConcluded() {
        Todo__c todo = [SELECT Id, Concluded__c FROM Todo__c WHERE Name = 'Task 2'];

        try {
            Test.startTest();
            TodoController.deleteTodo(todo.Id);
            Test.stopTest();
            System.assert(false, 'Não bloqueou a exclusão de tarefa concluida');
        } catch(DmlException e) {
            System.assert(e.getMessage().contains('delete a completed task'));
        }
    }
}
