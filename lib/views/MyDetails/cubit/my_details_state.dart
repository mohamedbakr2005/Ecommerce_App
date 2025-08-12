import 'package:flutter/widgets.dart';

class MyDetailsState {
  final TextEditingController fullname;
  final TextEditingController email;
  final TextEditingController dataOfbirth;
  final TextEditingController gender;
  final TextEditingController phoneNumber;
  final bool isLoading;

  MyDetailsState({
    required this.fullname,
    required this.email,
    required this.dataOfbirth,
    required this.gender,
    required this.phoneNumber,
    required this.isLoading,
  });

  bool get isFormValid =>
      fullname.text.isNotEmpty &&
      email.text.isNotEmpty &&
      dataOfbirth.text.isNotEmpty &&
      gender.text.isNotEmpty &&
      phoneNumber.text.isNotEmpty;

  MyDetailsState copyWith({
    TextEditingController? fullname,
    TextEditingController? email,
    TextEditingController? dataOfbirth,
    TextEditingController? gender,
    TextEditingController? phoneNumber,
    bool? isLoading,
  }) {
    return MyDetailsState(
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      dataOfbirth: dataOfbirth ?? this.dataOfbirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
