import 'package:flutter/material.dart';
import 'api.dart';
import 'models.dart';

void main() => runApp(const AquaWorldApp());

class AquaWorldApp extends StatelessWidget {
  const AquaWorldApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AquaWorld',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF07141F),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B8D9), brightness: Brightness.dark),
      useMaterial3: true,
    ),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tab = 0;

  final pages = const [HomeTab(), ShopTab(), RulesTab(), AdminTab()];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('AquaWorld', style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,
    ),
    body: pages[tab],
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (i) => setState(() => tab = i),
      destinations: const [
        NavigationDestination(icon: Icon(Icons.water), label: 'Главная'),
        NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Магазин'),
        NavigationDestination(icon: Icon(Icons.menu_book), label: 'Правила'),
        NavigationDestination(icon: Icon(Icons.groups), label: 'Администрация'),
      ],
    ),
  );
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<ServerStatus>(
    future: AquaApi.status(),
    builder: (context, s) {
      if (!s.hasData) return const Center(child: CircularProgressIndicator());
      final x = s.data!;
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(colors: [Color(0xFF006C8C), Color(0xFF0B2638)]),
            ),
            child: Column(
              children: [
                const Icon(Icons.water_drop, size: 70),
                const SizedBox(height: 12),
                const Text('AquaWorld', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(x.online ? '● Сервер онлайн' : '● Сервер офлайн',
                  style: TextStyle(fontSize: 17, color: x.online ? Colors.greenAccent : Colors.redAccent)),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Card(child: ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Онлайн'),
            subtitle: Text('${x.onlinePlayers} / ${x.maxPlayers} игроков'),
            trailing: SizedBox(width: 80, child: LinearProgressIndicator(value: x.maxPlayers == 0 ? 0 : x.onlinePlayers / x.maxPlayers)),
          )),
          Card(child: ListTile(
            leading: const Icon(Icons.dns),
            title: const Text('Адрес сервера'),
            subtitle: Text('${x.ip}:${x.port}'),
          )),
        ],
      );
    },
  );
}

class ShopTab extends StatelessWidget {
  const ShopTab({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<List<DonateItem>>(
    future: AquaApi.donates(),
    builder: (context, s) {
      if (!s.hasData) return const Center(child: CircularProgressIndicator());
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: s.data!.length,
        itemBuilder: (_, i) {
          final x = s.data![i];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(child: Text(x.title.characters.first)),
              title: Text(x.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${x.description}\n${x.category}'),
              isThreeLine: true,
              trailing: Text('${x.price.toStringAsFixed(0)} ₽', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      );
    },
  );
}

class RulesTab extends StatelessWidget {
  const RulesTab({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<String>(
    future: AquaApi.rules(),
    builder: (context, s) {
      if (!s.hasData) return const Center(child: CircularProgressIndicator());
      return ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Правила AquaWorld', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        const SizedBox(height: 18),
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Text(s.data!, style: const TextStyle(fontSize: 16, height: 1.5)))),
      ]);
    },
  );
}

class AdminTab extends StatelessWidget {
  const AdminTab({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<List<Admin>>(
    future: AquaApi.admins(),
    builder: (context, s) {
      if (!s.hasData) return const Center(child: CircularProgressIndicator());
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Администрация', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...s.data!.map((x) => Card(child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(x.nickname),
            subtitle: Text('${x.role}\n${x.description}'),
            isThreeLine: true,
          ))),
        ],
      );
    },
  );
}
