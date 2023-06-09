/// Data Model
class Person {
  int? id;
  String name;
  bool gender;
  DateTime birthTime;
  List<String>? tags;
  DateTime? createdTime;
  DateTime? modifiedTime;
  int? userId;
  String? location;
  String? notes;

  Person(
      {this.id,
      required this.name,
      required this.gender,
      required this.birthTime,
      this.tags,
      this.createdTime,
      this.modifiedTime,
      this.userId,
      this.location,
      this.notes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'birthTime': birthTime,
      'location': location,
      'createdTime': createdTime,
      'modifiedTime': modifiedTime,
      'userId': userId,
      'tags': tags,
      'notes': notes,
    };
  }

  // make function for toMap

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'],
      name: map['name'],
      gender: map['gender'],
      birthTime: DateTime.parse(map['birthTime']),
      createdTime: map.containsKey('createTime')
          ? DateTime.parse(map['createTime'] ?? "1970-01-01")
          : DateTime(1970),
      modifiedTime: map.containsKey('modifiedTime')
          ? DateTime.parse(map['modifiedTime'] ?? "1970-01-01")
          : DateTime(1970),
      userId: map.containsKey('userId') ? (map['userId'] as int?) : null,
      location: map['location'],
      notes: map['notes'],
    );
  }

  // Make a function for toJson
  Map<String, dynamic> toJson() => toMap();

  // Make a function for fromJson
  factory Person.fromJson(Map<String, dynamic> json) => Person.fromMap(json);

  @override
  List<Object?> get props => [id, name, gender, location, userId, tags];
}
