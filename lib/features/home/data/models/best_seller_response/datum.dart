// class Datum {
//   int? id;
//   int? categoryId;
//   String? name;
//   dynamic metaKeywords;
//   dynamic metaDescription;
//   dynamic seoHeader;
//   dynamic seoFooter;
//   String? slug;
//   String? description;
//   String? author;
//   int? totalPages;
//   String? code;
//   String? image;
//   String? price;
//   int? status;
//   int? stock;
//   int? discount;
//   int? bestSeller;
//   int? special;
//   dynamic deletedAt;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Datum({
//     this.id,
//     this.categoryId,
//     this.name,
//     this.metaKeywords,
//     this.metaDescription,
//     this.seoHeader,
//     this.seoFooter,
//     this.slug,
//     this.description,
//     this.author,
//     this.totalPages,
//     this.code,
//     this.image,
//     this.price,
//     this.status,
//     this.stock,
//     this.discount,
//     this.bestSeller,
//     this.special,
//     this.deletedAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json['id'] as int?,
//     categoryId: json['category_id'] as int?,
//     name: json['name'] as String?,
//     metaKeywords: json['meta_keywords'] as dynamic,
//     metaDescription: json['meta_description'] as dynamic,
//     seoHeader: json['seo_header'] as dynamic,
//     seoFooter: json['seo_footer'] as dynamic,
//     slug: json['slug'] as String?,
//     description: json['description'] as String?,
//     author: json['author'] as String?,
//     totalPages: json['total_pages'] as int?,
//     code: json['code'] as String?,
//     image: json['image'] as String?,
//     price: json['price'] as String?,
//     status: json['status'] as int?,
//     stock: json['stock'] as int?,
//     discount: json['discount'] as int?,
//     bestSeller: json['best_seller'] as int?,
//     special: json['special'] as int?,
//     deletedAt: json['deleted_at'] as dynamic,
//     createdAt: json['created_at'] == null
//         ? null
//         : DateTime.parse(json['created_at'] as String),
//     updatedAt: json['updated_at'] == null
//         ? null
//         : DateTime.parse(json['updated_at'] as String),
//   );

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'category_id': categoryId,
//     'name': name,
//     'meta_keywords': metaKeywords,
//     'meta_description': metaDescription,
//     'seo_header': seoHeader,
//     'seo_footer': seoFooter,
//     'slug': slug,
//     'description': description,
//     'author': author,
//     'total_pages': totalPages,
//     'code': code,
//     'image': image,
//     'price': price,
//     'status': status,
//     'stock': stock,
//     'discount': discount,
//     'best_seller': bestSeller,
//     'special': special,
//     'deleted_at': deletedAt,
//     'created_at': createdAt?.toIso8601String(),
//     'updated_at': updatedAt?.toIso8601String(),
//   };
// }
