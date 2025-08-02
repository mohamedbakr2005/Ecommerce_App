import 'package:e_commerce/views/Address/models/address_model.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Address> addresses;
  final Address? selectedAddress;

  AddressLoaded({required this.addresses, this.selectedAddress});

  AddressLoaded copyWith({List<Address>? addresses, Address? selectedAddress}) {
    return AddressLoaded(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
    );
  }
}

class AddressError extends AddressState {
  final String message;

  AddressError(this.message);
}

class AddressAddedSuccess extends AddressState {
  final Address newAddress;

  AddressAddedSuccess(this.newAddress);
}

class AddressUpdatedSuccess extends AddressState {
  final Address updatedAddress;

  AddressUpdatedSuccess(this.updatedAddress);
}

class AddressDeletedSuccess extends AddressState {
  final String deletedAddressId;

  AddressDeletedSuccess(this.deletedAddressId);
}
