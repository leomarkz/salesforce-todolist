import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import searchTodos from '@salesforce/apex/TodoController.searchTodos';

export default class TodoList extends LightningElement {
    
    searchTerm = '';

    @wire(searchTodos, {searchTerm: '$searchTerm'})
    todoList;

    handleSearch(event) {
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		this.delayTimeout = setTimeout(() => {
            this.searchTerm = searchTerm;
		}, 200);
    }

    handleTodoUpdate() {
        console.log('atualizando');
        refreshApex(this.todoList);
    }

    get hasResults() {
        return this.todoList.data && this.todoList.data.length > 0;    
    }
}