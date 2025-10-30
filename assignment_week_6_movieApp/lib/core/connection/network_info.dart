import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetService {
  Future<bool> get isConnected;
}

class InternetServiceImpl implements InternetService {
  final InternetConnectionChecker internetConnectionChecker;
  InternetServiceImpl({required this.internetConnectionChecker});

  @override
  Future<bool> get isConnected {
    return internetConnectionChecker.hasConnection;
  }
}
