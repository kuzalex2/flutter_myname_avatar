// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_db.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetDBMessageCollection on Isar {
  IsarCollection<DBMessage> get dBMessages => getCollection();
}

const DBMessageSchema = CollectionSchema(
  name: 'DBMessage',
  schema:
      '{"name":"DBMessage","idName":"id","properties":[{"name":"jsonMessage","type":"String"}],"indexes":[],"links":[]}',
  idName: 'id',
  propertyIds: {'jsonMessage': 0},
  listProperties: {},
  indexIds: {},
  indexValueTypes: {},
  linkIds: {},
  backlinkLinkNames: {},
  getId: _dBMessageGetId,
  setId: _dBMessageSetId,
  getLinks: _dBMessageGetLinks,
  attachLinks: _dBMessageAttachLinks,
  serializeNative: _dBMessageSerializeNative,
  deserializeNative: _dBMessageDeserializeNative,
  deserializePropNative: _dBMessageDeserializePropNative,
  serializeWeb: _dBMessageSerializeWeb,
  deserializeWeb: _dBMessageDeserializeWeb,
  deserializePropWeb: _dBMessageDeserializePropWeb,
  version: 3,
);

int? _dBMessageGetId(DBMessage object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _dBMessageSetId(DBMessage object, int id) {
  object.id = id;
}

List<IsarLinkBase> _dBMessageGetLinks(DBMessage object) {
  return [];
}

void _dBMessageSerializeNative(
    IsarCollection<DBMessage> collection,
    IsarRawObject rawObj,
    DBMessage object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.jsonMessage;
  final _jsonMessage = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_jsonMessage.length) as int;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _jsonMessage);
}

DBMessage _dBMessageDeserializeNative(IsarCollection<DBMessage> collection,
    int id, IsarBinaryReader reader, List<int> offsets) {
  final object = DBMessage();
  object.id = id;
  object.jsonMessage = reader.readString(offsets[0]);
  return object;
}

P _dBMessageDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _dBMessageSerializeWeb(
    IsarCollection<DBMessage> collection, DBMessage object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'jsonMessage', object.jsonMessage);
  return jsObj;
}

DBMessage _dBMessageDeserializeWeb(
    IsarCollection<DBMessage> collection, dynamic jsObj) {
  final object = DBMessage();
  object.id = IsarNative.jsObjectGet(jsObj, 'id');
  object.jsonMessage = IsarNative.jsObjectGet(jsObj, 'jsonMessage') ?? '';
  return object;
}

P _dBMessageDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id')) as P;
    case 'jsonMessage':
      return (IsarNative.jsObjectGet(jsObj, 'jsonMessage') ?? '') as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _dBMessageAttachLinks(IsarCollection col, int id, DBMessage object) {}

extension DBMessageQueryWhereSort
    on QueryBuilder<DBMessage, DBMessage, QWhere> {
  QueryBuilder<DBMessage, DBMessage, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }
}

extension DBMessageQueryWhere
    on QueryBuilder<DBMessage, DBMessage, QWhereClause> {
  QueryBuilder<DBMessage, DBMessage, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<DBMessage, DBMessage, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<DBMessage, DBMessage, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<DBMessage, DBMessage, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }
}

extension DBMessageQueryFilter
    on QueryBuilder<DBMessage, DBMessage, QFilterCondition> {
  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> idIsNull() {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.isNull,
      property: 'id',
      value: null,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> idEqualTo(
      int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition>
      jsonMessageGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'jsonMessage',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition>
      jsonMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'jsonMessage',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<DBMessage, DBMessage, QAfterFilterCondition> jsonMessageMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'jsonMessage',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }
}

extension DBMessageQueryLinks
    on QueryBuilder<DBMessage, DBMessage, QFilterCondition> {}

extension DBMessageQueryWhereSortBy
    on QueryBuilder<DBMessage, DBMessage, QSortBy> {
  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> sortByJsonMessage() {
    return addSortByInternal('jsonMessage', Sort.asc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> sortByJsonMessageDesc() {
    return addSortByInternal('jsonMessage', Sort.desc);
  }
}

extension DBMessageQueryWhereSortThenBy
    on QueryBuilder<DBMessage, DBMessage, QSortThenBy> {
  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> thenByJsonMessage() {
    return addSortByInternal('jsonMessage', Sort.asc);
  }

  QueryBuilder<DBMessage, DBMessage, QAfterSortBy> thenByJsonMessageDesc() {
    return addSortByInternal('jsonMessage', Sort.desc);
  }
}

extension DBMessageQueryWhereDistinct
    on QueryBuilder<DBMessage, DBMessage, QDistinct> {
  QueryBuilder<DBMessage, DBMessage, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<DBMessage, DBMessage, QDistinct> distinctByJsonMessage(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('jsonMessage', caseSensitive: caseSensitive);
  }
}

extension DBMessageQueryProperty
    on QueryBuilder<DBMessage, DBMessage, QQueryProperty> {
  QueryBuilder<DBMessage, int?, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<DBMessage, String, QQueryOperations> jsonMessageProperty() {
    return addPropertyNameInternal('jsonMessage');
  }
}
