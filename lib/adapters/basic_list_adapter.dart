// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  Color determineAvatarColor(String userId) {
    int asciiValue = userId.codeUnitAt(0);
    int colorValue = (asciiValue * 123456789) % 0xFFFFFF;
    return Color(colorValue | 0xFF000000);
  }

  @override
  Widget build(BuildContext context) {
    Color avatarColor = determineAvatarColor(widget.object.userId);

    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: avatarColor,
            child: Text(
              widget.object.userId.substring(0, 1).toUpperCase(),
              style: TextStyle(
                color: Colors.grey[880],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            widget.object.message,
            style: TextStyle(
              color: Colors.grey[880],
            ),
          ),
          subtitle: Text(
            DateFormat('dd MMM yyyy HH:mm')
                .format(widget.object.timestamp.toDate()), // Format timestamp
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          trailing: widget.object.viewed
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.visibility,
                  color: Colors.blue,
                ),
          onTap: () {
            // Handle tapping on the notification
            print('Notification tapped: ${widget.object.message}');
          },
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1,
        ),
      ],
    );
  }
}
