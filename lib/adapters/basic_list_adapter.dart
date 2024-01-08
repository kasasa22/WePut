import 'package:flutter/material.dart';

import '../models/notification.dart';

class ListExpandAdapter {
  List? items = <Message>[];
  List itemsTile = <ItemTile>[];

  ListExpandAdapter(this.items) {
    for (int i = 0; i < items!.length; i++) {
      itemsTile.add(ItemTile(index: i, object: items![i]));
    }
  }

  Widget getView() {
    return ListView.builder(
      itemCount: itemsTile.length,
      itemBuilder: (BuildContext context, int index) {
        return itemsTile[index];
      },
    );
  }
}

class ItemTile extends StatefulWidget {
  final int index;
  final Message object;

  const ItemTile({
    Key? key,
    required this.index,
    required this.object,
  }) : super(key: key);

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
        ),
        ExpansionTile(
          leading: SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                widget.object.userId.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  color: Colors.grey[880],
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          key: PageStorageKey<int>(widget.index),
          title: Text(
            widget.object.message,
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(widget.object.message,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.grey[880],
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
