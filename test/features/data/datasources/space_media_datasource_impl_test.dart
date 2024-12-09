import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/datasources/nasa_datasource_impl.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

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

  test('Should return a SpaceMediaModel when is success', () async {
    successMock();
    final tSpaceMediaModelExpected = SpaceMediaModel(explanation: "Meteors can be colorful. While the human eye usually cannot discern many colors, cameras often can. Pictured is a Quadrantids meteor captured by camera over Missouri, USA, early this month that was not only impressively bright, but colorful. The radiant grit, likely cast off by asteroid 2003 EH1, blazed a path across Earth's atmosphere.  Colors in meteors usually originate from ionized elements released as the meteor disintegrates, with blue-green typically originating from magnesium, calcium radiating violet, and nickel glowing green. Red, however, typically originates from energized nitrogen and oxygen in the Earth's atmosphere.  This bright meteoric fireball was gone in a flash -- less than a second -- but it left a wind-blown ionization trail that remained visible for several minutes.   APOD is available via Facebook: in English, Catalan and Portuguese", title: "A Colorful Quadrantid Meteor", url: "https://apod.nasa.gov/apod/image/2102/MeteorStreak_Kuszaj_1080.jpg");
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    expect(result, tSpaceMediaModelExpected);
  });
}