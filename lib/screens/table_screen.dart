import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import 'edit_compra_screen.dart';

class TableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Compras')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.fetchCompras(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final compras = snapshot.data!;

          return DataTable(
            columns: [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Categoría')),
              DataColumn(label: Text('Monto')),
            ],
            rows: compras.map((compra) {
              return DataRow(
                cells: [
                  DataCell(Text(compra['id'].toString())),
                  DataCell(Text(compra['categoria'])),
                  DataCell(Text(compra['monto'].toString())),
                ],
                onSelectChanged: (selected) {
                  if (selected != null && selected) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditCompraScreen(compra: compra),
                      ),
                    );
                  }
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
