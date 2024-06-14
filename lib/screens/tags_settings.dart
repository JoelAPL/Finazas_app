import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import 'add_compra.dart';

class TagsSettings extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _categoriaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurar Etiquetas'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _categoriaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Categoría'
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre de categoría';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseHelper.instance.insertCategoria({
                      'nombre': _categoriaController.text,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddCompraScreen())
                    );
                  }
                },
                child: Text('Guardar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
