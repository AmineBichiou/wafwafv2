
/*import 'package:freezed_annotation/freezed_annotation.dart';

part 'treats.freezed.dart';
part 'treats.g.dart';

List<Treats> treatsFromJson(dynamic data) =>
    List<Treats>.from(data.map((x) => Treats.fromJson(x)));

@freezed

abstract class Treats with _$Treats {
  factory Treats(
    {
    Required String treatName,
    Required String treatId,
    Required double treatPrice,
    Required String treatDescription,
    Required String treatSKU,
    Required double treatSalePrice,
    Required String treatImage,
}) = _Treats;

  factory Treats.fromJson(Map<String, dynamic> json) => _$TreatsFromJson(json);
}
extension TreatExt on Treats {
  String get fullImagePath => 
}
```*/

  