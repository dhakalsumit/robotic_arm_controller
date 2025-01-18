import 'package:hive_flutter/hive_flutter.dart';

class IPStorageService {
  final Box _box = Hive.box('ipStorage');

  String getIp() {
    
    return _box.get('ip', defaultValue: '192.168.4.1');
  }

  void setIp(String ip) {
    _box.put('ip', ip);
  }
}