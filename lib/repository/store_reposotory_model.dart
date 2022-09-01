

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nationalize_api/model.dart';


part 'store_reposotory_model.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs


@JsonSerializable()
class StoreRepositoryEntry extends Equatable {
  final String dogUrl;
  final NationalizeResponse nationalizeResponse;

  const StoreRepositoryEntry({required this.dogUrl, required  this.nationalizeResponse});

  @override
  List<Object?> get props => [dogUrl, nationalizeResponse];


  factory StoreRepositoryEntry.fromJson(Map<String, dynamic> json) => _$StoreRepositoryEntryFromJson(json);

  Map<String, dynamic> toJson() => _$StoreRepositoryEntryToJson(this);

}