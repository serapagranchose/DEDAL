class Filter {
  Filter({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Filter.fromJson(Map<String, Object?> json) => Filter(
        id: json['id']?.toString(),
        name: json['name']?.toString(),
      );
}
