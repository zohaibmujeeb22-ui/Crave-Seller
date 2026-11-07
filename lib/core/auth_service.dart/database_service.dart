import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/app_constants.dart';
import '../../models/restaurant_model.dart';

/// Service class encapsulating Supabase Database CRUD actions.
class DatabaseService {
  SupabaseClient get _supabase => Supabase.instance.client;

  /// Check if the authenticated Firebase user already owns a restaurant
  Future<RestaurantModel?> getRestaurantByOwnerId(String ownerId) async {
    final response = await _supabase
        .from(AppConstants.restaurantsTable)
        .select()
        .eq('owner_id', ownerId)
        .maybeSingle();

    if (response == null) return null;
    return RestaurantModel.fromMap(response);
  }

  /// Inserts a new restaurant record into the Supabase 'restaurants' table
  Future<void> createRestaurant(RestaurantModel restaurant) async {
    await _supabase
        .from(AppConstants.restaurantsTable)
        .insert(restaurant.toMap());
  }
}
