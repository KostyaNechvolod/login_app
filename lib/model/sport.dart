import 'package:json_annotation/json_annotation.dart';

part 'sport.g.dart';

@JsonSerializable()
class Sport {
  final String strSport;
  final String strSportThumb;
  final String strSportDescription;

  Sport(this.strSport, this.strSportThumb, this.strSportDescription);

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);


}