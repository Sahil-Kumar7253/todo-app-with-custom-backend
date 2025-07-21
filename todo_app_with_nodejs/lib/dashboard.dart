import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Services/api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> todos = [];
  String? token;
  final TextEditingController todocontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
    });

    if (token == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      await loadTodos();
    }
  }

  Future<void> loadTodos() async {
    if (token == null) return;
    final fetchedTodos = await ApiService.getTodo(token!);
    if (mounted) {
      setState(() {
        todos = fetchedTodos;
      });
    }
  }

  Future<void> deleteTodo(String id) async {
    if (token == null) return;
    await ApiService.deleteTodo(token!, id);
    await loadTodos();
  }

  Future<void> toggleComplete(String id, bool currentStatus) async {
    if (token == null) return;
    await ApiService.toggleTodo(token!, id, !currentStatus);

    if (mounted) {
      final List<dynamic> updatedTodos = List.from(todos);
      final int index = updatedTodos.indexWhere((todo) => todo['_id'] == id);
      if (index != -1) {
        final Map<String, dynamic> updatedTodo =
        Map.from(updatedTodos[index]);
        updatedTodo['completed'] = !currentStatus;
        updatedTodos[index] = updatedTodo;
        setState(() {
          todos = updatedTodos;
        });
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadTodos,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            final bool isCompleted = todo['completed'] ?? false;
            return Card(
              margin:
              const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                key: ValueKey(todo['_id']),
                title: Text(
                  todo['title'],
                  style: TextStyle(
                    color: isCompleted ? Colors.grey : Colors.black,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete Todo"),
                    content: const Text(
                        "Are you sure you want to delete this item?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await deleteTodo(todo['_id']);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ),
                trailing: isCompleted
                    ? null
                    : Checkbox(
                  value: isCompleted,
                  onChanged: (bool? value) {
                    toggleComplete(todo['_id'], isCompleted);
                  },
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Add Todo"),
              content: TextField(
                controller: todocontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter Todo",
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () async {
                    if (todocontroller.text.trim().isNotEmpty) {
                      Navigator.pop(context);
                      await ApiService.addInTodoList(
                        token!,
                        todocontroller.text.trim(),
                      );
                      todocontroller.clear();
                      await loadTodos();
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}