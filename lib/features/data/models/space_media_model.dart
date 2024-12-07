import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

class SpaceMediaModel extends SpaceMediaEntity {
  SpaceMediaModel({required String explanation, required String title, required String url}) 
    : super(explanation: explanation, title: title, url: url);

  factory SpaceMediaModel.fromJson(Map<String, dynamic> json) 
    => SpaceMediaModel(explanation: json['explanation'], title: json['title'], url: json['url']
  );

  Map<String, dynamic> toJson() => {
    'explanation': explanation,
    'title': title,
    'url': url,
  };  
}