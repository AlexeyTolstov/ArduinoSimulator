import 'package:logger/logger.dart';

final Logger logger = Logger(
  level: Level.all,
  printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 8,
      lineLength: 80,
      colors: true,
      printEmojis: false,
      // dateTimeFormat: DateTimeFormat.onlyTime,
  ),
);