import 'package:flutter/material.dart';

class VerificationCodeState {
  final bool isLoading;
  final List<TextEditingController> codeControllers;
  final List<FocusNode> focusNodes;
  final String email;

  VerificationCodeState({
    required this.isLoading,
    required this.codeControllers,
    required this.focusNodes,
    required this.email,
  });

  String get code =>
      codeControllers.map((controller) => controller.text).join();

  bool get isCodeComplete => code.length == 6;

  VerificationCodeState copyWith({
    bool? isLoading,
    List<TextEditingController>? codeControllers,
    List<FocusNode>? focusNodes,
    String? email,
  }) {
    return VerificationCodeState(
      isLoading: isLoading ?? this.isLoading,
      codeControllers: codeControllers ?? this.codeControllers,
      focusNodes: focusNodes ?? this.focusNodes,
      email: email ?? this.email,
    );
  }
}
