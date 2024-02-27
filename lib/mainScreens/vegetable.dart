class Vegetable {
  String name;
  String url;
  Vegetable({required this.name, required this.url});

  static Vegetable fromJSON(Map<String, dynamic> map) {
    return Vegetable(name: map['name'], url: map['photo']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "Name $name URL $url";
  }
}
