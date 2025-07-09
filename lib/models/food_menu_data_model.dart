class MenuItem {
  final int id;
  final String groupName;
  final String groupDescription;
  final String disName;
  final String menuImage;
  final String disDescription;
  final double largePrice;
  final double smallPrice;
  final double mediumPrice;
  final String menuCode;
  final String barCodeNumber;
  final String itemType;
  final int itemId;

  MenuItem({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.disName,
    required this.menuImage,
    required this.disDescription,
    required this.largePrice,
    required this.smallPrice,
    required this.mediumPrice,
    required this.menuCode,
    required this.barCodeNumber,
    required this.itemType,
    required this.itemId,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['Id'],
      groupName: json['GroupName'],
      groupDescription: json['GroupDescription'],
      disName: json['DisName'],
      menuImage: json['MenuImage'],
      disDescription: json['DisDescription'],
      largePrice: (json['LargePrice'] ?? 0).toDouble(),
      smallPrice: (json['SmallPrice'] ?? 0).toDouble(),
      mediumPrice: (json['MediumPrice'] ?? 0).toDouble(),
      menuCode: json['MenuCode'],
      barCodeNumber: json['BarCodeNumber'],
      itemType: json['ItemType'],
      itemId: json['ItemId'],
    );
  }
}
