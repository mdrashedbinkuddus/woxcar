import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  List<String> _BrandList = ['Audi', 'BMW', 'Mercedes', 'KIA', 'Tayota'];
  List<String> get BrandList => _BrandList;
  set BrandList(List<String> _value) {
    _BrandList = _value;
  }

  void addToBrandList(String _value) {
    _BrandList.add(_value);
  }

  void removeFromBrandList(String _value) {
    _BrandList.remove(_value);
  }

  void removeAtIndexFromBrandList(int _index) {
    _BrandList.removeAt(_index);
  }

  void updateBrandListAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _BrandList[_index] = updateFn(_BrandList[_index]);
  }

  List<String> _Gearbox = ['Manual', 'Automatic', 'Semi - Auto'];
  List<String> get Gearbox => _Gearbox;
  set Gearbox(List<String> _value) {
    _Gearbox = _value;
  }

  void addToGearbox(String _value) {
    _Gearbox.add(_value);
  }

  void removeFromGearbox(String _value) {
    _Gearbox.remove(_value);
  }

  void removeAtIndexFromGearbox(int _index) {
    _Gearbox.removeAt(_index);
  }

  void updateGearboxAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _Gearbox[_index] = updateFn(_Gearbox[_index]);
  }

  List<String> _Fuel = ['Hybrid', 'Diesel', 'Petrol', 'Electric'];
  List<String> get Fuel => _Fuel;
  set Fuel(List<String> _value) {
    _Fuel = _value;
  }

  void addToFuel(String _value) {
    _Fuel.add(_value);
  }

  void removeFromFuel(String _value) {
    _Fuel.remove(_value);
  }

  void removeAtIndexFromFuel(int _index) {
    _Fuel.removeAt(_index);
  }

  void updateFuelAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _Fuel[_index] = updateFn(_Fuel[_index]);
  }

  List<String> _Transmission = ['FWD', 'RWD', '4 x 4'];
  List<String> get Transmission => _Transmission;
  set Transmission(List<String> _value) {
    _Transmission = _value;
  }

  void addToTransmission(String _value) {
    _Transmission.add(_value);
  }

  void removeFromTransmission(String _value) {
    _Transmission.remove(_value);
  }

  void removeAtIndexFromTransmission(int _index) {
    _Transmission.removeAt(_index);
  }

  void updateTransmissionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _Transmission[_index] = updateFn(_Transmission[_index]);
  }

  final _postDetailsManager = StreamRequestManager<PostsRecord>();
  Stream<PostsRecord> postDetails({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Stream<PostsRecord> Function() requestFn,
  }) =>
      _postDetailsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearPostDetailsCache() => _postDetailsManager.clear();
  void clearPostDetailsCacheKey(String? uniqueKey) =>
      _postDetailsManager.clearRequest(uniqueKey);
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
