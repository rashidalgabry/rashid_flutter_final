import 'package:flutter/material.dart';
import '../database/db_helper.dart';

class RecentsScreen extends StatefulWidget {
  const RecentsScreen({super.key});

  @override
  State<RecentsScreen> createState() => _RecentsScreenState();
}

class _RecentsScreenState extends State<RecentsScreen> {
  List<Map<String, dynamic>> recents = [];

  @override
  void initState() {
    super.initState();
    _loadRecents();
  }

  Future<void> _loadRecents() async {
    final data = await DBHelper.instance.getRecents();
    setState(() {
      recents = data;
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recents'),
      ),
      body: ListView.builder(
        itemCount: recents.length,
        itemBuilder: (context, index) {
          final item = recents[index];
          return ListTile(
            leading: const Icon(Icons.call),
            title: Text(item['phone']),
            subtitle: Text(item['time']),
          );
        },
      ),
    );
  }
}
