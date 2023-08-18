import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_32_bloc_test/bloc/task_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskBloc taskBloc = TaskBloc();

  @override
  void initState() {
    taskBloc.add(GetTaskEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocConsumer<TaskBloc, TaskState>(
                bloc: taskBloc,
                listenWhen: (pre, cur) => cur is TasksActionState,
                buildWhen: (pre, cur) => cur is! TasksActionState,
                listener: (context, state) {
                  if (state is UpdateTaskSuccessState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Updated')));
                  } else if (state is DeleteTaskSuccessState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Deleted')));
                  }
                },
                builder: (context, state) {
                  print(state);
                  switch (state.runtimeType) {
                    case TaskLoadingState:
                      return CircularProgressIndicator();
                    case TaskSuccessState:
                      final successState = state as TaskSuccessState;
                      if (successState.dataTasks.isEmpty) {
                        return Text(
                          "Empty Task",
                          style: TextStyle(fontSize: 25),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: successState.dataTasks.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  child: Text(successState.dataTasks[index].id
                                      .toString()),
                                ),
                                title:
                                    Text(successState.dataTasks[index].title),
                              );
                            });
                      }
                    default:
                      return Text("...");
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        taskBloc.add(AddTaskEvent(
                            nameAdd: "I just added new title text Khoa"));
                      },
                      child: Text("Click me to add")),
                  ElevatedButton(
                      onPressed: () {
                        taskBloc.add(UpdateTaskEvent(
                            newName: "I just updated title text 999"));
                      },
                      child: Text("Click me to update")),
                  ElevatedButton(
                      onPressed: () {
                        taskBloc.add(DeleteTaskEvent(idDelete: 3));
                      },
                      child: Text("Click me to delete"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
