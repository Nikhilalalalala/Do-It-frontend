import 'package:bloc/bloc.dart';
import 'package:doit/Service/TodosRepository.dart';
import 'package:meta/meta.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final todoRepository = TodoRepository();

  TodoCubit() : super(LoadingTodos());

  void getTodos() async {
    if (state is ListTodosSuccess == false) {
      emit(LoadingTodos());
    }
    try {
      final todos = await todoRepository.getAllTodos();
      emit(ListTodosSuccess(todos: todos));
    } catch (e) {
      emit(ListTodosFailure(exception: e));
    }
  }

  void createTodo(String name, String description, {String date_goal}) {
    date_goal != null
        ? todoRepository.createTodo(name, description, date_goal: date_goal)
        : todoRepository.createTodo(name, description);
  }
}
