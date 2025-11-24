import 'package:flutter/material.dart';
import 'package:ds_fact/core/theme/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.primaryPurple,
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildKpiGrid(),
            const Expanded(
              child: SizedBox(), // Este widget ocupa todo el espacio disponible
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Bienvenido al Dashboard!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                ),
              ),
            ),
            // Aquí se pueden agregar más widgets como gráficos o tablas
          ],
        ),
      ),
    );
  }

  Widget _buildKpiGrid() {
    const kpiHeight = 120.0;
    const kpiData = [
      {'title': 'Ventas Hoy', 'value': '\$1,250', 'icon': Icons.monetization_on, 'color': Colors.green},
      {'title': 'Nuevos Clientes', 'value': '15', 'icon': Icons.person_add, 'color': Colors.blue},
      {'title': 'Pedidos Pendientes', 'value': '8', 'icon': Icons.pending_actions, 'color': Colors.orange},
      {'title': 'Ingresos Mes', 'value': '\$45,800', 'icon': Icons.bar_chart, 'color': AppTheme.primaryPurple},
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: SizedBox(height: kpiHeight, child: _buildKpiCard(kpiData[0]['title'] as String, kpiData[0]['value'] as String, kpiData[0]['icon'] as IconData, kpiData[0]['color'] as Color))),
            const SizedBox(width: 16),
            Expanded(child: SizedBox(height: kpiHeight, child: _buildKpiCard(kpiData[1]['title'] as String, kpiData[1]['value'] as String, kpiData[1]['icon'] as IconData, kpiData[1]['color'] as Color))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: SizedBox(height: kpiHeight, child: _buildKpiCard(kpiData[2]['title'] as String, kpiData[2]['value'] as String, kpiData[2]['icon'] as IconData, kpiData[2]['color'] as Color))),
            const SizedBox(width: 16),
            Expanded(child: SizedBox(height: kpiHeight, child: _buildKpiCard(kpiData[3]['title'] as String, kpiData[3]['value'] as String, kpiData[3]['icon'] as IconData, kpiData[3]['color'] as Color))),
          ],
        ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Usuario de Prueba",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("usuario@ejemplo.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "U",
                style: TextStyle(fontSize: 40.0, color: AppTheme.primaryPurple),
              ),
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryPurple,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar Sesión'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
