import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import 'tags_settings.dart';

enum MenuItem { item1, item2 }

class AddCompraScreen extends StatefulWidget {
  @override
  _AddCompraScreenState createState() => _AddCompraScreenState();
}

class _AddCompraScreenState extends State<AddCompraScreen> {
  final _formKey = GlobalKey<FormState>();
  final _montoController = TextEditingController();
  String _categoria = 'Alimentación';
  List<String> _categorias = ['Alimentación']; // Inicialmente, solo contiene "Alimentación"

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    List<String> categorias = await DatabaseHelper.instance.consultarDatos();
    setState(() {
      _categorias = categorias;
      _categoria = categorias.isNotEmpty ? categorias[0] : 'Alimentación'; // Actualiza _categoria si hay categorías disponibles
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir Compra'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (value) {
              if (value == MenuItem.item1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TagsSettings()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MenuItem.item1,
                child: Text('Etiquetas'),
              ),
              const PopupMenuItem(
                value: MenuItem.item2,
                child: Text('Logout'),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _montoController,
                decoration: InputDecoration(labelText: 'Monto'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un monto';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _categoria,
                onChanged: (String? newValue) {
                  setState(() {
                    _categoria = newValue!;
                  });
                },
                items: _categorias
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseHelper.instance.insertCompra({
                      'monto': double.parse(_montoController.text),
                      'categoria': _categoria,
                      'fecha': DateTime.now().toIso8601String(),
                    });
                    Navigator.pop(context);
                  }
                },
                child: Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
