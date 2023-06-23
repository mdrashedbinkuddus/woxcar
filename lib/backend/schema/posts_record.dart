import 'dart:async';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostsRecord extends FirestoreRecord {
  PostsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "PhoneNumber" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "WhatsappNumber" field.
  String? _whatsappNumber;
  String get whatsappNumber => _whatsappNumber ?? '';
  bool hasWhatsappNumber() => _whatsappNumber != null;

  // "Keywords" field.
  List<String>? _keywords;
  List<String> get keywords => _keywords ?? const [];
  bool hasKeywords() => _keywords != null;

  // "Location" field.
  String? _location;
  String get location => _location ?? '';
  bool hasLocation() => _location != null;

  // "Details" field.
  ProductDetailsStruct? _details;
  ProductDetailsStruct get details => _details ?? ProductDetailsStruct();
  bool hasDetails() => _details != null;

  // "tradeType" field.
  String? _tradeType;
  String get tradeType => _tradeType ?? '';
  bool hasTradeType() => _tradeType != null;

  // "Negociable" field.
  bool? _negociable;
  bool get negociable => _negociable ?? false;
  bool hasNegociable() => _negociable != null;

  // "posted_by" field.
  DocumentReference? _postedBy;
  DocumentReference? get postedBy => _postedBy;
  bool hasPostedBy() => _postedBy != null;

  // "liked_by" field.
  List<DocumentReference>? _likedBy;
  List<DocumentReference> get likedBy => _likedBy ?? const [];
  bool hasLikedBy() => _likedBy != null;

  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  bool hasPrice() => _price != null;

  // "currency" field.
  String? _currency;
  String get currency => _currency ?? '';
  bool hasCurrency() => _currency != null;

  void _initializeFields() {
    _images = getDataList(snapshotData['images']);
    _video = snapshotData['video'] as String?;
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _phoneNumber = snapshotData['PhoneNumber'] as String?;
    _whatsappNumber = snapshotData['WhatsappNumber'] as String?;
    _keywords = getDataList(snapshotData['Keywords']);
    _location = snapshotData['Location'] as String?;
    _details = ProductDetailsStruct.maybeFromMap(snapshotData['Details']);
    _tradeType = snapshotData['tradeType'] as String?;
    _negociable = snapshotData['Negociable'] as bool?;
    _postedBy = snapshotData['posted_by'] as DocumentReference?;
    _likedBy = getDataList(snapshotData['liked_by']);
    _price = castToType<double>(snapshotData['price']);
    _currency = snapshotData['currency'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostsRecord.fromSnapshot(s));

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostsRecord.fromSnapshot(s));

  static PostsRecord fromSnapshot(DocumentSnapshot snapshot) => PostsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PostsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PostsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostsRecordData({
  String? video,
  String? title,
  String? description,
  String? phoneNumber,
  String? whatsappNumber,
  String? location,
  ProductDetailsStruct? details,
  String? tradeType,
  bool? negociable,
  DocumentReference? postedBy,
  double? price,
  String? currency,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'video': video,
      'title': title,
      'description': description,
      'PhoneNumber': phoneNumber,
      'WhatsappNumber': whatsappNumber,
      'Location': location,
      'Details': ProductDetailsStruct().toMap(),
      'tradeType': tradeType,
      'Negociable': negociable,
      'posted_by': postedBy,
      'price': price,
      'currency': currency,
    }.withoutNulls,
  );

  // Handle nested data for "Details" field.
  addProductDetailsStructData(firestoreData, details, 'Details');

  return firestoreData;
}
