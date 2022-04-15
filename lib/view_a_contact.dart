import 'package:flutter/material.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({Key? key}) : super(key: key);

  @override
  _ViewContactState createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    //define the argument
    final clickedContact =
        ModalRoute.of(context)!.settings.arguments as OneContact;

    return Scaffold(
      appBar: AppBar(
        title: const Text('View a Contact'),
      ),
      body: Center(
        child: ListTile(
          leading: const Icon(Icons.phone),
          title: Text(clickedContact.contactName),
          subtitle: Text(clickedContact.contactPhone),
        ),
      ),
    );
    // return Text(contactToView.contactName + contactToView.contactPhone);
  }
}

class OneContact {
  final String contactName;
  final String contactPhone;

  OneContact(this.contactName, this.contactPhone);
}
