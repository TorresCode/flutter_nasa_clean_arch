import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/data/repositories/space_media_repository_impl.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource{}

void main(){
  late SpaceMediaRepositoryImpl repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImpl(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
    explanation: 'TorresCode',
    title: "Xuyi Station and the Fireball",
    url: "https://apod.nasa.gov/apod/image/2412/PurpleMountainObservatoryXuYiStationFireball1024.jpg",
  );

  final tDate = DateTime(
    2024,
    12,
    06
  );

  test("TC Should return space media model when calls the datasources", () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
      .thenAnswer((_) async => tSpaceMediaModel);
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });  

  test("TC Should return a server failure when the call to datasources", () async {
    // Arrange
    when(() => datasource.getSpaceMediaFromDate(any()))
      .thenThrow(ServerExceptions());
    // Act
    final result = await repository.getSpaceMediaFromDate(tDate);
    // Assert
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDate)).called(1);
  });  
}