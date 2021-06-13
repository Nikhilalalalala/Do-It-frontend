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

  void createTodo(String name, String description, {DateTime date_goal}) {
    date_goal != null
        ? todoRepository.createTodo(name, description, date_goal: date_goal)
        : todoRepository.createTodo(name, description);
    getTodos();
  }

  void intentionToCreateNewTodo() {
    emit(CreateNewTodo());
  }

  void updateTodoIsComplete(Todo todo, bool isComplete) async {
    await todoRepository.updateTodoIsDone(todo, isComplete);
    getTodos();
  }
  void deleteTodo(Todo todo) async {
    await todoRepository.deleteTodo(todo);
    getTodos();
  }

  void updateTodoDetails(Todo todo, String name, String description, DateTime dateGoal) async {
    await todoRepository.updateTodoDetails(todo, name, description, dateGoal);
    await getTodos();
  }

  void intentionToEditTodo(Todo todo) {
    emit(EditTodo(todo: todo));
  }

}
