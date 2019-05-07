
import 'package:filter_menu_ui_challenge/task.dart';
import 'package:filter_menu_ui_challenge/task_row.dart';
import 'package:flutter/material.dart';

class TaskList{
  final List<Task> tasks = [
    new Task(
        name: "Catch up with Brian",
        category: "Mobile Project",
        time: "5pm",
        color: Colors.orange,
        completed: false),
    new Task(
        name: "Make new icons",
        category: "Web App",
        time: "3pm",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Design explorations",
        category: "Company Website",
        time: "2pm",
        color: Colors.pink,
        completed: false),
    new Task(
        name: "Lunch with Mary",
        category: "Grill House",
        time: "12pm",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Teem Meeting",
        category: "Hangouts",
        time: "10am",
        color: Colors.cyan,
        completed: true),
    new Task(
        name: "Learn GRE",
        category: "Learning",
        time: "10pm",
        color: Colors.yellow,
        completed: true),
    new Task(
        name: "Watching TV",
        category: "Entertainment",
        time: "12pm",
        color: Colors.grey,
        completed: true),
  ];

  Widget buildTasksList() {
    return new Expanded(
      child: new ListView(
        children: tasks.map((task) => new TaskRow(task: task)).toList(),
      ),
    );
  }
}