// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'product_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReview _$ProductReviewFromJson(Map<String, dynamic> json) {
  dynamic imageUrl = json['reviewer_avatar_urls']["28"];
  return ProductReview(
      id: json['id'] as int,
      date_created: json['date_created'],
      product_id: json["product_id"],
      product_name: json["product_name"],
      reviewer: json['reviewer'],
      review: json['review'],
      rating: json["rating"],
      verified: json["verified"],
      reviewer_avatar_urls: imageUrl!=null ? imageUrl : "");
}

Map<String, dynamic> _$ProductReviewToJson(ProductReview instance) =>
    <String, dynamic>{
      'reviewer': instance.reviewer,
      'review': instance.review,
    };
