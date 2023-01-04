import 'package:json_annotation/json_annotation.dart'; 
  
part 'new_key_global_model.g.dart';


@JsonSerializable()
  class NewKeyGlobalModel extends Object {

  @JsonKey(name: 'email')
  Email? email;

  @JsonKey(name: 'selfie')
  Selfie? selfie;

  @JsonKey(name: 'progress')
  Progress? progress;

  NewKeyGlobalModel(this.email,this.selfie,this.progress,);

  factory NewKeyGlobalModel.fromJson(Map<String, dynamic> srcJson) => _$NewKeyGlobalModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NewKeyGlobalModelToJson(this);

}

  
@JsonSerializable()
  class Email extends Object {

  @JsonKey(name: 'S')
  String? s;

  Email(this.s,);

  factory Email.fromJson(Map<String, dynamic> srcJson) => _$EmailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmailToJson(this);

}

  
@JsonSerializable()
  class Selfie extends Object {

  @JsonKey(name: 'L')
  List<L>? l;

  Selfie(this.l,);

  factory Selfie.fromJson(Map<String, dynamic> srcJson) => _$SelfieFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SelfieToJson(this);

}

  
@JsonSerializable()
  class L extends Object {

  @JsonKey(name: 'M')
  M? m;

  L(this.m,);

  factory L.fromJson(Map<String, dynamic> srcJson) => _$LFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LToJson(this);

}

  


  
@JsonSerializable()
  class Image_url extends Object {

  @JsonKey(name: 'S')
  String? s;

  Image_url(this.s,);

  factory Image_url.fromJson(Map<String, dynamic> srcJson) => _$Image_urlFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Image_urlToJson(this);

}

  
@JsonSerializable()
  class Time extends Object {

  @JsonKey(name: 'S')
  String? s;

  Time(this.s,);

  factory Time.fromJson(Map<String, dynamic> srcJson) => _$TimeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimeToJson(this);

}

  
@JsonSerializable()
  class Progress extends Object {

  @JsonKey(name: 'M')
  M? m;

  Progress(this.m,);

  factory Progress.fromJson(Map<String, dynamic> srcJson) => _$ProgressFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ProgressToJson(this);

}

  
@JsonSerializable()
  class M extends Object {

  @JsonKey(name: 'red')
  Red? red;

  @JsonKey(name: 'other')
  Other? other;

  @JsonKey(name: 'blue')
  Blue? blue;

  @JsonKey(name: 'average_time')
  Average_time? averageTime;

  @JsonKey(name: 'total_sessions')
  Total_sessions? totalSessions;

  @JsonKey(name: 'image_url')
  Image_url? imageUrl;

  @JsonKey(name: 'time')
  Time? time;

  M(this.red,this.other,this.blue,this.averageTime,this.totalSessions,this.imageUrl,this.time);

  factory M.fromJson(Map<String, dynamic> srcJson) => _$MFromJson(srcJson);

  Map<String, dynamic> toJson() => _$MToJson(this);

}

  
@JsonSerializable()
  class Red extends Object {

  @JsonKey(name: 'S')
  String? s;

  Red(this.s,);

  factory Red.fromJson(Map<String, dynamic> srcJson) => _$RedFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RedToJson(this);

}

  
@JsonSerializable()
  class Other extends Object {

  @JsonKey(name: 'S')
  String? s;

  Other(this.s,);

  factory Other.fromJson(Map<String, dynamic> srcJson) => _$OtherFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OtherToJson(this);

}

  
@JsonSerializable()
  class Blue extends Object {

  @JsonKey(name: 'S')
  String? s;

  Blue(this.s,);

  factory Blue.fromJson(Map<String, dynamic> srcJson) => _$BlueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$BlueToJson(this);

}

  
@JsonSerializable()
  class Average_time extends Object {

  @JsonKey(name: 'S')
  String? s;

  Average_time(this.s,);

  factory Average_time.fromJson(Map<String, dynamic> srcJson) => _$Average_timeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Average_timeToJson(this);

}

  
@JsonSerializable()
  class Total_sessions extends Object {

  @JsonKey(name: 'S')
  String? s;

  Total_sessions(this.s,);

  factory Total_sessions.fromJson(Map<String, dynamic> srcJson) => _$Total_sessionsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$Total_sessionsToJson(this);

}

  
