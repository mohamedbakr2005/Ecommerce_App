class Address {
  final String id;
  final String nickname;
  final String fullAddress;
  final bool isDefault;
  final bool isSelected;

  Address({
    required this.id,
    required this.nickname,
    required this.fullAddress,
    this.isDefault = false,
    this.isSelected = false,
  });

  Address copyWith({
    String? id,
    String? nickname,
    String? fullAddress,
    bool? isDefault,
    bool? isSelected,
  }) {
    return Address(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

class AddressFormData {
  final String nickname;
  final String fullAddress;
  final bool isDefault;

  AddressFormData({
    required this.nickname,
    required this.fullAddress,
    this.isDefault = false,
  });
}
