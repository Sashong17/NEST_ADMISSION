import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class EmailDataTableWidget extends StatelessWidget {
  final List<Map<String, String>> data = [
    {"name": "John", "email": "harshacsem@gmail.com"},
    {"name": "Alice", "email": "harshagopi14@gmail.com"},
    {"name": "Bob", "email": "harshagopi03@gmail.com"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email DataTable'),
        actions: [
          IconButton(
            icon: Icon(Icons.email),
            onPressed: () {
              _sendEmailToAll();
            },
          ),
        ],
      ),
      body: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Email')),
        ],
        rows: data.map((item) {
          return DataRow(cells: [
            DataCell(Text(item['name'] ?? '')),
            DataCell(Text(item['email'] ?? '')),
          ]);
        }).toList(),
      ),
    );
  }

  _sendEmailToAll() async {
    List<String> emailList1 = data.map((item) => item['email'] ?? '').toList();
    //print(emailList);
    List<String> emailList = ["harshacsem@gmail.com","harshagopi14@gmail.com"];

    String emails = emailList1.join(', ');
    print(emails);
    //String url = 'https://mail.google.com/mail/?view=cm&to=$emails';
    final Uri params = Uri(
      scheme: 'https',
      host: 'mail.google.com',
      path: '/mail/',
      queryParameters: {
        'view': 'cm',
        'to': emails, // Replace with the recipient's email address
        'subject': 'Hello from Flutter', // Set your subject here
        'body': 'This is a test email sent from my Flutter app!', // Set your email body here
      },
      //add subject and body here
    );

    var url = params.toString();

    try {
      await launchUrl(params);
    } catch (e) {
      throw 'Could not launch email';
    }
    /*if (await canLaunchUrl()) {
      await launch('mailto:$emails');
    } else {
      throw 'Could not launch email';
    }*/
  }
}

void main() {
  runApp(MaterialApp(
      home: EmailDataTableWidget(),
      ));
}