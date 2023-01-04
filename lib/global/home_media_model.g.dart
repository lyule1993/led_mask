// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_media_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeMediaModel _$HomeMediaModelFromJson(Map<String, dynamic> json) =>
    HomeMediaModel(
      json['title'] == null
          ? null
          : Title.fromJson(json['title'] as Map<String, dynamic>),
      json['content'] == null
          ? null
          : Content.fromJson(json['content'] as Map<String, dynamic>),
      json['image_url'] == null
          ? null
          : Image_url.fromJson(json['image_url'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeMediaModelToJson(HomeMediaModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'image_url': instance.imageUrl,
    };

Title _$TitleFromJson(Map<String, dynamic> json) => Title(
      json['S'] as String?,
    );

Map<String, dynamic> _$TitleToJson(Title instance) => <String, dynamic>{
      'S': instance.s,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      json['S'] as String?,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'S': instance.s,
    };

Image_url _$Image_urlFromJson(Map<String, dynamic> json) => Image_url(
      json['S'] as String?,
    );

Map<String, dynamic> _$Image_urlToJson(Image_url instance) => <String, dynamic>{
      'S': instance.s,
    };
