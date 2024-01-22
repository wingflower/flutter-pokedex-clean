import 'dart:async';

import 'package:pokedex_clean/core/result.dart';


abstract interface class UserAccountRepository<K, V> {
  Future<Result<V>> getData(K key);
  Future<Result<void>> deleteData(K key);
  Future<Result<void>> saveData(K key, V value);
}