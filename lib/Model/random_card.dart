// ignore_for_file: prefer_collection_literals

class RandomCard {
  String? type;
  String? nameShort;
  String? name;
  String? value;
  int? valueInt;
  String? meaningUp;
  String? meaningRev;
  String? desc;

  RandomCard(
      {this.type,
      this.nameShort,
      this.name,
      this.value,
      this.valueInt,
      this.meaningUp,
      this.meaningRev,
      this.desc});

  RandomCard.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    nameShort = json['name_short'];
    name = json['name'];
    value = json['value'];
    valueInt = json['value_int'];
    meaningUp = json['meaning_up'];
    meaningRev = json['meaning_rev'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = type;
    data['name_short'] = nameShort;
    data['name'] = name;
    data['value'] = value;
    data['value_int'] = valueInt;
    data['meaning_up'] = meaningUp;
    data['meaning_rev'] = meaningRev;
    data['desc'] = desc;
    return data;
  }
}
