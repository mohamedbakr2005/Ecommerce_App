part of 'new_card_cubit.dart';

class NewCardState {
  final bool isLoading;
  final TextEditingController cardNumberController;
  final TextEditingController expiryDateController;
  final TextEditingController securityCodeController;

  NewCardState({
    required this.isLoading,
    required this.cardNumberController,
    required this.expiryDateController,
    required this.securityCodeController,
  });
  bool get isFormValid =>
      cardNumberController.text.isNotEmpty &&
      expiryDateController.text.isNotEmpty &&
      securityCodeController.text.isNotEmpty;

  NewCardState copyWith({
    bool? isLoading,
    TextEditingController? cardNumberController,
    TextEditingController? expiryDateController,
    TextEditingController? securityCodeController,
  }) {
    return NewCardState(
      isLoading: isLoading ?? this.isLoading,
      cardNumberController: cardNumberController ?? this.cardNumberController,
      expiryDateController: expiryDateController ?? this.expiryDateController,
      securityCodeController:
          securityCodeController ?? this.securityCodeController,
    );
  }
}
