import 'package:json_annotation/json_annotation.dart'; 
  
part 'home_media_model.g.dart';


@JsonSerializable()
  class HomeMediaModel extends Object {

  @JsonKey(name: 'title')
  Title? title;

  @JsonKey(name: 'content')
  Content? content;

  @JsonKey(name: 'image_url')
  Image_url? imageUrl;

  HomeMediaModel(this.title,this.content,this.imageUrl,);

  factory HomeMediaModel.fromJson(Map<String, dynamic> srcJson) => _$HomeMediaModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HomeMediaModelToJson(this);

}

  
@JsonSerializable()
  class Title extends Object {

  @JsonKey(name: 'S')
  String? s;

  Title(this.s,);

  factory Title.fromJson(Map<String, dynamic> srcJson) => _$TitleFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TitleToJson(this);

}

  
@JsonSerializable()
  class Content extends Object {

  @JsonKey(name: 'S')
  String? s;

  Content(this.s,);

  factory Content.fromJson(Map<String, dynamic> srcJson) => _$ContentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ContentToJson(this);

}

  
@JsonSerializable()
  class Image_url extends Object {

  @JsonKey(name: 'S')
  String? s;

  Image_url(this.s,);

  factory Image_url.fromJson(Map<String, dynamic> srcJson) => _$Image_urlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlToJson(this);

}

  
