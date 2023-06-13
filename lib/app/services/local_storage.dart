import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LocalStorage {
  LocalStorage._internal();

  static final LocalStorage _singleton = LocalStorage._internal();
  static LocalStorage get = _singleton;

  final GetStorage _storage = GetStorage();

  Future write(String key, dynamic value) async {
    await _storage.write(key, jsonEncode(value));
  }

  dynamic read<S>(String key, {S Function(Map)? construct}) {
    String? value = _storage.read(key);
    if (value == null) return;
    if (construct == null) return jsonDecode(value);
    Map<String, dynamic> json = jsonDecode(value);
    return construct(json);
  }

  // Future remove(String key) async {
  //   await _storage.read(key);
  // }

  Future remove(String key) async {
    await _storage.remove(key);
  }
}
