import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/database_helper.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Estadísticas')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.fetchCompras(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final compras = snapshot.data!;
          final totalGastado = compras.fold<double>(0.0, (sum, item) => sum + (item['monto'] as double));
          final categoriaGastos = _categorizeGastos(compras);

          return Column(
            children: [
              Text('Total gastado este mes: \$${totalGastado.toStringAsFixed(2)}'),
              Expanded(
                child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                    PieSeries<MapEntry<String, double>, String>(
                      dataSource: categoriaGastos.entries.toList(),
                      xValueMapper: (MapEntry<String, double> data, _) => data.key,
                      yValueMapper: (MapEntry<String, double> data, _) => data.value,
                      dataLabelMapper: (MapEntry<String, double> data, _) => '${data.key}: ${data.value.toStringAsFixed(2)}',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Map<String, double> _categorizeGastos(List<Map<String, dynamic>> compras) {
    final Map<String, double> categoriaGastos = {};

    for (var compra in compras) {
      final categoria = compra['categoria'];
      final monto = compra['monto'];

      if (!categoriaGastos.containsKey(categoria)) {
        categoriaGastos[categoria] = 0.0;
      }
      categoriaGastos[categoria] = categoriaGastos[categoria]! + monto;
    }

    return categoriaGastos;
  }
}
