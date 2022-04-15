import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditContact extends StatefulWidget {
  const EditContact({Key? key}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  @override
  Widget build(BuildContext context) {
    //define the argument
    final getMyData =
        ModalRoute.of(context)!.settings.arguments as UpdateContact;

    //declare the text controller
    TextEditingController contactName =
        TextEditingController(text: getMyData.contactName);
    TextEditingController contactPhone =
        TextEditingController(text: getMyData.contactPhone);

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Update"),
      onPressed: () async {
        Navigator.of(context).pop(); // dismiss dialog
        var url =
            Uri.parse('https://apps.ashesi.edu.gh/contactmgt/view/up_date_con');
        var response = await http.post(url, body: {
          'conid': getMyData.contactID,
          'uname': contactName.text,
          'unumber': contactPhone.text
        });

        Navigator.pushNamed(context, '/');
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update a Contact'),
        ),
        body: Column(
          children: <Widget>[
            const Text('Update a Contact'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: contactName,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Update Name',
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
                  labelText: 'Update Number',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                onPrimary: Colors.white,
              ),
              onPressed: () async {
                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("Confirm"),
                  content: const Text(
                      "Are you sure you want to update this contact?"),
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
              child: const Text('Update Contact'),
            )
          ],
        ));
  }
}

class UpdateContact {
  final String contactID;
  final String contactName;
  final String contactPhone;

  UpdateContact(this.contactID, this.contactName, this.contactPhone);
}
