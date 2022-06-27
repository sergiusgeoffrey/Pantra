class StringObj {
  String data;

  StringObj({required this.data});

  factory StringObj.fromJson(Map<String, dynamic> json) {
    return StringObj(
      data: json['data'],
    );
  }
}
