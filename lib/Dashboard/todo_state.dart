part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class LoadingTodos extends TodoState {}

class ListTodosSuccess extends TodoState {
  final List<Todo> todos;

  ListTodosSuccess({this.todos});
}

class ListTodosFailure extends TodoState {
  final Exception exception;

  ListTodosFailure({this.exception});
}

class TodoInitial extends TodoState {}

class CreateNewTodo extends TodoState {}

