import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

GlobalKey<FormState> useFormStateKey() {
  return useState(GlobalKey<FormState>()).value;
}
