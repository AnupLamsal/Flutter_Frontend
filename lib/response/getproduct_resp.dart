import 'package:json_annotation/json_annotation.dart';

import '../models/item.dart';

part 'getproduct_resp.g.dart';

@JsonSerializable(explicitToJson: true)
class ResponseGetItem {
  final bool success;

  final List<Item> data;

  ResponseGetItem({
    required this.success,
    required this.data,
  });

  factory ResponseGetItem.fromJson(Map<String, dynamic> obj) =>
      _$ResponseGetItemFromJson(obj);

  Map<String, dynamic> toJson() => _$ResponseGetItemToJson(this);
}
