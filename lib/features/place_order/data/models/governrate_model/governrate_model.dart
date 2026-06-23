import 'governorate_data.dart';

class GovernrateModel {
  List<GovernorateData>? data;
  String? message;
  List<dynamic>? error;
  int? status;

  GovernrateModel({this.data, this.message, this.error, this.status});

  factory GovernrateModel.fromJson(Map<String, dynamic> json) {
    return GovernrateModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => GovernorateData.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      error: json['error'] as List<dynamic>?,
      status: json['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => e.toJson()).toList(),
    'message': message,
    'error': error,
    'status': status,
  };
}
