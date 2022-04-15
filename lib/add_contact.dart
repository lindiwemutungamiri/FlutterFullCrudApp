import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  //declare the text controller
  TextEditingController contactName = TextEditingController();
  TextEditingController contactPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Add"),
      onPressed: () async {
        Navigator.of(context).pop(); // dismiss dialog
        var url = Uri.parse(
            'https://apps.ashesi.edu.gh/contactmgt/view/add_con_mobi');
        var response = await http.post(url,
            body: {'uname': contactName.text, 'unumber': contactPhone.text});

        Navigator.pushNamed(context, '/');
      },
    );
    return Column(
      children: <Widget>[
        const Text('Add New Contact'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            //  controller: cname,
            controller: contactName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Contact Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            controller: contactPhone,
            keyboardType: TextInputType.number,
            maxLength: 10,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Phone Number',
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            onPrimary: Colors.white,
          ),
          onPressed: () async {
            AlertDialog alert = AlertDialog(
              title: const Text("Confirm"),
              content:
                  const Text("Are you sure you want to Add a new contact?"),
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
          },
          child: const Text('Add Contact'),
        )
      ],
    );
  }
}
