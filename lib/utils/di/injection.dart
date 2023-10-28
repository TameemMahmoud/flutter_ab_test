import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../network/connection/network_info.dart';
import '../network/dio/dio.dart';
import '../network/dio/network_call.dart';


final instance = GetIt.instance;

Future<void> initAppInjection() async{

  instance.registerLazySingleton<NetworkInfoImp>(() => NetworkInfoImp(
      connectionChecker: InternetConnectionChecker()));



  instance.registerLazySingleton<DioHelper>(() => DioHelper());

  instance.registerLazySingleton<NetworkCall>(() => NetworkCall(dioHelper: instance<DioHelper>()));
}
