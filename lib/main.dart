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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PersistentTabsDemo(),
    );
  }
}

class PersistentTabs extends StatelessWidget {
  const PersistentTabs({required this.screenWidgets, this.currentTabIndex = 0, Key? key}) : super(key: key);
  final int? currentTabIndex;
  final List<Widget> screenWidgets;

  List<Widget> _buildOffstageWidgets() {
    return screenWidgets
        .map(
          (w) => Offstage(
            offstage: currentTabIndex != screenWidgets.indexOf(w),
            child: Navigator(
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(builder: (_) => w);
              },
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildOffstageWidgets(),
    );
  }
}

class PersistentTabsDemo extends StatefulWidget {
  const PersistentTabsDemo({Key? key}) : super(key: key);

  @override
  State<PersistentTabsDemo> createState() => _PersistentTabsDemoState();
}

class _PersistentTabsDemoState extends State<PersistentTabsDemo> {
  int? currentTabIndex;

  @override
  void initState() {
    super.initState();
    currentTabIndex = 0;
  }

  void setCurrentIndex(int val) {
    setState(() {
      currentTabIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabs(
        currentTabIndex: currentTabIndex,
        screenWidgets: const [Home(), StatsScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: setCurrentIndex,
        currentIndex: currentTabIndex!,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Estadísticas',
          ),
        ],
      ),
    );
  }
}

void _pushTo(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Hello Home!'),
                  Icon(Icons.home),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _pushTo(
                    context,
                    AddCompraScreen(),
                  );
                },
                child: const Text('Compras'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _pushTo(
                    context,
                    TableScreen(),
                  );
                },
                child: const Text('Tabla compras'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _pushTo(
                    context,
                    StatsScreen(),
                  );
                },
                child: const Text('Estadísticas'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: null,
                child: const Text('Próximamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
      body: const Center(
        child: Text('Aquí van las estadísticas'),
      ),
    );
  }
}

class AddCompraScreen extends StatelessWidget {
  const AddCompraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Compra'),
      ),
      body: const Center(
        child: Text('Pantalla para agregar compra'),
      ),
    );
  }
}

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Compras'),
      ),
      body: const Center(
        child: Text('Pantalla con tabla de compras'),
      ),
    );
  }
}
