import 'package:brayan_fake_store_api/src/domain/entities/rating_entity.dart';

/// Modelo de datos para [RatingEntity] — agrega serialización JSON.
class RatingModel extends RatingEntity {
  const RatingModel({required super.rate, required super.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    rate: (json['rate'] as num).toDouble(),
    count: json['count'] as int,
  );

  Map<String, dynamic> toJson() => {'rate': rate, 'count': count};
}
