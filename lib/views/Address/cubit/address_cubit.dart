import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/views/Address/models/address_model.dart';
import 'package:e_commerce/views/Address/cubit/address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial()) {
    loadAddresses();
  }

  void loadAddresses() {
    emit(AddressLoading());

    // Simulate loading addresses
    Future.delayed(const Duration(milliseconds: 500), () {
      // Mock data - replace with actual API call
      final mockAddresses = [
        Address(
          id: '1',
          nickname: 'Home',
          fullAddress: '925 S Chugach St #APT 10, Alaska 99645',
          isDefault: true,
          isSelected: true,
        ),
        Address(
          id: '2',
          nickname: 'Office',
          fullAddress: '2438 6th Ave, Ketchikan, Alaska 99901',
          isDefault: false,
          isSelected: false,
        ),
        Address(
          id: '3',
          nickname: 'Apartment',
          fullAddress: '2551 Vista Dr #B301, Juneau, Alaska 99801',
          isDefault: false,
          isSelected: false,
        ),
        Address(
          id: '4',
          nickname: 'Parent\'s House',
          fullAddress: '4821 Ridge Top Cir, Anchorage, Alaska 99504',
          isDefault: false,
          isSelected: false,
        ),
      ];

      final selectedAddress = mockAddresses.firstWhere(
        (addr) => addr.isSelected,
      );

      emit(
        AddressLoaded(
          addresses: mockAddresses,
          selectedAddress: selectedAddress,
        ),
      );
    });
  }

  void selectAddress(String addressId) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;

      final updatedAddresses = currentState.addresses.map((address) {
        return address.copyWith(isSelected: address.id == addressId);
      }).toList();

      final selectedAddress = updatedAddresses.firstWhere(
        (addr) => addr.id == addressId,
      );

      emit(
        AddressLoaded(
          addresses: updatedAddresses,
          selectedAddress: selectedAddress,
        ),
      );
    }
  }

  void addAddress(AddressFormData formData) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;

      // Simulate API call
      Future.delayed(const Duration(milliseconds: 800), () {
        final newAddress = Address(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          nickname: formData.nickname,
          fullAddress: formData.fullAddress,
          isDefault: formData.isDefault,
          isSelected: false,
        );

        List<Address> updatedAddresses = List.from(currentState.addresses);

        // If new address is default, remove default from others
        if (formData.isDefault) {
          updatedAddresses = updatedAddresses.map((address) {
            return address.copyWith(isDefault: false);
          }).toList();
        }

        updatedAddresses.add(newAddress);

        emit(
          AddressLoaded(
            addresses: updatedAddresses,
            selectedAddress: currentState.selectedAddress,
          ),
        );

        // Emit success state
        emit(AddressAddedSuccess(newAddress));
      });
    }
  }

  void updateAddress(String addressId, AddressFormData formData) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;

      // Simulate API call
      Future.delayed(const Duration(milliseconds: 800), () {
        List<Address> updatedAddresses = currentState.addresses.map((address) {
          if (address.id == addressId) {
            return address.copyWith(
              nickname: formData.nickname,
              fullAddress: formData.fullAddress,
              isDefault: formData.isDefault,
            );
          }

          // If this address is being set as default, remove default from others
          if (formData.isDefault) {
            return address.copyWith(isDefault: false);
          }

          return address;
        }).toList();

        final updatedAddress = updatedAddresses.firstWhere(
          (addr) => addr.id == addressId,
        );

        emit(
          AddressLoaded(
            addresses: updatedAddresses,
            selectedAddress: currentState.selectedAddress,
          ),
        );

        // Emit success state
        emit(AddressUpdatedSuccess(updatedAddress));
      });
    }
  }

  void deleteAddress(String addressId) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;

      // Simulate API call
      Future.delayed(const Duration(milliseconds: 500), () {
        final updatedAddresses = currentState.addresses
            .where((address) => address.id != addressId)
            .toList();

        Address? newSelectedAddress = currentState.selectedAddress;

        // If deleted address was selected, select the first available address
        if (currentState.selectedAddress?.id == addressId &&
            updatedAddresses.isNotEmpty) {
          newSelectedAddress = updatedAddresses.first.copyWith(
            isSelected: true,
          );
          updatedAddresses[0] = newSelectedAddress!;
        }

        emit(
          AddressLoaded(
            addresses: updatedAddresses,
            selectedAddress: newSelectedAddress,
          ),
        );

        // Emit success state
        emit(AddressDeletedSuccess(addressId));
      });
    }
  }

  void setDefaultAddress(String addressId) {
    if (state is AddressLoaded) {
      final currentState = state as AddressLoaded;

      final updatedAddresses = currentState.addresses.map((address) {
        return address.copyWith(isDefault: address.id == addressId);
      }).toList();

      emit(
        AddressLoaded(
          addresses: updatedAddresses,
          selectedAddress: currentState.selectedAddress,
        ),
      );
    }
  }

  void resetState() {
    emit(AddressInitial());
  }
}
