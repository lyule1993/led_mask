import 'package:json_annotation/json_annotation.dart';

part 'user_image_model.g.dart';


@JsonSerializable()
class UserImageModel extends Object {

  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'imageName')
  String? imageName;

  @JsonKey(name: 'imagePath')
  String? imagePath;

  UserImageModel(this.id,this.imageName,this.imagePath,);

  factory UserImageModel.fromJson(Map<String, dynamic> srcJson) => _$UserImageModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserImageModelToJson(this);

}

  
