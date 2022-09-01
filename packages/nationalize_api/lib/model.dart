

import 'package:equatable/equatable.dart';

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
}



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


  @override
  List<Object?> get props => [name, countries];

}