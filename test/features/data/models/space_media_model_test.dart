import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_arch/features/data/models/space_media_model.dart';
import 'package:nasa_clean_arch/features/domain/entities/space_media_entity.dart';

import '../../mocks/space_media_mock.dart';

void main() {

  final tSpaceMediaModel = SpaceMediaModel(
    explanation: "Are Saturn's auroras like Earth's?  To help answer this question, the Hubble Space Telescope and the Cassini spacecraft monitored Saturn's North Pole simultaneously during Cassini's final orbits around the gas giant in September 2017.  During this time, Saturn's tilt caused its North Pole to be clearly visible from Earth. The featured image is a composite of ultraviolet images of auroras and optical images of Saturn's clouds and rings, all taken by Hubble.  Like on Earth, Saturn's northern auroras can make total or partial rings around the pole. Unlike on Earth, however, Saturn's auroras are frequently spirals -- and more likely to peak in brightness just before midnight and dawn.  In contrast to Jupiter's auroras, Saturn's auroras appear better related to connecting Saturn's internal magnetic field to the nearby, variable, solar wind.  Saturn's southern auroras were similarly imaged back in 2004 when the planet's South Pole was clearly visible to Earth.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)",
    title: "Aurora around Saturn's North Pole",
    url: "https://apod.nasa.gov/apod/image/2412/SaturnAurora_Hubble_960.jpg",
  );

  test('Should be a subclass of SpaceMediaEntity', () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test('Should return a valid model', () {
    final Map<String, dynamic> jsonMap = json.decode(spaceMediaMock);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });

  test('Should return a json map containing the proper data', (){
    final expectMap = {
      "explanation": "Are Saturn's auroras like Earth's?  To help answer this question, the Hubble Space Telescope and the Cassini spacecraft monitored Saturn's North Pole simultaneously during Cassini's final orbits around the gas giant in September 2017.  During this time, Saturn's tilt caused its North Pole to be clearly visible from Earth. The featured image is a composite of ultraviolet images of auroras and optical images of Saturn's clouds and rings, all taken by Hubble.  Like on Earth, Saturn's northern auroras can make total or partial rings around the pole. Unlike on Earth, however, Saturn's auroras are frequently spirals -- and more likely to peak in brightness just before midnight and dawn.  In contrast to Jupiter's auroras, Saturn's auroras appear better related to connecting Saturn's internal magnetic field to the nearby, variable, solar wind.  Saturn's southern auroras were similarly imaged back in 2004 when the planet's South Pole was clearly visible to Earth.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)",
    "title": "Aurora around Saturn's North Pole",
    "url": "https://apod.nasa.gov/apod/image/2412/SaturnAurora_Hubble_960.jpg"
    };

    final result = tSpaceMediaModel.toJson();

    expect(result, expectMap);
  });

}