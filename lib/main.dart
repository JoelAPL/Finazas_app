 import 'package:flutter/material.dart';
import 'screens/add_compra.dart';
import 'screens/stats_screen.dart';
import 'screens/table_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finanzas Mensuales',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Finanzas Mensuales')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCompraScreen()),
                );
              },
              child: Text('Compras'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TableScreen()),
                );
              },
              child: Text('Tabla compras'),
            ),
            ElevatedButton(
              onPressed: null,
              child: Text('Próximamente'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen()),
                );
              },
              child: Text('Estadísticas'),
            ),
          ],
        ),
      ),
    );
  }
}
