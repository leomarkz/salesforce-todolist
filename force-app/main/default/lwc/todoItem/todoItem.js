import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import markTodo from '@salesforce/apex/TodoController.markTodo';
import deleteTodo from '@salesforce/apex/TodoController.deleteTodo';

export default class TodoItem extends LightningElement {

    @api todo;

    async handleMark() {
        await markTodo({id: this.todo.Id, checked: !this.todo.Concluded__c});
        this.dispatchEventTodoUpdate();    
    }

    get btnMarkVariant() {
        return this.todo.Concluded__c ? "brand" : "";
    }

    async handleDelete() {
        try {
            await deleteTodo({id: this.todo.Id});
            this.dispatchEventTodoUpdate();
        } catch(e) {
            if (e.body && e.body.pageErrors) {
               for (let err of e.body.pageErrors) {
                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: err.message,
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
               }     
            }   
        }

    }

    dispatchEventTodoUpdate() {
        this.dispatchEvent(new CustomEvent('todoupdate'));
    }

}