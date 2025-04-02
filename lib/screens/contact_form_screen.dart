import 'package:actv_2/logic/contact_form_logic.dart';
import 'package:actv_2/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final ContactFormLogic _contactFormLogic = ContactFormLogic();
  List<Map<String, String>> contacts = []; // Lista para almacenar los contactos

 void _addContact() {
  // Muestra la alerta antes de limpiar los campos
  _contactFormLogic.showAlertDialog(
    context,
    onConfirm: () {
      setState(() {
        contacts.add({
          'name': _contactFormLogic.nameController.text,
          'email': _contactFormLogic.emailController.text,
          'phone': _contactFormLogic.phoneController.text,
        });

        _contactFormLogic.clearFields(); // Limpia los campos sin resetear el formulario
      });

      // Muestra la notificación de contacto guardado con estilo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Contacto guardado con éxito!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: Duration(seconds: 3),
        ),
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text('Formulario de Contactos')),
    drawer: CustomDrawer(
      contacts: contacts,
    ), // Ahora pasamos la lista real de contactos
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFE3F2FD), // Color pastel claro
            Color(0xFFBBDEFB), // Color pastel más oscuro
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _contactFormLogic.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _contactFormLogic.nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator:
                    (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                controller: _contactFormLogic.emailController,
                decoration: InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : 'Ingrese un correo válido',
              ),
              TextFormField(
                controller: _contactFormLogic.phoneController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator:
                    (value) => value!.isNotEmpty ? null : 'Ingrese un teléfono',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addContact, // Llama a la función para agregar contactos
                child: Text('Guardar Contacto'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}
