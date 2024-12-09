import 'dart:convert';

import 'package:nasa_clean_arch/core/errors/exceptions.dart';
import 'package:nasa_clean_arch/core/http_client/http_client.dart';
import 'package:nasa_clean_arch/core/utils/converters/date_to_string_converter.dart';
import 'package:nasa_clean_arch/core/utils/keys/nasa_api_keys.dart';
import 'package:nasa_clean_arch/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:nasa_clean_arch/features/data/datasources/space_media_datasource.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';

class NasaDatasourceImpl extends ISpaceMediaDatasource {
  final HttpClient client;
  NasaDatasourceImpl(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      //try {
        final jsonData = jsonDecode(response.data);
        return SpaceMediaModel.fromJson(jsonData);
      /*} catch (e) {
        throw FormatException('Invalid JSON: ${response.data}');
      }*/
    } else {
       throw ServerExceptions();
    }

    //return await client.get(NasaEndpoints.apod(NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
  }

}