import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maker/components/drawer.dart';

class Boards extends StatefulWidget {
  const Boards({super.key});

  @override
  State<Boards> createState() => _BoardsState();
}

class _BoardsState extends State<Boards> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text("Boards"),
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
              children: const [
                Align(
                    child: Column(
                  children: [
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                    ListTile(
                      title: Text("Hello world"),
                      subtitle: Text("Hello world is awesome  and you can"),
                      trailing: Checkbox(value: false, onChanged: null),
                    ),
                  ],
                )),
                Align(
                  child: Text("hello2"),
                ),
                Align(
                  child: Text("hello1"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
