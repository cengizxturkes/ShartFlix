import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

var logger = Logger();
var dioLogger = PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: true,
  error: true,
);
