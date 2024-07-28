import 'dart:convert';

class Task {
  final int id;
  final Attributes attributes;
  Task({
    required this.id,
    required this.attributes,
  });

  Task copyWith({
    int? id,
    Attributes? attributes,
  }) {
    return Task(
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'attributes': attributes.toMap(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'].toInt() as int,
      attributes: Attributes.fromMap(map['attributes'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Task(id: $id, attributes: $attributes)';

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.attributes == attributes;
  }

  @override
  int get hashCode => id.hashCode ^ attributes.hashCode;
}

class Attributes {
  final String Title;
  final String Description;
  final bool Completed;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  Attributes({
    required this.Title,
    required this.Description,
    required this.Completed,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  Attributes copyWith({
    String? Title,
    String? Description,
    bool? Completed,
    String? createdAt,
    String? updatedAt,
    String? publishedAt,
  }) {
    return Attributes(
      Title: Title ?? this.Title,
      Description: Description ?? this.Description,
      Completed: Completed ?? this.Completed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Title': Title,
      'Description': Description,
      'Completed': Completed,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'publishedAt': publishedAt,
    };
  }

  factory Attributes.fromMap(Map<String, dynamic> map) {
    return Attributes(
      Title: map['Title'] as String,
      Description: map['Description'] as String,
      Completed: map['Completed'] as bool,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      publishedAt: map['publishedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attributes.fromJson(String source) => Attributes.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attributes(Title: $Title, Description: $Description, Completed: $Completed, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt)';
  }

  @override
  bool operator ==(covariant Attributes other) {
    if (identical(this, other)) return true;
  
    return 
      other.Title == Title &&
      other.Description == Description &&
      other.Completed == Completed &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt &&
      other.publishedAt == publishedAt;
  }

  @override
  int get hashCode {
    return Title.hashCode ^
      Description.hashCode ^
      Completed.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      publishedAt.hashCode;
  }
}