import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';

import 'controllers/member_controller.dart';
import 'models/member_model.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key}) : super(key: key);

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final MemberController _memberController = MemberController();
  final List<Members> allMembers = [];

  final List<String> number = [];

  void initState() {
    _memberController.getAllMembers().then((member) {
      for (Members element in member) {
        allMembers.add(element);
       
        setState(() {});
        //  print("these are members $member");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                String message = "This is a test message!";
                List<String> recipents = allMembers[1].contact;

                _sendSMS(message, recipents);
              },
              child: const Icon(Icons.send))
        ],
      ),
    );
  }
}

void _sendSMS(String message, List<String> recipents) async {
  String _result = await sendSMS(message: message, recipients: recipents)
      .catchError((onError) {
    print(onError);
  });
  print(_result);
}
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_sms/flutter_sms.dart';


// class MessagingPage extends StatefulWidget {
//   @override
//   _MessagingPageState createState() => _MessagingPageState();
// }

// class _MessagingPageState extends State<MessagingPage> {
//   late TextEditingController _controllerPeople, _controllerMessage;
//   String? _message, body;
//   String _canSendSMSMessage = 'Check is not run.';
//   List<String> people = [];

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     _controllerPeople = TextEditingController();
//     _controllerMessage = TextEditingController();
//   }

//   Future<void> _sendSMS(List<String> recipients) async {
//     try {
//       String _result = await sendSMS(
//           message: _controllerMessage.text, recipients: recipients);
//       setState(() => _message = _result);
//     } catch (error) {
//       setState(() => _message = error.toString());
//     }
//   }

//   Future<bool> _canSendSMS() async {
//     bool _result = await canSendSMS();
//     setState(() => _canSendSMSMessage =
//         _result ? 'This unit can send SMS' : 'This unit cannot send SMS');
//     return _result;
//   }

//   Widget _phoneTile(String name) {
//     return Padding(
//       padding: const EdgeInsets.all(3),
//       child: Container(
//           decoration: BoxDecoration(
//               border: Border(
//             bottom: BorderSide(color: Colors.grey.shade300),
//             top: BorderSide(color: Colors.grey.shade300),
//             left: BorderSide(color: Colors.grey.shade300),
//             right: BorderSide(color: Colors.grey.shade300),
//           )),
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => setState(() => people.remove(name)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Text(
//                     name,
//                     textScaleFactor: 1,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('SMS/MMS Example'),
//         ),
//         body: ListView(
//           children: <Widget>[
//             if (people == null || people.isEmpty)
//               const SizedBox(height: 0)
//             else
//               SizedBox(
//                 height: 90,
//                 child: Padding(
//                   padding: const EdgeInsets.all(3),
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: List<Widget>.generate(people.length, (int index) {
//                       return _phoneTile(people[index]);
//                     }),
//                   ),
//                 ),
//               ),
//             ListTile(
//               leading: const Icon(Icons.people),
//               title: TextField(
//                 controller: _controllerPeople,
//                 decoration:
//                     const InputDecoration(labelText: 'Add Phone Number'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (String value) => setState(() {}),
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: _controllerPeople.text.isEmpty
//                     ? null
//                     : () => setState(() {
//                           people.add(_controllerPeople.text.toString());
//                           _controllerPeople.clear();
//                         }),
//               ),
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.message),
//               title: TextField(
//                 decoration: const InputDecoration(labelText: 'Add Message'),
//                 controller: _controllerMessage,
//                 onChanged: (String value) => setState(() {}),
//               ),
//             ),
//             const Divider(),
//             ListTile(
//               title: const Text('Can send SMS'),
//               subtitle: Text(_canSendSMSMessage),
//               trailing: IconButton(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 icon: const Icon(Icons.check),
//                 onPressed: () {
//                   _canSendSMS();
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith(
//                       (states) => Theme.of(context).accentColor),
//                   padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(vertical: 16)),
//                 ),
//                 onPressed: () {
//                   _send();
//                 },
//                 child: Text(
//                   'SEND',
//                   style: Theme.of(context).accentTextTheme.button,
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: _message != null,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Text(
//                         _message ?? 'No Data',
//                         maxLines: null,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _send() {
//     if (people.isEmpty) {
//       setState(() => _message = 'At Least 1 Person or Message Required');
//     } else {
//       _sendSMS(people);
//     }
//   }
// }
