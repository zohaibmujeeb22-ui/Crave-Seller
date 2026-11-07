import 'package:crave_seller/core/auth_service.dart/database_service.dart';
import 'package:flutter/material.dart';
import 'package:crave_seller/models/restaurant_model.dart';

class OnboardingProvider extends ChangeNotifier {
  final DatabaseService _dbService;

  OnboardingProvider({required DatabaseService dbService})
      : _dbService = dbService;

  bool _isSubmitting = false;
  String? _errorMessage;

  bool get isSubmitting => _isSubmitting;
  String? get errorMessage => _errorMessage;

  /// Persist restaurant details to Supabase
  Future<bool> registerRestaurant({
    required String ownerId,
    required String name,
    required String address,
    required String phone,
    required String currency,
  }) async {
    _isSubmitting = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final restaurant = RestaurantModel(
        ownerId: ownerId,
        name: name.trim(),
        address: address.trim(),
        phone: phone.trim(),
        currency: currency,
      );

      // Direct write to the Supabase 'restaurants' table
      await _dbService.createRestaurant(restaurant);

      _isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to create profile: $e';
      _isSubmitting = false;
      notifyListeners();
      return false;
    }
  }
}