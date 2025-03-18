import 'package:hive/hive.dart';

/// Сервис для работы с локальной базой данных Hive
/// Параметризованный класс для разных типов данных
class HiveService<T> {
  final Map<String, Box<T>> _boxes = {}; // Хранение нескольких коробок

  /// Инициализация коробки для типа T с уникальным именем
  Future<void> init(String boxName) async {
    if (!_boxes.containsKey(boxName)) {
      // Если коробка еще не была инициализирована, открываем её
      final box = await Hive.openBox<T>(boxName);
      _boxes[boxName] = box;
    }
  }

  /// Получение коробки по имени
  Box<T>? _getBox(String boxName) {
    return _boxes[boxName];
  }

  /// Добавление элемента в конкретную коробку
  Future<void> addItem(String boxName, T item) async {
    final box = _getBox(boxName);
    if (box != null) {
      await box.add(item);
    }
  }

  /// Обновление элемента в коробке по индексу
  Future<void> updateItem(String boxName, int index, T item) async {
    final box = _getBox(boxName);
    if (box != null) {
      await box.putAt(index, item);
    }
  }

  /// Удаление элемента в коробке по индексу
  Future<void> deleteItem(String boxName, int index) async {
    final box = _getBox(boxName);
    if (box != null) {
      await box.deleteAt(index);
    }
  }

  /// Получение всех элементов из коробки
  List<T> getAllItems(String boxName) {
    final box = _getBox(boxName);
    return box?.values.toList() ?? [];
  }
}
