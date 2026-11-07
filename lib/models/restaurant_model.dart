class RestaurantModel {
  final String? id;
  final String ownerId;
  final String name;
  final String address;
  final String phone;
  final String currency;
  final DateTime? createdAt;

  RestaurantModel({
    this.id,
    required this.ownerId,
    required this.name,
    required this.address,
    required this.phone,
    required this.currency,
    this.createdAt,
  });

  /// Factory constructor to parse Supabase JSON response
  factory RestaurantModel.fromMap(Map<String, dynamic> map) {
    return RestaurantModel(
      id: map['id']?.toString(),
      ownerId: map['owner_id'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      currency: map['currency'] as String,
      createdAt: map['created_at'] != null 
          ? DateTime.parse(map['created_at']) 
          : null,
    );
  }

  /// Converts the model to JSON for Supabase table insertion
  Map<String, dynamic> toMap() {
    return {
      'owner_id': ownerId,
      'name': name,
      'address': address,
      'phone': phone,
      'currency': currency,
    };
  }
}