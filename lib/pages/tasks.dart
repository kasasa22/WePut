import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

import '../adapters/task_list_adapter.dart';
import '../models/task.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  ScrollController? _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _tabController!.dispose();
    super.dispose();
  }

  late BuildContext _scaffoldCtx;

  late PersistentBottomSheetController sheetController;

  @override
  Widget build(BuildContext context) {
    List<Task> items = [
      Task(
        taskId: '1',
        title: 'Complete Flutter App',
        description: 'Finish building the Flutter app for the project.',
        dueDate: Timestamp.now(),
        status: 'In-Progress',
        assignedUserId: 'user1',
        priority: 'High',
        category: 'Development',
        progress: 50,
        comments: ['Comment 1', 'Comment 2'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 4.5,
      ),
      Task(
        taskId: '2',
        title: 'Write Documentation',
        description: 'Document the features and usage of the app.',
        dueDate: Timestamp.now(),
        status: 'Assigned',
        assignedUserId: 'user2',
        priority: 'Medium',
        category: 'Documentation',
        progress: 20,
        comments: ['Comment 3', 'Comment 4'],
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
        evaluation: 3.8,
      ),
      // Add more tasks as needed
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Tasks"),
        actions: [
          PopupMenuButton(
            onSelected: (String value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
              PopupMenuItem(
                value: "About",
                child: IconButton(
                  onPressed: () {
                    //sign out the user
                    FirebaseAuth.instance.signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      //Drawer
      drawer: const MyDrawer(),

      floatingActionButton: FloatingActionButton(
        heroTag: "fab",
        backgroundColor: Colors.pink[500],
        elevation: 3,
        child: const Icon(
          Icons.add_task,
          color: Colors.white,
        ),
        onPressed: () {
          showSheet(context);
        },
      ),

      //Body
      body: Column(
        children: [
          TabBar(
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.blue,
            indicatorWeight: 4,
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Text("Assigned"),
              ),
              Tab(
                icon: Text("In-Progress"),
              ),
              Tab(
                icon: Text("Completed"),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return TaskTile(index: index, task: items[index]);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void showSheet(context) {
    TextStyle(color: Colors.white, height: 1.4, fontSize: 16);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Property Type",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      width: double.infinity,
                      height: 40,
                      decoration: myBoxDecoration(),
                      child: Stack(
                        children: [
                          new Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                "Appartment & Unit",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        new Flexible(
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Min Price",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              new Container(
                                width: double.infinity,
                                height: 40,
                                decoration: myBoxDecoration(),
                                child: Stack(
                                  children: [
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("1000"),
                                      ),
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerRight,
                                        child: new Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        Container(
                          width: 40,
                        ),
                        new Flexible(
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Max Price",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              new Container(
                                width: double.infinity,
                                height: 40,
                                decoration: myBoxDecoration(),
                                child: Stack(
                                  children: [
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("5000"),
                                      ),
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerRight,
                                        child: new Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        new Flexible(
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Min Bedrooms",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              new Container(
                                width: double.infinity,
                                height: 40,
                                decoration: myBoxDecoration(),
                                child: Stack(
                                  children: [
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("1000"),
                                      ),
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerRight,
                                        child: new Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                        Container(
                          width: 40,
                        ),
                        new Flexible(
                          child: Column(
                            children: <Widget>[
                              new Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Max Bedrooms",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ),
                              ),
                              new Container(
                                width: double.infinity,
                                height: 40,
                                decoration: myBoxDecoration(),
                                child: Stack(
                                  children: [
                                    new Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("5000"),
                                      ),
                                    ),
                                    new Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new Align(
                                        alignment: Alignment.centerRight,
                                        child: new Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Min Land size msq (optional)",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Container(
                      width: double.infinity,
                      height: 40,
                      decoration: myBoxDecoration(),
                      child: Stack(
                        children: [
                          new Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                "400",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          new Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: new Align(
                              alignment: Alignment.centerRight,
                              child: new Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: Text(
                          "SEARCH",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border.all(
      color: Colors.grey[300]!,
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(5.0) //
        ),
  );
}
