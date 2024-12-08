import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_impl.dart';

import '../../mocks/space_media_mock.dart';

class HttpClientMock extends Mock implements HttpClient {}

void main() {

  late ISpaceMediaDatasource datasource;
  late HttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImpl(client);
  });

  final tDateTime = DateTime(2021, 02, 02);
  final urlExpected = 'https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-02-02';
  DateToStringConverter.convert(tDateTime);

  void successMock() {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: spaceMediaMock, statusCode: 200));
  }

  test('Should call the get method with correct url', () async {
    successMock();
    await datasource.getSpaceMediaFromDate(tDateTime);
    verify(() => client.get(urlExpected)).called(1);
  });

  test('Should return a SpaceMediaModel when is success', body);
}