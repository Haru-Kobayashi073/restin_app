// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Flutter state hook that tracks value of a boolean.
/// useBoolean is an alias for useToggle.
ToggleState useToggle(bool initialValue) {
  final toggle = useState(initialValue);

  final setter = useCallback<void Function([bool? value])>(
    ([value]) {
      toggle.value = value ?? !toggle.value;
    },
    const [],
  );

  final getter = useCallback<bool Function()>(
    () {
      return toggle.value;
    },
    const [],
  );

  final state = useState(ToggleState(getter, setter));

  return state.value;
}

@immutable
class ToggleState {
  const ToggleState(this._getter, this._setter);

  final bool Function() _getter;
  final void Function([bool? value]) _setter;

  bool get value => _getter();

  void toggle([bool? value]) => _setter(value);
}
