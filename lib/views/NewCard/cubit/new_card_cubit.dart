import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'new_card_state.dart';

class NewCardCubit extends Cubit<NewCardState> {
  NewCardCubit()
    : super(
        NewCardState(
          isLoading: false,
          cardNumberController: TextEditingController(),
          expiryDateController: TextEditingController(),
          securityCodeController: TextEditingController(),
        ),
      );

  void onCardNumberChanged(String value) {
    emit(
      state.copyWith(cardNumberController: TextEditingController(text: value)),
    );
  }

  void onExpiryDateChanged(String value) {
    emit(
      state.copyWith(expiryDateController: TextEditingController(text: value)),
    );
  }

  void onSecurityCodeChanged(String value) {
    emit(
      state.copyWith(
        securityCodeController: TextEditingController(text: value),
      ),
    );
  }

  void addCard(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(isLoading: false));
    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    state.cardNumberController.dispose();
    state.expiryDateController.dispose();
    state.securityCodeController.dispose();
    return super.close();
  }
}
