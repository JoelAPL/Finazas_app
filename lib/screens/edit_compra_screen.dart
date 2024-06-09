import 'package:flutter/material.dart';
import '../data/database_helper.dart';

class EditCompraScreen extends StatefulWidget {
  final Map<String, dynamic> compra;

  EditCompraScreen({required this.compra});

  @override
  _EditCompraScreenState createState() => _EditCompraScreenState();
}

class _EditCompraScreenState extends State<EditCompraScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _montoController;
  late String _categoria;

  @override
  void initState() {
    super.initState();
    _montoController = TextEditingController(text: widget.compra['monto'].toString());
    _categoria = widget.compra['categoria'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Compra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _categoria,
                onChanged: (String? newValue) {
                  setState(() {
                    _categoria = newValue!;
                  });
                },
                items: <String>['Alimentación', 'Casa', 'Transporte', 'Ropa']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(labelText: 'Categoría'),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseHelper.instance.updateCompra({
                        'id': widget.compra['id'],
                        'monto': double.parse(_montoController.text),
                        'categoria': _categoria,
                        'fecha': widget.compra['fecha'],
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Compra actualizada exitosamente')),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Actualizar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
