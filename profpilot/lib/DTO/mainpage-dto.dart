

class MainPageDTO {
  final String title;
  final String description;
  final String image;

  MainPageDTO({required this.title, required this.description, required this.image});

  factory MainPageDTO.fromJson(Map<String, dynamic> json) {
    return MainPageDTO(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'image': image,
  };

  factory MainPageDTO.empty() {
    return MainPageDTO(
      title: '',
      description: '',
      image: '',
    );
  }
}