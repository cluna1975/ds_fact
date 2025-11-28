import 'package:flutter/material.dart';
import 'package:ds_fact/core/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Parameters for customization
  final double sidebarWidth = 250.0;
  final double topBarHeight = 60.0;
  final Color topBarColor = const Color(0xFFF5F7FA); // Light grey/blueish
  final Color sidebarColor = const Color(0xFFF5F7FA);
  final Color contentBackgroundColor = Colors.white;
  final Color activeItemColor = const Color(0xFFE3F2FD); // Light blue for selection
  
  String _selectedId = 'dashboard'; // Use ID for selection
  bool _isSidebarExpanded = true;

  // Menu Data Structure
  final List<MenuItem> _menuItems = [
    MenuItem(
      id: 'dashboard',
      title: 'Tablero',
      icon: Icons.dashboard_outlined,
    ),
    MenuItem(
      id: 'tramites',
      title: 'Trámites',
      icon: Icons.folder_open_outlined,
      children: [
        MenuItem(id: 'tramites_nuevo', title: 'Nuevo Trámite', icon: Icons.add),
        MenuItem(id: 'tramites_consultar', title: 'Consultar', icon: Icons.search),
        MenuItem(id: 'tramites_consultas', title: 'Consultas', icon: Icons.question_answer_outlined),
      ],
    ),
    MenuItem(
      id: 'buzon',
      title: 'Buzón - Usuarios',
      icon: Icons.menu_book_outlined,
      children: [
         MenuItem(id: 'buzon_entrada', title: 'Bandeja de Entrada', icon: Icons.inbox),
         MenuItem(id: 'buzon_archivos', title: 'Archivados', icon: Icons.archive_outlined),
      ],
    ),
  ];

  void _onMenuItemSelected(String id) {
    setState(() {
      _selectedId = id;
    });
    // Close drawer if open (mobile mode)
    if (Scaffold.of(context).hasDrawer && Scaffold.of(context).isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      // Drawer is only used on mobile (<= 800px)
      drawer: isDesktop
          ? null
          : Drawer(
              width: sidebarWidth,
              child: HomeSidebar(
                menuItems: _menuItems,
                selectedId: _selectedId,
                onItemSelected: (id) {
                  setState(() => _selectedId = id);
                  Navigator.pop(context); // Close drawer
                },
                backgroundColor: sidebarColor,
                activeItemColor: activeItemColor,
              ),
            ),
      body: Column(
        children: [
          // Top Bar
          _buildTopBar(isDesktop),
          // Main Body (Sidebar + Content)
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sidebar - Only show on Desktop if expanded
                if (isDesktop && _isSidebarExpanded)
                  SizedBox(
                    width: sidebarWidth,
                    child: HomeSidebar(
                      menuItems: _menuItems,
                      selectedId: _selectedId,
                      onItemSelected: (id) => setState(() => _selectedId = id),
                      backgroundColor: sidebarColor,
                      activeItemColor: activeItemColor,
                    ),
                  ),
                
                // Content Area
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                        // borderRadius: BorderRadius.circular(8), // Optional
                      ),
                      // Placeholder for content
                      child: Center(child: Text('Contenido: $_selectedId')),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(bool isDesktop) {
    return Container(
      height: topBarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: topBarColor,
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          // Menu Toggle & Logo
          // Builder needed to access Scaffold context for opening drawer
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                if (isDesktop) {
                  setState(() {
                    _isSidebarExpanded = !_isSidebarExpanded;
                  });
                } else {
                  Scaffold.of(context).openDrawer();
                }
              },
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(width: 8),
          // Logo Placeholder
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.teal, // Logo color
                ),
                child: const Icon(Icons.local_shipping, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 8),
              const Text(
                'LOGISPORT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF1A237E), // Dark Blue
                ),
              ),
            ],
          ),
          
          const SizedBox(width: 16),
          
          // Right Side Actions
          // Use Expanded to take up remaining space.
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Company Dropdown - Flexible to allow shrinking
                Flexible(
                  child: _buildCompanyDropdown(),
                ),
                const SizedBox(width: 16),
                
                // Icons - Fixed size (unwrapped)
                IconButton(
                  icon: const Icon(Icons.dark_mode_outlined),
                  onPressed: () {},
                  color: Colors.grey[600],
                  tooltip: 'Tema',
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                  color: Colors.grey[600],
                  tooltip: 'Notificaciones',
                ),
                const SizedBox(width: 8),
                
                // User Profile - Flexible just in case
                Flexible(child: _buildUserProfile()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Label - Keep it visible if possible, or allow shrinking slightly
          const Text(
            'Empresa: ',
            style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          // Dropdown - Needs to be Flexible/Expanded to handle text overflow
          Flexible(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: 'SALICA DEL ECUADOR S.A.',
                isDense: true,
                isExpanded: true, // Force expansion to fill Flexible space and allow ellipsis
                style: const TextStyle(color: Colors.black87, fontSize: 13),
                items: ['SALICA DEL ECUADOR S.A.', 'OTRA EMPRESA S.A.']
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                onChanged: (_) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey[300],
          child: const Icon(Icons.person, size: 20, color: Colors.grey),
        ),
        const SizedBox(width: 8),
        const Text(
          'cluna',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}

class MenuItem {
  final String id;
  final String title;
  final IconData icon;
  final List<MenuItem>? children;

  MenuItem({
    required this.id,
    required this.title,
    required this.icon,
    this.children,
  });
}

class HomeSidebar extends StatelessWidget {
  final List<MenuItem> menuItems;
  final String selectedId;
  final Function(String) onItemSelected;
  final Color backgroundColor;
  final Color activeItemColor;

  const HomeSidebar({
    super.key,
    required this.menuItems,
    required this.selectedId,
    required this.onItemSelected,
    required this.backgroundColor,
    required this.activeItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar...',
                prefixIcon: const Icon(Icons.search, size: 20),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
          const SizedBox(height: 16),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: menuItems.map((item) => _buildMenuItem(context, item)).toList(),
            ),
          ),
          
          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Copyright © 2025', style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                Text('Grupo Albacora', style: TextStyle(color: Colors.grey[500], fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, MenuItem item) {
    if (item.children != null && item.children!.isNotEmpty) {
      return _buildExpandableMenuItem(context, item);
    } else {
      return _buildSingleMenuItem(item);
    }
  }

  Widget _buildSingleMenuItem(MenuItem item, {bool isSubItem = false}) {
    final isSelected = selectedId == item.id;
    return InkWell(
      onTap: () => onItemSelected(item.id),
      child: Container(
        color: isSelected ? activeItemColor : null,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            if (isSubItem) const SizedBox(width: 12),
            Icon(
              item.icon,
              size: isSubItem ? 18 : 22,
              color: isSelected ? Colors.black87 : Colors.grey[700],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? Colors.black87 : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: isSubItem ? 13 : 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableMenuItem(BuildContext context, MenuItem item) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey(item.id),
        leading: Icon(item.icon, size: 22, color: Colors.grey[700]),
        title: Text(
          item.title,
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        childrenPadding: EdgeInsets.zero,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        children: item.children!.map((child) => _buildSingleMenuItem(child, isSubItem: true)).toList(),
      ),
    );
  }
}
