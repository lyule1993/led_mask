// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite_link_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InviteLinkItemResponse _$InviteLinkItemResponseFromJson(
        Map<String, dynamic> json) =>
    InviteLinkItemResponse(
      json['id'] as num?,
      json['name'] as String?,
      json['fullName'] as String?,
      json['remark'] as String?,
      json['spread'] as num?,
      json['commission'] as num?,
      json['inviteURL'] as String?,
      json['unlock'] as bool?,
      json['unlockLevelCode'] as String?,
      json['unlockLevelName'] as String?,
      json['color'] as String?,
      json['i18N_Desc'] as String?,
      json['i18N_UnlockDesc'] as String?,
    );

Map<String, dynamic> _$InviteLinkItemResponseToJson(
        InviteLinkItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fullName': instance.fullName,
      'remark': instance.remark,
      'spread': instance.spread,
      'commission': instance.commission,
      'inviteURL': instance.inviteURL,
      'unlock': instance.unlock,
      'unlockLevelCode': instance.unlockLevelCode,
      'unlockLevelName': instance.unlockLevelName,
      'color': instance.color,
      'i18N_Desc': instance.i18NDesc,
      'i18N_UnlockDesc': instance.i18NUnlockDesc,
    };
