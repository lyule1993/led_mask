// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentityModel _$IdentityModelFromJson(Map<String, dynamic> json) =>
    IdentityModel(
      json['userId'] as String?,
      json['providerName'] as String?,
      json['providerType'] as String?,
      json['primary'] as bool?,
      json['dateCreated'] as int?,
    );

Map<String, dynamic> _$IdentityModelToJson(IdentityModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'providerName': instance.providerName,
      'providerType': instance.providerType,
      'primary': instance.primary,
      'dateCreated': instance.dateCreated,
    };
