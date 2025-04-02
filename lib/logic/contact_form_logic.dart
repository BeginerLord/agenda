
import 'package:flutter/material.dart';

class ContactFormLogic {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void clearFields() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
  }

 void showAlertDialog(BuildContext context, {required VoidCallback onConfirm}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Confirmación'),
        content: Text('¿Desea guardar el contacto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm(); // Llama a la función de confirmación
              saveContact(context);
            },
            child: Text('Aceptar'),
          ),
        ],
      );
    },
  );
}

  void saveContact(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Contacto guardado con éxito')),
      );
    }
  }
}