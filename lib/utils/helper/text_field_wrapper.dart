import 'package:flutter/material.dart';

class TextFieldWrapper {
  TextEditingController _controller = TextEditingController();

  TextEditingController get controller => this._controller;

  set controller(TextEditingController value) => this._controller = value;

  TextFieldWrapper() {
    controller = TextEditingController();
  }

  factory TextFieldWrapper.withValue({
    TextEditingController? controller,
    String? errorText,
  }) {
    final wrap = TextFieldWrapper();
    wrap.controller = controller ?? TextEditingController();

    return wrap;
  }
}
