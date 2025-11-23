// lib/screens/contacts_list.dart
import 'package:flutter/material.dart';

class ContactsListScreen extends StatelessWidget {
  final List<Map<String, String>> contacts = List.generate(
    30,
        (i) => {
      'name': 'Contact ${i + 1}',
      'subtitle': 'Phone: 0123-456-${(1000 + i).toString()}'
    },
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: contacts.length,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (context, index) {
        final c = contacts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue[200],
            child: Text(
              c['name']!.split(' ').last, // placeholder initial-ish
              style: TextStyle(color: Colors.white),
            ),
          ),
          title: Text(c['name']!),
          subtitle: Text(c['subtitle']!),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Tapped ${c['name']}')),
            );
          },
        );
      },
    );
  }
}
