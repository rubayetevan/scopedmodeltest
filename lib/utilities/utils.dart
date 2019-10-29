
import 'package:logger/logger.dart';

class Utils{
  static var isConnectedToInternet = true;


}

final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: false,
      printTime: false,
    )
);