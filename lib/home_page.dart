import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'update_contact.dart';
import 'view_a_contact.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //declare the list array
  List allContact = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allContact.length,
      itemBuilder: (context, index) {
        Widget cancelButton = TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop(); // dismiss dialog
          },
        );
        Widget continueButton = TextButton(
          child: const Text("Delete"),
          onPressed: () {
            Navigator.of(context).pop(); // dismiss dialog
            deleteContactMethod(allContact[index]['pid']);
          },
        );
        return ListTile(
          title: Text(allContact[index]['pname']),
          subtitle: Text(allContact[index]['pphone']),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/viewContact',
                        arguments: OneContact(allContact[index]['pname'],
                            allContact[index]['pphone']));
                  },
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/updateContact',
                        arguments: UpdateContact(
                            allContact[index]['pid'],
                            allContact[index]['pname'],
                            allContact[index]['pphone']));
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: const Text("Confirm"),
                      content: const Text(
                          "Are you sure you want to delete this contact?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );

                    //call the delete method
                    // deleteContactMethod(allContact[index]['pid']);
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContactMethod();
  }

  //write your own method to get all contacts
  void getContactMethod() async {
    var url =
        Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/getallcontact');
    var response = await http.get(url);

    setState(() {
      allContact = jsonDecode(response.body);
    });
  }

  //write a method for delete
  void deleteContactMethod(contactID) async {
    var url =
        Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/delcontact');
    var response = await http.post(url, body: {'ppid': contactID});

    //to reset the list after delete
    //call the get contact method
    getContactMethod();
  }
}
