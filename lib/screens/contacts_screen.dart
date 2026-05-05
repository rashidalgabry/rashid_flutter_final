import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/contact.dart';
import 'contact_details_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {

  
  List<Contact> contacts = [];
  List<Contact> filteredContacts = []; 
  TextEditingController searchController = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  
  Future<void> _loadContacts() async {
    final data = await DBHelper.instance.getAllContacts();
    setState(() {
      contacts = data;
      filteredContacts = data; 
    });
  }

  
  void _search(String query) {
    setState(() {
      filteredContacts = contacts.where((contact) {
        return contact.name.toLowerCase().contains(query.toLowerCase()) ||
               contact.phone.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),

      
      body: Column(
        children: [

         
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              onChanged: _search, // <<< ربط البحث
              decoration: const InputDecoration(
                hintText: 'Search by name or number',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];

                return ListTile(
                  title: Text(
                    contact.name.isEmpty ? 'Unknown' : contact.name,
                  ),
                  subtitle: Text(contact.phone),

                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ContactDetailsScreen(contact: contact),
                      ),
                    );

                    if (result == true) {
                      _loadContacts(); 
                    }
                  },

                  
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await DBHelper.instance.deleteContact(contact.id!);
                      _loadContacts();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
