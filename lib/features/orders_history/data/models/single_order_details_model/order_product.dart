class OrderProduct {
  int? orderProductId;
  int? productId;
  String? productName;
  String? productImage;
  String? productPrice;
  int? productDiscount;
  double? productPriceAfterDiscount;
  int? orderProductQuantity;
  String? productTotal;

  OrderProduct({
    this.orderProductId,
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productDiscount,
    this.productPriceAfterDiscount,
    this.orderProductQuantity,
    this.productTotal,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    orderProductId: json['order_product_id'] as int?,
    productId: json['product_id'] as int?,
    productName: json['product_name'] as String?,
    productImage: json['product_image'] as String?,
    productPrice: json['product_price'] as String?,
    productDiscount: json['product_discount'] as int?,
    productPriceAfterDiscount: (json['product_price_after_discount'] as num?)
        ?.toDouble(),
    orderProductQuantity: json['order_product_quantity'] as int?,
    productTotal: json['product_total'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'order_product_id': orderProductId,
    'product_id': productId,
    'product_name': productName,
    'product_image': productImage,
    'product_price': productPrice,
    'product_discount': productDiscount,
    'product_price_after_discount': productPriceAfterDiscount,
    'order_product_quantity': orderProductQuantity,
    'product_total': productTotal,
  };
}
