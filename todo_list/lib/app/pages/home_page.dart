import 'package:flutter/material.dart';
import 'package:todo_list/app/controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  _start() {
    return Container();
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length ?? 0,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];

        return ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (bool value) {},
          ),
          title: Text(todo.title),
        );
      },
    );
  }

  _error() {
    return Center(
      child: RaisedButton(
        onPressed: () {
          controller.start();
        },
        child: Text("Tentar Novamente"),
      ),
    );
  }

  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO List"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: () {
              controller.start();
            },
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (_, __) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}
