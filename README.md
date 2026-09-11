# AquaWorld API

Ожидаемые endpoints:

GET /api/server/status
{
  "online": true,
  "onlinePlayers": 42,
  "maxPlayers": 100,
  "ip": "play.example",
  "port": 19132
}

GET /api/shop
GET /api/rules
GET /api/admins

Для админ-панели рекомендуется:
POST/PUT/DELETE /api/admin/shop/*
POST/PUT/DELETE /api/admin/rules
POST/PUT/DELETE /api/admin/admins
PUT /api/admin/server

Обязательно добавить серверную авторизацию администратора, HTTPS и проверку прав на каждом изменяющем запросе.
