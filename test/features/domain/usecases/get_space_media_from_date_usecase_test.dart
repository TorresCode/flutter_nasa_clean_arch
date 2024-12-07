import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/core/errors/failures.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';
import 'package:nasa_clean_arch/features/domain/repositories/space_media_repository.dart';
import 'package:nasa_clean_arch/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:equatable/equatable.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}
class ServerFailure extends Failure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
void main() {
  late GetSpaceMediaFromDateUsecase usecase;
  late ISpaceMediaRepository repository;

  setUp(() {
    registerFallbackValue(DateTime(0)); // Registrar um fallback para o DateTime
    repository = MockSpaceMediaRepository();
    usecase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity (
    explanation: 'Colorful and bright, this streaking fireball meteor was captured...',
    title: "Xuyi Station and the Fireball",
    url: "https://apod.nasa.gov/apod/image/2412/PurpleMountainObservatoryXuYiStationFireball1024.jpg",
  );

  //final tNoParams = NoParams();
  final tDate = DateTime(
    2024,
    12,
    06
  );

 test('Should get space media entity from the repository', () async {
    // Configurando o mock corretamente
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Right(tSpaceMedia));
    // Executa o caso de uso
    final result = await usecase(tDate);
    // Debug: Exibindo o resultado no console
    //print(result); // Deve mostrar Right(SpaceMediaEntity(...))
    // Verifica os resultados
    expect(result, Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });


  test('Should return a ServerFailure when don\'t succeed', () async {
    // Configurando o mock corretamente
    when(() => repository.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => Left(ServerFailure()));
    // Executa o caso de uso
    final result = await usecase(tDate);
    // Debug: Exibindo o resultado no console
    //print(result); // Deve mostrar Left(ServerFailure())
    // Verifica os resultados
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate)).called(1);
  });

}
