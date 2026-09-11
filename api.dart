import 'dart:convert';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'models.dart';

class AquaApi {
  static const demoStatus = ServerStatus(
    online: true, onlinePlayers: 12, maxPlayers: 100,
    ip: 'aquaworld.example', port: 19132,
  );

  static final demoDonates = [
    DonateItem(id:'1', title:'Ракушка', description:'Стартовая привилегия AquaWorld', category:'Привилегии', price:49),
    DonateItem(id:'2', title:'Рыбка', description:'Расширенные возможности игрока', category:'Привилегии', price:99),
    DonateItem(id:'3', title:'Дельфин', description:'Премиальная привилегия', category:'Привилегии', price:199),
    DonateItem(id:'4', title:'Aqua Coins', description:'Валюта донат-магазина', category:'Валюта', price:100),
  ];

  static final demoAdmins = [
    Admin(nickname:'SneppI', role:'Создатель', description:'Создатель AquaWorld'),
    Admin(nickname:'arenaly1632', role:'Создатель', description:'Создатель AquaWorld'),
  ];

  static Future<ServerStatus> status() async {
    if (AppConfig.demoMode) return demoStatus;
    final r = await http.get(Uri.parse('${AppConfig.apiBaseUrl}/api/server/status'));
    return ServerStatus.fromJson(jsonDecode(r.body));
  }

  static Future<List<DonateItem>> donates() async {
    if (AppConfig.demoMode) return demoDonates;
    final r = await http.get(Uri.parse('${AppConfig.apiBaseUrl}/api/shop'));
    return (jsonDecode(r.body) as List).map((x) => DonateItem.fromJson(x)).toList();
  }

  static Future<List<Admin>> admins() async {
    if (AppConfig.demoMode) return demoAdmins;
    final r = await http.get(Uri.parse('${AppConfig.apiBaseUrl}/api/admins'));
    return (jsonDecode(r.body) as List).map((x) => Admin.fromJson(x)).toList();
  }

  static Future<String> rules() async {
    if (AppConfig.demoMode) {
      return 'Играйте честно и уважайте других игроков.\n\nЗапрещены читы, вредоносные действия и использование уязвимостей сервера.\n\nАдминистрация оставляет за собой право применять наказания согласно правилам AquaWorld.';
    }
    final r = await http.get(Uri.parse('${AppConfig.apiBaseUrl}/api/rules'));
    return jsonDecode(r.body)['text'] ?? '';
  }
}
