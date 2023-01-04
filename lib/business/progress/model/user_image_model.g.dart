// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImageModel _$UserImageModelFromJson(Map<String, dynamic> json) =>
    UserImageModel(
      json['id'] as String?,
      json['imageName'] as String?,
      json['imagePath'] as String?,
    );

Map<String, dynamic> _$UserImageModelToJson(UserImageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageName': instance.imageName,
      'imagePath': instance.imagePath,
    };
