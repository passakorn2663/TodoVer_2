import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo2/provider/storage.dart';
import 'package:todo2/model/todo.dart';

import './todos.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading());

  @override
  TodosState get initialState {
    return TodosLoading();
  }

  @override
  Stream<TodosState> mapEventToState(
    TodosEvent event,
  ) async* {
    if (event is LoadTodos) {
      yield* _mapLoadTodosToState();
    } else if (event is AddTodos) {
      yield* _mapAddTodosToState(event);
    } else if (event is UpdateTodos) {
      yield* _mapUpdateTodosToState(event);
    } else if (event is DeleteTodos) {
      yield* _mapDeleteTodosToState(event);
    }
  }

  Stream<TodosState> _mapLoadTodosToState() async* {
    try {
      final todos = await FileStorage().loadTodos();
      yield TodosLoaded(todos);
    } catch (_) {
      yield TodosNotLoaded();
    }
  }

  Stream<TodosState> _mapAddTodosToState(AddTodos event) async* {
    if (state is TodosLoaded) {
      final List<TodoModel> updatedTodos =
          List.from((state as TodosLoaded).todos);
      updatedTodos.add(event.todo);
      _saveTodos(updatedTodos);
      yield TodosLoaded(updatedTodos);
    }
  }

  Stream<TodosState> _mapUpdateTodosToState(UpdateTodos event) async* {
    if (state is TodosLoaded) {
      final List<TodoModel> updatedTodos =
          (state as TodosLoaded).todos.map((todo) {
        return todo.id == event.updateTodo.id ? event.updateTodo : todo;
      }).toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Stream<TodosState> _mapDeleteTodosToState(DeleteTodos event) async* {
    if (state is TodosLoaded) {
      final List<TodoModel> updatedTodos = (state as TodosLoaded)
          .todos
          .where((todo) => todo.id != event.deleteTodo.id)
          .toList();
      yield TodosLoaded(updatedTodos);
      _saveTodos(updatedTodos);
    }
  }

  Future _saveTodos(List<TodoModel> todos) {
    return FileStorage().saveTodos(todos);
  }
}
