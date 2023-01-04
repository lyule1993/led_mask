// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_key_global_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewKeyGlobalModel _$NewKeyGlobalModelFromJson(Map<String, dynamic> json) =>
    NewKeyGlobalModel(
      json['email'] == null
          ? null
          : Email.fromJson(json['email'] as Map<String, dynamic>),
      json['selfie'] == null
          ? null
          : Selfie.fromJson(json['selfie'] as Map<String, dynamic>),
      json['progress'] == null
          ? null
          : Progress.fromJson(json['progress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NewKeyGlobalModelToJson(NewKeyGlobalModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'selfie': instance.selfie,
      'progress': instance.progress,
    };

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
      json['S'] as String?,
    );

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
      'S': instance.s,
    };

Selfie _$SelfieFromJson(Map<String, dynamic> json) => Selfie(
      (json['L'] as List<dynamic>?)
          ?.map((e) => L.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SelfieToJson(Selfie instance) => <String, dynamic>{
      'L': instance.l,
    };

L _$LFromJson(Map<String, dynamic> json) => L(
      json['M'] == null ? null : M.fromJson(json['M'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LToJson(L instance) => <String, dynamic>{
      'M': instance.m,
    };

Image_url _$Image_urlFromJson(Map<String, dynamic> json) => Image_url(
      json['S'] as String?,
    );

Map<String, dynamic> _$Image_urlToJson(Image_url instance) => <String, dynamic>{
      'S': instance.s,
    };

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      json['S'] as String?,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'S': instance.s,
    };

Progress _$ProgressFromJson(Map<String, dynamic> json) => Progress(
      json['M'] == null ? null : M.fromJson(json['M'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
      'M': instance.m,
    };

M _$MFromJson(Map<String, dynamic> json) => M(
      json['red'] == null
          ? null
          : Red.fromJson(json['red'] as Map<String, dynamic>),
      json['other'] == null
          ? null
          : Other.fromJson(json['other'] as Map<String, dynamic>),
      json['blue'] == null
          ? null
          : Blue.fromJson(json['blue'] as Map<String, dynamic>),
      json['average_time'] == null
          ? null
          : Average_time.fromJson(json['average_time'] as Map<String, dynamic>),
      json['total_sessions'] == null
          ? null
          : Total_sessions.fromJson(
              json['total_sessions'] as Map<String, dynamic>),
      json['image_url'] == null
          ? null
          : Image_url.fromJson(json['image_url'] as Map<String, dynamic>),
      json['time'] == null
          ? null
          : Time.fromJson(json['time'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MToJson(M instance) => <String, dynamic>{
      'red': instance.red,
      'other': instance.other,
      'blue': instance.blue,
      'average_time': instance.averageTime,
      'total_sessions': instance.totalSessions,
      'image_url': instance.imageUrl,
      'time': instance.time,
    };

Red _$RedFromJson(Map<String, dynamic> json) => Red(
      json['S'] as String?,
    );

Map<String, dynamic> _$RedToJson(Red instance) => <String, dynamic>{
      'S': instance.s,
    };

Other _$OtherFromJson(Map<String, dynamic> json) => Other(
      json['S'] as String?,
    );

Map<String, dynamic> _$OtherToJson(Other instance) => <String, dynamic>{
      'S': instance.s,
    };

Blue _$BlueFromJson(Map<String, dynamic> json) => Blue(
      json['S'] as String?,
    );

Map<String, dynamic> _$BlueToJson(Blue instance) => <String, dynamic>{
      'S': instance.s,
    };

Average_time _$Average_timeFromJson(Map<String, dynamic> json) => Average_time(
      json['S'] as String?,
    );

Map<String, dynamic> _$Average_timeToJson(Average_time instance) =>
    <String, dynamic>{
      'S': instance.s,
    };

Total_sessions _$Total_sessionsFromJson(Map<String, dynamic> json) =>
    Total_sessions(
      json['S'] as String?,
    );

Map<String, dynamic> _$Total_sessionsToJson(Total_sessions instance) =>
    <String, dynamic>{
      'S': instance.s,
    };
