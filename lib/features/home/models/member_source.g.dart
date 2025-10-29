// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_source.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSourceSelectionCollection on Isar {
  IsarCollection<SourceSelection> get sourceSelections => this.collection();
}

const SourceSelectionSchema = CollectionSchema(
  name: r'SourceSelection',
  id: 3884862887259532387,
  properties: {
    r'familyMemberUid': PropertySchema(
      id: 0,
      name: r'familyMemberUid',
      type: IsarType.string,
    ),
    r'selectedDate': PropertySchema(
      id: 1,
      name: r'selectedDate',
      type: IsarType.string,
    ),
    r'sourceIds': PropertySchema(
      id: 2,
      name: r'sourceIds',
      type: IsarType.stringList,
    ),
    r'totalCalcium': PropertySchema(
      id: 3,
      name: r'totalCalcium',
      type: IsarType.double,
    ),
    r'totalFiber': PropertySchema(
      id: 4,
      name: r'totalFiber',
      type: IsarType.double,
    ),
    r'totalIron': PropertySchema(
      id: 5,
      name: r'totalIron',
      type: IsarType.double,
    ),
    r'totalMagnesium': PropertySchema(
      id: 6,
      name: r'totalMagnesium',
      type: IsarType.double,
    ),
    r'totalOmega3FattyAcid': PropertySchema(
      id: 7,
      name: r'totalOmega3FattyAcid',
      type: IsarType.double,
    ),
    r'totalPotassium': PropertySchema(
      id: 8,
      name: r'totalPotassium',
      type: IsarType.double,
    ),
    r'totalPrice': PropertySchema(
      id: 9,
      name: r'totalPrice',
      type: IsarType.double,
    ),
    r'totalVitE': PropertySchema(
      id: 10,
      name: r'totalVitE',
      type: IsarType.double,
    ),
    r'totalVitaminB12': PropertySchema(
      id: 11,
      name: r'totalVitaminB12',
      type: IsarType.double,
    ),
    r'totalVitaminD': PropertySchema(
      id: 12,
      name: r'totalVitaminD',
      type: IsarType.double,
    ),
    r'totalWater': PropertySchema(
      id: 13,
      name: r'totalWater',
      type: IsarType.double,
    )
  },
  estimateSize: _sourceSelectionEstimateSize,
  serialize: _sourceSelectionSerialize,
  deserialize: _sourceSelectionDeserialize,
  deserializeProp: _sourceSelectionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _sourceSelectionGetId,
  getLinks: _sourceSelectionGetLinks,
  attach: _sourceSelectionAttach,
  version: '3.1.0+1',
);

int _sourceSelectionEstimateSize(
  SourceSelection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.familyMemberUid.length * 3;
  bytesCount += 3 + object.selectedDate.length * 3;
  bytesCount += 3 + object.sourceIds.length * 3;
  {
    for (var i = 0; i < object.sourceIds.length; i++) {
      final value = object.sourceIds[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _sourceSelectionSerialize(
  SourceSelection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.familyMemberUid);
  writer.writeString(offsets[1], object.selectedDate);
  writer.writeStringList(offsets[2], object.sourceIds);
  writer.writeDouble(offsets[3], object.totalCalcium);
  writer.writeDouble(offsets[4], object.totalFiber);
  writer.writeDouble(offsets[5], object.totalIron);
  writer.writeDouble(offsets[6], object.totalMagnesium);
  writer.writeDouble(offsets[7], object.totalOmega3FattyAcid);
  writer.writeDouble(offsets[8], object.totalPotassium);
  writer.writeDouble(offsets[9], object.totalPrice);
  writer.writeDouble(offsets[10], object.totalVitE);
  writer.writeDouble(offsets[11], object.totalVitaminB12);
  writer.writeDouble(offsets[12], object.totalVitaminD);
  writer.writeDouble(offsets[13], object.totalWater);
}

SourceSelection _sourceSelectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SourceSelection(
    familyMemberUid: reader.readString(offsets[0]),
    selectedDate: reader.readString(offsets[1]),
    sourceIds: reader.readStringList(offsets[2]) ?? [],
    totalCalcium: reader.readDouble(offsets[3]),
    totalFiber: reader.readDouble(offsets[4]),
    totalIron: reader.readDouble(offsets[5]),
    totalMagnesium: reader.readDouble(offsets[6]),
    totalOmega3FattyAcid: reader.readDouble(offsets[7]),
    totalPotassium: reader.readDouble(offsets[8]),
    totalPrice: reader.readDouble(offsets[9]),
    totalVitE: reader.readDouble(offsets[10]),
    totalVitaminB12: reader.readDouble(offsets[11]),
    totalVitaminD: reader.readDouble(offsets[12]),
    totalWater: reader.readDouble(offsets[13]),
  );
  object.id = id;
  return object;
}

P _sourceSelectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readDouble(offset)) as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readDouble(offset)) as P;
    case 11:
      return (reader.readDouble(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _sourceSelectionGetId(SourceSelection object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _sourceSelectionGetLinks(SourceSelection object) {
  return [];
}

void _sourceSelectionAttach(
    IsarCollection<dynamic> col, Id id, SourceSelection object) {
  object.id = id;
}

extension SourceSelectionQueryWhereSort
    on QueryBuilder<SourceSelection, SourceSelection, QWhere> {
  QueryBuilder<SourceSelection, SourceSelection, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SourceSelectionQueryWhere
    on QueryBuilder<SourceSelection, SourceSelection, QWhereClause> {
  QueryBuilder<SourceSelection, SourceSelection, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SourceSelectionQueryFilter
    on QueryBuilder<SourceSelection, SourceSelection, QFilterCondition> {
  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'familyMemberUid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'familyMemberUid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'familyMemberUid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyMemberUid',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      familyMemberUidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'familyMemberUid',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'selectedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'selectedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'selectedDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'selectedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      selectedDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'selectedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceIds',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceIds',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceIds',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceIds',
        value: '',
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      sourceIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'sourceIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalCalciumEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalCalcium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalCalciumGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalCalcium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalCalciumLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalCalcium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalCalciumBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalCalcium',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalFiberEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalFiberGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalFiberLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFiber',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalFiberBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFiber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalIronEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalIron',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalIronGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalIron',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalIronLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalIron',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalIronBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalIron',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalMagnesiumEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalMagnesium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalMagnesiumGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalMagnesium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalMagnesiumLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalMagnesium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalMagnesiumBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalMagnesium',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalOmega3FattyAcidEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalOmega3FattyAcid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalOmega3FattyAcidGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalOmega3FattyAcid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalOmega3FattyAcidLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalOmega3FattyAcid',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalOmega3FattyAcidBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalOmega3FattyAcid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPotassiumEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPotassium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPotassiumGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPotassium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPotassiumLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPotassium',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPotassiumBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPotassium',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitEEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalVitE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitEGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalVitE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitELessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalVitE',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitEBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalVitE',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminB12EqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalVitaminB12',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminB12GreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalVitaminB12',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminB12LessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalVitaminB12',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminB12Between(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalVitaminB12',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminDEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalVitaminD',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminDGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalVitaminD',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminDLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalVitaminD',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalVitaminDBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalVitaminD',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalWaterEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalWaterGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalWaterLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalWater',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterFilterCondition>
      totalWaterBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalWater',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension SourceSelectionQueryObject
    on QueryBuilder<SourceSelection, SourceSelection, QFilterCondition> {}

extension SourceSelectionQueryLinks
    on QueryBuilder<SourceSelection, SourceSelection, QFilterCondition> {}

extension SourceSelectionQuerySortBy
    on QueryBuilder<SourceSelection, SourceSelection, QSortBy> {
  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByFamilyMemberUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyMemberUid', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByFamilyMemberUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyMemberUid', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortBySelectedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedDate', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortBySelectedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedDate', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalCalcium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalcium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalCalciumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalcium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalFiberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalIron() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIron', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalIronDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIron', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalMagnesium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMagnesium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalMagnesiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMagnesium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalOmega3FattyAcid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOmega3FattyAcid', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalOmega3FattyAcidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOmega3FattyAcid', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalPotassium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPotassium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalPotassiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPotassium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitE', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitE', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitaminB12() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminB12', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitaminB12Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminB12', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitaminD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminD', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalVitaminDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminD', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWater', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      sortByTotalWaterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWater', Sort.desc);
    });
  }
}

extension SourceSelectionQuerySortThenBy
    on QueryBuilder<SourceSelection, SourceSelection, QSortThenBy> {
  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByFamilyMemberUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyMemberUid', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByFamilyMemberUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyMemberUid', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenBySelectedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedDate', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenBySelectedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'selectedDate', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalCalcium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalcium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalCalciumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalCalcium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalFiberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFiber', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalIron() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIron', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalIronDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalIron', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalMagnesium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMagnesium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalMagnesiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalMagnesium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalOmega3FattyAcid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOmega3FattyAcid', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalOmega3FattyAcidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalOmega3FattyAcid', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalPotassium() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPotassium', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalPotassiumDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPotassium', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPrice', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitE() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitE', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitEDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitE', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitaminB12() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminB12', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitaminB12Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminB12', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitaminD() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminD', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalVitaminDDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalVitaminD', Sort.desc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWater', Sort.asc);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QAfterSortBy>
      thenByTotalWaterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalWater', Sort.desc);
    });
  }
}

extension SourceSelectionQueryWhereDistinct
    on QueryBuilder<SourceSelection, SourceSelection, QDistinct> {
  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByFamilyMemberUid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'familyMemberUid',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctBySelectedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'selectedDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctBySourceIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceIds');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalCalcium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalCalcium');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalFiber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFiber');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalIron() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalIron');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalMagnesium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalMagnesium');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalOmega3FattyAcid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalOmega3FattyAcid');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalPotassium() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPotassium');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPrice');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalVitE() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalVitE');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalVitaminB12() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalVitaminB12');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalVitaminD() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalVitaminD');
    });
  }

  QueryBuilder<SourceSelection, SourceSelection, QDistinct>
      distinctByTotalWater() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalWater');
    });
  }
}

extension SourceSelectionQueryProperty
    on QueryBuilder<SourceSelection, SourceSelection, QQueryProperty> {
  QueryBuilder<SourceSelection, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SourceSelection, String, QQueryOperations>
      familyMemberUidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'familyMemberUid');
    });
  }

  QueryBuilder<SourceSelection, String, QQueryOperations>
      selectedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'selectedDate');
    });
  }

  QueryBuilder<SourceSelection, List<String>, QQueryOperations>
      sourceIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceIds');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalCalciumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalCalcium');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations> totalFiberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFiber');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations> totalIronProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalIron');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalMagnesiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalMagnesium');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalOmega3FattyAcidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalOmega3FattyAcid');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalPotassiumProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPotassium');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations> totalPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPrice');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations> totalVitEProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalVitE');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalVitaminB12Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalVitaminB12');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations>
      totalVitaminDProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalVitaminD');
    });
  }

  QueryBuilder<SourceSelection, double, QQueryOperations> totalWaterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalWater');
    });
  }
}
