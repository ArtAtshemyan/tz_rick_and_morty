import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager {
  static const key = "imageCacheKey";

  static final instance = CustomCacheManager._();

  CustomCacheManager._()
      : super(
          Config(
            key,

            /// Срок хранения 7 дней
            stalePeriod: const Duration(days: 7),

            /// Максимум 100 объектов в кэше
            maxNrOfCacheObjects: 100,
          ),
        );
}
