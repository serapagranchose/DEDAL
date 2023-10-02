class Filter {
  Filter({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Filter.fromJson(Map<String, Object?> json) => Filter(
        id: json['id'] != null ? json['id'].toString() : null,
        name: json['name'] != null ? json['name'].toString() : null,
      );
}
