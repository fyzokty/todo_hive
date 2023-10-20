import 'package:flutter/material.dart';
import 'package:todo/screen/create_task_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        elevation: 1,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CreateTaskScreen()));
        },
        icon: const Icon(Icons.add),
        label: const Text('Ekle'),
      ),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Tümü'),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: 1,
      onDestinationSelected: (value) {},
      children: const [
        DrawerHeader(child: Text('DENEME')),
        NavigationDrawerDestination(
          icon: Icon(Icons.menu),
          label: Text('Tümü'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.star_border_rounded),
          selectedIcon: Icon(Icons.star_rounded),
          label: Text('Favoriler'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.check_circle_outline_rounded),
          selectedIcon: Icon(Icons.check_circle_rounded),
          label: Text('Tamamlandı'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.delete_outline_rounded),
          selectedIcon: Icon(Icons.delete_rounded),
          label: Text('Çöp Kutusu'),
        ),
      ],
    );
  }
}
