import 'dart:developer' as dev;
import 'package:ecommerce_app/core/data_source/category_remote/category_remote_data_source.dart';
import 'package:ecommerce_app/core/data_source/category_remote/category_remote_data_source_impl.dart';
import 'package:ecommerce_app/core/services/api/api_service.dart';
import 'package:ecommerce_app/core/services/storage_service/storage_service.dart';
import 'package:ecommerce_app/core/services/utility_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:ecommerce_app/core/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:ecommerce_app/core/data_source/auth_remote_data_source/auth_remote_data_source_impl.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  dev.log('🏗️ Setting up dependency injection...', name: 'LOCATOR');

  //---------------- SERVICES ----------------//
  locator.registerLazySingleton<HiveInterface>(() => Hive);

  locator.registerLazySingleton<ApiService>(() => ApiService());

  locator.registerLazySingleton<StorageService>(() => StorageService());
  locator.registerLazySingleton<UtilityService>(() => UtilityService());

  //---------------- DATA SOURCES ----------------//
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(locator<ApiService>()),
  );
  locator.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(locator<ApiService>()),
  );

  //---------------- INIT ----------------//

  await locator<StorageService>().init();
}
