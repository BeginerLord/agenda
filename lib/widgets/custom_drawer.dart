import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final List<Map<String, String>> contacts;
  
  const CustomDrawer({super.key, required this.contacts});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text('Menú', style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: Icon(Icons.contact_mail),
            title: Text('Formulario'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Lista de Contactos'),
            onTap: () {
              Navigator.of(context).pop();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Lista de Contactos'),
                    content: SizedBox(
                      width: double.maxFinite,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(contacts[index]['name']!),
                            subtitle: Text('${contacts[index]['email']} - ${contacts[index]['phone']}'),
                          );
                        },
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}