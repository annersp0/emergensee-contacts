import 'package:flutter/material.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String selectedRelationship = 'Family';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 132, 9, 9),
        centerTitle: true,
        title: Text(
          'EmergenSee',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _navigateToSettingsPage(context);
            },
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.add_alert,
                    color: const Color.fromARGB(255, 132, 9, 9),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello, hooman!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text(
                'Let\'s keep your loved ones close in case of emergencies.',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              // Removed Expanded widget
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactCard(
                    contact: contacts[index],
                    onDelete: () {
                      setState(() {
                        contacts.removeAt(index);
                      });
                    },
                    onEdit: () {
                      _showAddContactBottomSheet(context, contact: contacts[index]);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddContactBottomSheet(context);
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromARGB(255, 132, 9, 9),
      ),
    );
  }

  void _navigateToSettingsPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingScreen()),
    );
  }

  void _showAddContactBottomSheet(BuildContext context, {Contact? contact}) {
    nameController.text = contact?.name ?? '';
    contactNumberController.text = contact?.contactNumber ?? '';
    addressController.text = contact?.address ?? '';
    selectedRelationship = contact?.relationship ?? 'Family';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: contactNumberController,
                  decoration: InputDecoration(labelText: 'Contact Number'),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedRelationship,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRelationship = newValue!;
                    });
                  },
                  items: <String>['Family', 'Friend', 'Partner', 'Guardian']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            contactNumberController.text.isNotEmpty &&
                            addressController.text.isNotEmpty) {
                          setState(() {
                            if (contact == null) {
                              contacts.add(Contact(
                                name: nameController.text,
                                contactNumber: contactNumberController.text,
                                address: addressController.text,
                                relationship: selectedRelationship,
                              ));
                            } else {
                              contact.name = nameController.text;
                              contact.contactNumber = contactNumberController.text;
                              contact.address = addressController.text;
                              contact.relationship = selectedRelationship;
                            }
                          });
                          nameController.clear();
                          contactNumberController.clear();
                          addressController.clear();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please fill in all fields.'),
                            ),
                          );
                        }
                      },
                      child: Text(contact == null ? 'Add' : 'Save'),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Contact {
  String name;
  String contactNumber;
  String address;
  String relationship;

  Contact({
    required this.name,
    required this.contactNumber,
    required this.address,
    required this.relationship,
  });
}

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ContactCard({
    Key? key,
    required this.contact,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(contact.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${contact.contactNumber}\n${contact.address}'),
            SizedBox(height: 5),
            Text('${contact.relationship}'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
