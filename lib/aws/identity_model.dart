import 'package:json_annotation/json_annotation.dart'; 
  
part 'identity_model.g.dart';


@JsonSerializable()
  class IdentityModel extends Object {

  @JsonKey(name: 'userId')
  String? userId;

  @JsonKey(name: 'providerName')
  String? providerName;

  @JsonKey(name: 'providerType')
  String? providerType;

  @JsonKey(name: 'primary')
  bool? primary;

  @JsonKey(name: 'dateCreated')
  int? dateCreated;

  IdentityModel(this.userId,this.providerName,this.providerType,this.primary,this.dateCreated,);

  factory IdentityModel.fromJson(Map<String, dynamic> srcJson) => _$IdentityModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IdentityModelToJson(this);

}

  
