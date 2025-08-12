import 'package:e_commerce/views/MyDetails/cubit/my_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyDetailsCubit extends Cubit<MyDetailsState> {
  MyDetailsCubit()
    : super(
        MyDetailsState(
          fullname: TextEditingController(),
          email: TextEditingController(),
          dataOfbirth: TextEditingController(),
          gender: TextEditingController(),
          phoneNumber: TextEditingController(),
          isLoading: false,
        ),
      );

  void onFullNameChanged(String value) {
    emit(state.copyWith());
  }

  void onEmailChanged(String value) {
    emit(state.copyWith());
  }

  void ondateOfbirthChanged(String value) {
    emit(state.copyWith());
  }

  void onGenderChanged(String value) {
    emit(state.copyWith());
  }

  void onPhoneNumberChanged(String value) {
    emit(state.copyWith());
  }

  Future<void> myDetails(BuildContext context) async {
    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    state.fullname.dispose();
    state.email.dispose();
    state.dataOfbirth.dispose();
    state.gender.dispose();
    state.phoneNumber.dispose();
    return super.close();
  }
}
