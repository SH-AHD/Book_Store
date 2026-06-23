class GovernorateData {
  int? id;
  String? governorateNameAr;
  String? governorateNameEn;

  GovernorateData({this.id, this.governorateNameAr, this.governorateNameEn});

  factory GovernorateData.fromJson(Map<String, dynamic> json) => GovernorateData(
    id: json['id'] as int?,
    governorateNameAr: json['governorate_name_ar'] as String?,
    governorateNameEn: json['governorate_name_en'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'governorate_name_ar': governorateNameAr,
    'governorate_name_en': governorateNameEn,
  };
}
