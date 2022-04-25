// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getproduct_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetItem _$ResponseGetItemFromJson(Map<String, dynamic> json) =>
    ResponseGetItem(
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetItemToJson(ResponseGetItem instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data.map((e) => e.toJson()).toList(),
    };
