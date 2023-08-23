import 'package:flutter/material.dart';
import 'dart:math';

class Fields {
  String task, place, time;
  Color logo;

  Fields({
    required this.task,
    required this.place,
    required this.time,
    required this.logo,
  });
}

class AddTask extends StatefulWidget {
  AddTask({super.key, required this.callBack});

  void Function(Fields) callBack;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();

  String? task, place, time;
  String valueChosen = '';

  var taskTypes = ['Bussiness', 'Serivce', 'Craft', 'Others'];

  List<Color> colors = const [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.amber,
    Colors.orangeAccent,
    Colors.tealAccent
  ];

  int colorIndex = Random().nextInt(5);

  String? currentTaskTypeSelected = 'Bussiness';

  final TextEditingController _task = TextEditingController();
  final TextEditingController _place = TextEditingController();
  final TextEditingController _time = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(156, 39, 176, 1),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(156, 39, 176, 1),
        title: const Text(
          'Add Task',
          style: TextStyle(fontSize: 25),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 10),
                margin: const EdgeInsets.all(50),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: colors[colorIndex],
                  borderRadius: BorderRadius.circular(75),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.center,
                  items: taskTypes.map(
                    (String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 209, 159, 217),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ).toList(),
                  onChanged: (String? newValueSelected) {
                    setState(
                      () {
                        currentTaskTypeSelected = newValueSelected;
                      },
                    );
                  },
                  value: currentTaskTypeSelected,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 75.0,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this.';
                    }
                    return null;
                  },
                  controller: _task,
                  decoration: const InputDecoration(
                    hintText: 'Task',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 209, 159, 217),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 75.0,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this.';
                    }
                    return null;
                  },
                  controller: _place,
                  decoration: const InputDecoration(
                    hintText: 'Place',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 209, 159, 217),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 75.0,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this.';
                    }
                    return null;
                  },
                  controller: _time,
                  decoration: const InputDecoration(
                    hintText: 'Time',
                    hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 209, 159, 217),
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue,
                    height: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.callBack(
                  Fields(
                      task: _task.text,
                      place: _place.text,
                      time: _time.text,
                      logo: colors[colorIndex]),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text(
              'Add Task',
            ),
          ),
        ),
      ),
    );
  }
}
