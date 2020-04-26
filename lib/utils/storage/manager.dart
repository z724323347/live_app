part of flutter_complex_storage;

class StorageManager<T extends Object> {
  static SharedPreferences pref;

  /// 需要操作的key
  final String key;

  StorageManager(this.key);
  /// 由于是同步操作会导致阻塞,所以应尽量减少存储容量
  static Future<void> onInit() async {
    if(pref == null) {
      pref = await SharedPreferences.getInstance();
    }
  }

  /// 是否存在
  bool exist() {
    return pref?.containsKey(key) ?? false;
  }

  /// 获取值
  T get() {
    String value = pref?.getString(key);
    if(value != null) {
      try {
        return json.decode(value);
      } catch(err) {
        return json.decode('$value');
      }
    } else {
      return null;
    }
  }

  /// 设置值
  Future<bool> set(T value) async {
    return pref?.setString(key, json.encode(value));
  }

  /// 清空值
  Future<bool> remove() {
    return pref?.remove(key);
  }
}
