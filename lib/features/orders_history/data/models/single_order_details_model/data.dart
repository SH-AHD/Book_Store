import 'order_product.dart';

class Data {
  int? id;
  String? orderCode;
  String? total;
  String? name;
  String? email;
  String? address;
  String? governorate;
  String? phone;
  dynamic tax;
  String? subTotal;
  String? orderDate;
  String? status;
  dynamic rejectDetails;
  dynamic notes;
  int? discount;
  List<OrderProduct>? orderProducts;

  Data({
    this.id,
    this.orderCode,
    this.total,
    this.name,
    this.email,
    this.address,
    this.governorate,
    this.phone,
    this.tax,
    this.subTotal,
    this.orderDate,
    this.status,
    this.rejectDetails,
    this.notes,
    this.discount,
    this.orderProducts,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json['id'] as int?,
    orderCode: json['order_code'] as String?,
    total: json['total'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    address: json['address'] as String?,
    governorate: json['governorate'] as String?,
    phone: json['phone'] as String?,
    tax: json['tax'] as dynamic,
    subTotal: json['sub_total'] as String?,
    orderDate: json['order_date'] as String?,
    status: json['status'] as String?,
    rejectDetails: json['reject_details'] as dynamic,
    notes: json['notes'] as dynamic,
    discount: json['discount'] as int?,
    orderProducts: (json['order_products'] as List<dynamic>?)
        ?.map((e) => OrderProduct.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'order_code': orderCode,
    'total': total,
    'name': name,
    'email': email,
    'address': address,
    'governorate': governorate,
    'phone': phone,
    'tax': tax,
    'sub_total': subTotal,
    'order_date': orderDate,
    'status': status,
    'reject_details': rejectDetails,
    'notes': notes,
    'discount': discount,
    'order_products': orderProducts?.map((e) => e.toJson()).toList(),
  };
}
