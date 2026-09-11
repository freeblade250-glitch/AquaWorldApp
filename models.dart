class ServerStatus {
  final bool online;
  final int onlinePlayers;
  final int maxPlayers;
  final String ip;
  final int port;

  ServerStatus({
    required this.online,
    required this.onlinePlayers,
    required this.maxPlayers,
    required this.ip,
    required this.port,
  });

  factory ServerStatus.fromJson(Map<String, dynamic> j) => ServerStatus(
    online: j['online'] == true,
    onlinePlayers: j['onlinePlayers'] ?? 0,
    maxPlayers: j['maxPlayers'] ?? 0,
    ip: j['ip'] ?? '',
    port: j['port'] ?? 19132,
  );
}

class DonateItem {
  final String id, title, description, category;
  final double price;
  final int? discount;

  DonateItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    this.discount,
  });

  factory DonateItem.fromJson(Map<String, dynamic> j) => DonateItem(
    id: '${j['id']}',
    title: j['title'] ?? '',
    description: j['description'] ?? '',
    category: j['category'] ?? 'Другое',
    price: (j['price'] ?? 0).toDouble(),
    discount: j['discount'],
  );
}

class Admin {
  final String nickname, role, description;
  Admin({required this.nickname, required this.role, required this.description});
  factory Admin.fromJson(Map<String, dynamic> j) => Admin(
    nickname: j['nickname'] ?? '',
    role: j['role'] ?? '',
    description: j['description'] ?? '',
  );
}
