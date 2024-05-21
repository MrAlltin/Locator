class CustomData {
  String category;
  String coordinates;
  String desc;
  // int id;
  String image;
  String name;

  CustomData({
    required this.category,
    required this.coordinates,
    required this.desc,
    // required this.id,
    required this.image,
    required this.name,
  });

  factory CustomData.fromMap(Map<String, dynamic> map) {
    return CustomData(
      category: map['category'],
      coordinates: map['coordinates'],
      desc: map['desc'],
      // id: map['id'],
      image: map['image'],
      name: map['name'],
    );
  }}