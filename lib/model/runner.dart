import 'package:equatable/equatable.dart';

const assetPath = "asset";

class Runner extends Equatable {
  const Runner._(
    this.name,
    this.assetListLength,
  );

  final String name;
  final int assetListLength;
  String get _assetDir => "$assetPath/$name";
  List<String> get assetList => List.generate(
        assetListLength,
        (index) {
          return "$_assetDir/$index.png";
        },
      );

  String get restImage => "$_assetDir/rest.png";

  String image(int index) {
    return assetList[index % assetListLength];
  }

  @override
  List<Object?> get props => [name];

  static const Runner cat = Runner._("cat", 5);
}
