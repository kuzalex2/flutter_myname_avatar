

import 'package:equatable/equatable.dart';

class CountryProbability extends Equatable {
  final String country;
  final double probability;

  const CountryProbability({
    required this.country,
    required this.probability,

  });

  ///
  CountryProbability copyWith({String? country, double? probability}) {
    return CountryProbability(
      country: country ?? this.country,
      probability: probability ?? this.probability,
    );
  }


  @override
  List<Object?> get props => [country, probability];
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