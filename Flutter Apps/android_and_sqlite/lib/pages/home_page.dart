import 'package:android_and_sqlite/models/task.dart';
import 'package:android_and_sqlite/services/database_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  String? _taskContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: _addTaskButton(), body: _tasksList());
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Add Task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      _taskContent = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Task Content',
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (_taskContent == null || _taskContent!.isEmpty) {
                      return;
                    }
                    _databaseService.addTask(_taskContent!);
                    setState(() {
                      _taskContent = null;
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Done", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
      child: const Icon(Icons.add),
    );
  }

  Widget _tasksList() {
    return FutureBuilder(
      future: _databaseService.getTasks(),
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            Task task = snapshot.data![index];
            return ListTile(
              onLongPress: (() async {
                final result = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("This action will delete permanantly this data"),
                    actions: [
                      TextButton(
                        onPressed: ()=> Navigator.pop(context, false), 
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: ()=> Navigator.pop(context, true), 
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
                
                if (result == null || !result){
                  return;
                }

                _databaseService.deleteTask(task.id);
                setState(() {});

              }),
              title: Text(task.content),
              trailing: Checkbox(
                value: task.status == 1,
                onChanged: (value) {
                  _databaseService.updateTaskStatus(
                    task.id,
                    value == true ? 1 : 0,
                  );

                  setState(() {});
                },
              ),
            );
          },
        );
      },
    );
  }
}
