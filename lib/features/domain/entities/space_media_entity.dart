import 'package:equatable/equatable.dart';

class SpaceMediaEntity extends Equatable {
  final String explanation;
  final String title;
  final String url;

  // ignore: prefer_const_constructors_in_immutables
  SpaceMediaEntity({required this.explanation, required this.title, required this.url});

  @override
  List<Object> get props => [explanation, title, url];
  
}