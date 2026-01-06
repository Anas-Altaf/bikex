import 'package:bikex/checkout/cubit/cubit.dart';
import 'package:bikex/checkout/models/models.dart';
import 'package:bikex/core/theme/app_theme.dart';
import 'package:bikex/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Bottom sheet for selecting or adding shipping address
class AddressBottomSheet extends StatefulWidget {
  const AddressBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<CheckoutCubit>(),
        child: const AddressBottomSheet(),
      ),
    );
  }

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  bool _showAddForm = false;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _streetController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: _showAddForm
              ? _buildAddForm(scrollController)
              : _buildAddressList(scrollController),
        );
      },
    );
  }

  Widget _buildAddressList(ScrollController scrollController) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Address',
                  style: TextStyle(
                    color: AppTheme.textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: AppTheme.textDescColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Address list
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: state.addresses.length,
                itemBuilder: (context, index) {
                  final address = state.addresses[index];
                  final isSelected = state.selectedAddress?.id == address.id;

                  return _AddressListTile(
                    address: address,
                    isSelected: isSelected,
                    onTap: () {
                      context.read<CheckoutCubit>().selectAddress(address);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),

            // Add new address button
            const SizedBox(height: 16),
            Center(
              child: PrimaryButton(
                title: 'Add New Address',
                onTap: () {
                  setState(() {
                    _showAddForm = true;
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddForm(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add New Address',
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _showAddForm = false;
                  });
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppTheme.textDescColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Form fields
          _buildTextField('Full Name', _nameController),
          _buildTextField('Phone Number', _phoneController),
          _buildTextField('Street Address', _streetController),
          _buildTextField('City', _cityController),
          Row(
            children: [
              Expanded(child: _buildTextField('State', _stateController)),
              const SizedBox(width: 12),
              Expanded(child: _buildTextField('Zip Code', _zipController)),
            ],
          ),

          const SizedBox(height: 24),

          // Save button
          Center(
            child: PrimaryButton(
              title: 'Save Address',
              onTap: _saveAddress,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: AppTheme.textColor),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppTheme.textDescColor),
          filled: true,
          fillColor: AppTheme.backgroundSurfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  void _saveAddress() {
    if (_nameController.text.isEmpty ||
        _streetController.text.isEmpty ||
        _cityController.text.isEmpty) {
      return;
    }

    final newAddress = ShippingAddress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      phone: _phoneController.text,
      street: _streetController.text,
      city: _cityController.text,
      state: _stateController.text,
      zipCode: _zipController.text,
    );

    context.read<CheckoutCubit>().addAddress(newAddress);
    Navigator.pop(context);
  }
}

/// Individual address list tile
class _AddressListTile extends StatelessWidget {
  const _AddressListTile({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  final ShippingAddress address;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.backgroundSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryUpColor
                : AppTheme.borderColor01,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppTheme.primaryUpColor
                      : AppTheme.textDescColor,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryUpColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // Address details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: const TextStyle(
                      color: AppTheme.textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address.fullAddress,
                    style: const TextStyle(
                      color: AppTheme.textDescColor,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            // Default badge
            if (address.isDefault)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryUpColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Default',
                  style: TextStyle(
                    color: AppTheme.primaryUpColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
