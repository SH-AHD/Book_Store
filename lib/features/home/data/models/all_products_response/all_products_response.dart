import 'package:bookia/features/home/data/models/all_products_response/data.dart';

class AllProductsResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  AllProductsResponse({this.data, this.message, this.error, this.status});

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) {
    return AllProductsResponse(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "error": error,
    "status": status,
  };
}
