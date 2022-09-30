import 'package:simple_logger/simple_logger.dart';


final SimpleLogger log = SimpleLogger()
  ..mode = LoggerMode.print
  ..setLevel(
    Level.FINEST,
    includeCallerInfo: true,
  );



