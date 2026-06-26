class PlaceOrderParams {
  final String name;
  final int governorateId;
  final String phone;
  final String address;
  final String email;

  PlaceOrderParams({
    required this.name,
    required this.governorateId,
    required this.phone,
    required this.address,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'governorate_id': governorateId,
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
    };
  }
}
