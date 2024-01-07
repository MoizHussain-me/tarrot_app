class ReadersModel {
  String? id;
  String? readersName;
  String? readersImg;
  String? readersFees;
  String? readersExperience;
  String? readersExpert;
  String? readersLanguage;
  String? readersPayment;
  String? readersRating;
  String? readersStatus;

  ReadersModel({
    this.id,
    required this.readersName,
    required this.readersImg,
    required this.readersFees,
    required this.readersExperience,
    required this.readersExpert,
    required this.readersLanguage,
    required this.readersPayment,
    required this.readersRating,
    required this.readersStatus,
  });

  toJson() {
    return {
      "readersId": id,
      "readersName": readersName,
      "readersExperience": readersExperience,
      "readersStatus": readersStatus,
      "readersImg": readersImg,
      "readersFees": readersFees,
      "readersExpert": readersExpert,
      "readersLanguage": readersLanguage,
      "readersRating": readersRating,
      "readersPayment": readersPayment,
    };
  }

  ReadersModel.fromJson(Map<String, dynamic> json) {
    readersExpert = json['readerExpert'];
    readersFees = json['readerFees'];
    readersImg = json['readerImg'];
    readersLanguage = json['readerLanguage'];
    readersName = json['readerName'];
    readersPayment = json['readerPayment'];
    readersRating = json['readerRating'];
    readersExperience = json['readersExperience'];
    readersStatus = json['status'];
    id = json['id'];
  }
}
