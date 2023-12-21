

import 'package:maker/models/user_models.dart';

class Message{
  final User sender;
  final String time;
  final String text;
  final bool unread;

  Message ({
    required this.sender,
    required this.time,
    required this.text,
    required this.unread

  });

}
//List of meessages in the chat 
List<Message>chats =[
  Message(
    sender: wallace,
    time: '5:20 PM',
    text: 'Bro, did you get today\'s slip',
    unread: true,
  ),
  Message(
    sender: nzaala,
    time: '11:20 PM',
    text: 'did you tap that tiktok challege',
    unread: true,
  ),
   Message(
    sender: conrad,
    time: '6:00 AM',
    text: 'Geee, i need the pc',
    unread: true,
  ),
   Message(
    sender: john,
    time: '7:20 PM',
    text: 'Man we should work today',
    unread: false,
  ),
   Message(
    sender: alvin,
    time: '1:20 PM',
    text: 'Mn sasa do u have 5k with you',
    unread: false,
  ),

];

//messages with in the chat

List<Message> messages =[
  Message(
    sender: wallace,
    time: '5:20 PM',
    text: 'Bro, did you get today\'s slip',
    unread: true,
  ),
   Message(
    sender: conrad,
    time: '6:00 AM',
    text: 'Geee, i need the pc',
    unread: true,
  ),
   Message(
    sender: john,
    time: '7:20 PM',
    text: 'Man we should work today',
    unread: false,
  ),
   Message(
    sender: alvin,
    time: '1:20 PM',
    text: 'Mn sasa do u have 5k with you',
    unread: false,
  ),
   Message(
    sender: currentUser,
    time: '1:20 PM',
    text: 'bro its late we should kick off for work',
    unread: false,
  ),

];