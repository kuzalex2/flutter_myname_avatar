

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs


@JsonSerializable()
class CountryProbability extends Equatable {
  final String countryCode;
  final double probability;

  const CountryProbability({
    required this.countryCode,
    required this.probability,

  });

  ///
  CountryProbability copyWith({String? countryCode, double? probability}) {
    return CountryProbability(
      countryCode: countryCode ?? this.countryCode,
      probability: probability ?? this.probability,
    );
  }


  @override
  List<Object?> get props => [countryCode, probability];


  factory CountryProbability.fromJson(Map<String, dynamic> json) => _$CountryProbabilityFromJson(json);

  Map<String, dynamic> toJson() => _$CountryProbabilityToJson(this);
}


@JsonSerializable()
class NationalizeResponse extends Equatable {
  final String name;
  final List<CountryProbability> countries;

  const NationalizeResponse({
    required this.name,
    required this.countries,
  });

  ///
  NationalizeResponse copyWith({String? name, List<CountryProbability>? countries}) {
    return NationalizeResponse(
      name: name ?? this.name,
      countries: countries ?? this.countries,
    );
  }


  factory NationalizeResponse.fromJson(Map<String, dynamic> json) => _$NationalizeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NationalizeResponseToJson(this);

  @override
  List<Object?> get props => [name, countries];

}