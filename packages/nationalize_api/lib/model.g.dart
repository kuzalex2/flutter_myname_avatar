// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryProbability _$CountryProbabilityFromJson(Map<String, dynamic> json) =>
    CountryProbability(
      countryCode: json['countryCode'] as String,
      probability: (json['probability'] as num).toDouble(),
    );

Map<String, dynamic> _$CountryProbabilityToJson(CountryProbability instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'probability': instance.probability,
    };

NationalizeResponse _$NationalizeResponseFromJson(Map<String, dynamic> json) =>
    NationalizeResponse(
      name: json['name'] as String,
      countries: (json['countries'] as List<dynamic>)
          .map((e) => CountryProbability.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NationalizeResponseToJson(
        NationalizeResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'countries': instance.countries,
    };
