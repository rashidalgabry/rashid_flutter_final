import 'package:flutter/material.dart';
import 'package:flutter_final/screens/call_screen.dart';
import '../database/db_helper.dart';
import '../models/contact.dart';
import 'add_contact_screen.dart';

class KeypadScreen extends StatefulWidget {
  const KeypadScreen({super.key});

  @override
  State<KeypadScreen> createState() => _KeypadScreenState();
}

class _KeypadScreenState extends State<KeypadScreen> {
  String phoneNumber = '';

  void _addNumber(String number) {
    setState(() {
      phoneNumber += number;
    });
  }

  void _deleteNumber() {
    if (phoneNumber.isNotEmpty) {
      setState(() {
        phoneNumber =
            phoneNumber.substring(0, phoneNumber.length - 1);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keypad'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            phoneNumber,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
               physics: const NeverScrollableScrollPhysics(), 
               childAspectRatio: 1.2, 
              children: [
                for (var i = 1; i <= 9; i++)
                  _keyButton(i.toString()),
                _keyButton('*'),
                _keyButton('0'),
                _keyButton('#'),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.backspace),
                onPressed: _deleteNumber,
              ),
             FloatingActionButton(
              child: const Icon(Icons.call),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CallScreen(phone: phoneNumber),
                  ),
                );
              },
            ),FloatingActionButton(
                heroTag: 'save',
                backgroundColor: Colors.blue,
                child: const Icon(Icons.save),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddContactScreen(phone: phoneNumber),
      ),
    );
  },
),


            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _keyButton(String text) {
    return InkWell(
      onTap: () => _addNumber(text),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
