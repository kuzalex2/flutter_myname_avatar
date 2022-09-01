// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_reposotory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreRepositoryEntry _$StoreRepositoryEntryFromJson(
        Map<String, dynamic> json) =>
    StoreRepositoryEntry(
      dogUrl: json['dogUrl'] as String,
      nationalizeResponse: NationalizeResponse.fromJson(
          json['nationalizeResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StoreRepositoryEntryToJson(
        StoreRepositoryEntry instance) =>
    <String, dynamic>{
      'dogUrl': instance.dogUrl,
      'nationalizeResponse': instance.nationalizeResponse,
    };

StoreRepositoryList _$StoreRepositoryListFromJson(Map<String, dynamic> json) =>
    StoreRepositoryList(
      list: (json['list'] as List<dynamic>)
          .map((e) => StoreRepositoryEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StoreRepositoryListToJson(
        StoreRepositoryList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
