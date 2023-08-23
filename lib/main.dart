import 'package:flutter/material.dart';
import 'package:to_do_app_flutter/form.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();
  List<Item> tasks = [];

  // ignore: non_constant_identifier_names
  _MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // For Image at top.
              SizedBox(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/images/top_image.jpg'),
                ),
              ),

              // For "Inbox" text below image and above list view.
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: const [
                      Text(
                        "Inbox",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),

              // For viewing list of task using ListView.builder.
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.62,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      // For coloured circle in list tile.
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: tasks[index].logo,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      title: Text(
                        tasks[index].task,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        tasks[index].place,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(tasks[index].time),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: SizedBox(
              child: FloatingActionButton(
                onPressed: () async {
                  final item = await Navigator.of(context).push<Item>(
                    MaterialPageRoute(
                      builder: (context) => AddTask(
                        callBack: (taskData) {
                          setState(
                            () {
                              final item = Item(
                                task: taskData.task,
                                place: taskData.place,
                                logo: taskData.logo,
                                time: taskData.time,
                              );
                              tasks.add(item);
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
                tooltip: 'Add Task',
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String task;
  String place;
  String time;
  Color logo;

  Item({
    required this.task,
    required this.place,
    required this.time,
    required this.logo,
  });
}
