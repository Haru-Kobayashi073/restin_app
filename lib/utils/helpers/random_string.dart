import 'package:uuid/uuid.dart';

String returnUuidV4() {
  const uuid = Uuid();
  return uuid.v4();
}

String returnJpgFileName() => '${returnUuidV4()}.jpg';
