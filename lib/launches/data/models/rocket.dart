class Rocket {
  const Rocket({required this.id, required this.name, required this.imageUrl});

  factory Rocket.fromJson(Map<String, dynamic> json) {
    final images = json['flickr_images'] as List<dynamic>?;

    return Rocket(
      id: json['rocket_id'] as String? ?? '',
      name: json['rocket_name'] as String? ?? '',
      imageUrl: images != null && images.isNotEmpty
          ? images.first as String
          : null,
    );
  }

  final String id;
  final String name;
  final String? imageUrl;
}
