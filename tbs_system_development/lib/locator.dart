import 'package:tbssystemdevelopment/services/api_manager.dart';
import 'package:tbssystemdevelopment/services/local_storage.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton(() => ApiManager());
  locator.registerLazySingleton(() => LocalStorage());
}
