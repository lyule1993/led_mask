import 'package:json_annotation/json_annotation.dart';
part 'invite_link_item_response.g.dart';


@JsonSerializable()
class InviteLinkItemResponse extends Object {

  @JsonKey(name: 'id')
  num? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'fullName')
  String? fullName;

  @JsonKey(name: 'remark')
  String? remark;

  @JsonKey(name: 'spread')
  num? spread;

  @JsonKey(name: 'commission')
  num? commission;

  @JsonKey(name: 'inviteURL')
  String? inviteURL;

  @JsonKey(name: 'unlock')
  bool? unlock;

  @JsonKey(name: 'unlockLevelCode')
  String? unlockLevelCode;

  @JsonKey(name: 'unlockLevelName')
  String? unlockLevelName;

  @JsonKey(name: 'color')
  String? color;

  @JsonKey(name: 'i18N_Desc')
  String? i18NDesc;

  @JsonKey(name: 'i18N_UnlockDesc')
  String? i18NUnlockDesc;

  InviteLinkItemResponse(
    this.id,
    this.name,
    this.fullName,
    this.remark,
    this.spread,
    this.commission,
    this.inviteURL,
    this.unlock,
    this.unlockLevelCode,
    this.unlockLevelName,
    this.color,
    this.i18NDesc,
    this.i18NUnlockDesc,
  );

  factory InviteLinkItemResponse.fromJson(Map<String, dynamic> srcJson) => _$InviteLinkItemResponseFromJson(srcJson);

  Map<String, dynamic> toJson() => _$InviteLinkItemResponseToJson(this);

}


