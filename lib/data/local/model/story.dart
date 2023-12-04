class Story {
  String id;
  String name;
  String description;
  String photoUrl;
  String createdAt;
  double? lat;
  double? lon;

  Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat = 0,
    this.lon = 0,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json['createdAt'],
        lat: json["lat"]?.toDouble() ?? 0,
        lon: json["lon"]?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt,
        "lat": lat,
        "lon": lon,
      };
}

List<Story> dummyStories = [
  Story(
    id: "story-LXH9DNvdy8E0q_OS",
    name: "sultansyah",
    description: "jdsajdsai",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701533963156_Miiv4zT5.jpg",
    createdAt: "2023-12-02T16:19:23.158Z",
  ),
  Story(
    id: "story-hP77ngs4t7vflbP-",
    name: "Joko Thinker",
    description: "Android Intermediate at Dicoding",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701533802655_miI5Dxqf.jpg",
    createdAt: "2023-12-02T16:16:42.661Z",
    lat: 37.421997,
    lon: -122.084,
  ),
  Story(
    id: "story-1uQxQl3dkCWdaF-h",
    name: "abc56",
    description: "tez",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701532952512_eCksEKqZ.jpg",
    createdAt: "2023-12-02T16:02:32.515Z",
  ),
  Story(
    id: "story-m4Hr2H6fFcUef61h",
    name: "zaid",
    description: "Y",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701532098859_4P5C9ZCH.jpg",
    createdAt: "2023-12-02T15:48:18.867Z",
  ),
  Story(
    id: "story-Wb8hHA7SUYMllTUb",
    name: "jati",
    description: "Lagi belajar menyelesaikan tugas",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701531849584_K_SREq6O.jpg",
    createdAt: "2023-12-02T15:44:09.589Z",
  ),
  Story(
    id: "story-85NIdwMPevgYjB2B",
    name: "reviewer",
    description: "test",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701529954622_MZc-ORSY.jpg",
    createdAt: "2023-12-02T15:12:34.626Z",
  ),
  Story(
    id: "story-ez_EblqIe2pMr8cu",
    name: "student89",
    description: "tesss",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701528711317_1YOi6Hzu.jpg",
    createdAt: "2023-12-02T14:51:51.319Z",
  ),
  Story(
    id: "story-nQlMEU4LNJolYh99",
    name: "Hadi S",
    description: "test",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701528674832_I2-ybAvC.jpeg",
    createdAt: "2023-12-02T14:51:14.836Z",
  ),
  Story(
    id: "story-zrYOYa4x7ESHTj0H",
    name: "gintingherisanjaya",
    description: "h",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701527505636_KSGG8ebp.jpg",
    createdAt: "2023-12-02T14:31:45.641Z",
  ),
  Story(
    id: "story-tTLlR-7pSTsOEIEV",
    name: "reviewer",
    description: "test",
    photoUrl:
        "https://story-api.dicoding.dev/images/stories/photos-1701526701528_0_YSqvfc.jpg",
    createdAt: "2023-12-02T14:18:21.530Z",
  ),
];
