// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProductDetailsStruct extends FFFirebaseStruct {
  ProductDetailsStruct({
    String? brand,
    String? gearbox,
    double? km,
    String? year,
    String? engine,
    String? fuel,
    String? hp,
    String? transmission,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _brand = brand,
        _gearbox = gearbox,
        _km = km,
        _year = year,
        _engine = engine,
        _fuel = fuel,
        _hp = hp,
        _transmission = transmission,
        super(firestoreUtilData);

  // "Brand" field.
  String? _brand;
  String get brand => _brand ?? '';
  set brand(String? val) => _brand = val;
  bool hasBrand() => _brand != null;

  // "Gearbox" field.
  String? _gearbox;
  String get gearbox => _gearbox ?? '';
  set gearbox(String? val) => _gearbox = val;
  bool hasGearbox() => _gearbox != null;

  // "Km" field.
  double? _km;
  double get km => _km ?? 0.0;
  set km(double? val) => _km = val;
  void incrementKm(double amount) => _km = km + amount;
  bool hasKm() => _km != null;

  // "Year" field.
  String? _year;
  String get year => _year ?? '';
  set year(String? val) => _year = val;
  bool hasYear() => _year != null;

  // "Engine" field.
  String? _engine;
  String get engine => _engine ?? '';
  set engine(String? val) => _engine = val;
  bool hasEngine() => _engine != null;

  // "Fuel" field.
  String? _fuel;
  String get fuel => _fuel ?? '';
  set fuel(String? val) => _fuel = val;
  bool hasFuel() => _fuel != null;

  // "HP" field.
  String? _hp;
  String get hp => _hp ?? '';
  set hp(String? val) => _hp = val;
  bool hasHp() => _hp != null;

  // "Transmission" field.
  String? _transmission;
  String get transmission => _transmission ?? '';
  set transmission(String? val) => _transmission = val;
  bool hasTransmission() => _transmission != null;

  static ProductDetailsStruct fromMap(Map<String, dynamic> data) =>
      ProductDetailsStruct(
        brand: data['Brand'] as String?,
        gearbox: data['Gearbox'] as String?,
        km: castToType<double>(data['Km']),
        year: data['Year'] as String?,
        engine: data['Engine'] as String?,
        fuel: data['Fuel'] as String?,
        hp: data['HP'] as String?,
        transmission: data['Transmission'] as String?,
      );

  static ProductDetailsStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? ProductDetailsStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'Brand': _brand,
        'Gearbox': _gearbox,
        'Km': _km,
        'Year': _year,
        'Engine': _engine,
        'Fuel': _fuel,
        'HP': _hp,
        'Transmission': _transmission,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Brand': serializeParam(
          _brand,
          ParamType.String,
        ),
        'Gearbox': serializeParam(
          _gearbox,
          ParamType.String,
        ),
        'Km': serializeParam(
          _km,
          ParamType.double,
        ),
        'Year': serializeParam(
          _year,
          ParamType.String,
        ),
        'Engine': serializeParam(
          _engine,
          ParamType.String,
        ),
        'Fuel': serializeParam(
          _fuel,
          ParamType.String,
        ),
        'HP': serializeParam(
          _hp,
          ParamType.String,
        ),
        'Transmission': serializeParam(
          _transmission,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProductDetailsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProductDetailsStruct(
        brand: deserializeParam(
          data['Brand'],
          ParamType.String,
          false,
        ),
        gearbox: deserializeParam(
          data['Gearbox'],
          ParamType.String,
          false,
        ),
        km: deserializeParam(
          data['Km'],
          ParamType.double,
          false,
        ),
        year: deserializeParam(
          data['Year'],
          ParamType.String,
          false,
        ),
        engine: deserializeParam(
          data['Engine'],
          ParamType.String,
          false,
        ),
        fuel: deserializeParam(
          data['Fuel'],
          ParamType.String,
          false,
        ),
        hp: deserializeParam(
          data['HP'],
          ParamType.String,
          false,
        ),
        transmission: deserializeParam(
          data['Transmission'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ProductDetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsStruct &&
        brand == other.brand &&
        gearbox == other.gearbox &&
        km == other.km &&
        year == other.year &&
        engine == other.engine &&
        fuel == other.fuel &&
        hp == other.hp &&
        transmission == other.transmission;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([brand, gearbox, km, year, engine, fuel, hp, transmission]);
}

ProductDetailsStruct createProductDetailsStruct({
  String? brand,
  String? gearbox,
  double? km,
  String? year,
  String? engine,
  String? fuel,
  String? hp,
  String? transmission,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ProductDetailsStruct(
      brand: brand,
      gearbox: gearbox,
      km: km,
      year: year,
      engine: engine,
      fuel: fuel,
      hp: hp,
      transmission: transmission,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ProductDetailsStruct? updateProductDetailsStruct(
  ProductDetailsStruct? productDetails, {
  bool clearUnsetFields = true,
}) =>
    productDetails
      ?..firestoreUtilData =
          FirestoreUtilData(clearUnsetFields: clearUnsetFields);

void addProductDetailsStructData(
  Map<String, dynamic> firestoreData,
  ProductDetailsStruct? productDetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (productDetails == null) {
    return;
  }
  if (productDetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && productDetails.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final productDetailsData =
      getProductDetailsFirestoreData(productDetails, forFieldValue);
  final nestedData =
      productDetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = productDetails.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getProductDetailsFirestoreData(
  ProductDetailsStruct? productDetails, [
  bool forFieldValue = false,
]) {
  if (productDetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(productDetails.toMap());

  // Add any Firestore field values
  productDetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getProductDetailsListFirestoreData(
  List<ProductDetailsStruct>? productDetailss,
) =>
    productDetailss
        ?.map((e) => getProductDetailsFirestoreData(e, true))
        .toList() ??
    [];
