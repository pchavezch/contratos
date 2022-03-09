class OptionParm {
  String _option;

  String get option => _option;

  set option(String option) {
    _option = option;
  }

  String _userid;

  String get userid => _userid;

  set userid(String userid) {
    _userid = userid;
  }

  String _value1;

  String get value1 => _value1;

  set value1(String value1) {
    _value1 = value1;
  }

  OptionParm(this._option, this._userid, this._value1);
}

class Option {
  final int optionid;
  final String description;
  final String descriptionshort;
  const Option(
      {required this.optionid,
      required this.description,
      required this.descriptionshort});
  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      optionid: json['optionid'],
      description: json['description'],
      descriptionshort: json['descriptionshort'],
    );
  }
}

class ResultOptions {
  final int result;
  final Option data;
  final String message;

  const ResultOptions(
      {required this.result, required this.data, required this.message});
  factory ResultOptions.fromJson(Map<String, dynamic> json) {
    return ResultOptions(
        result: json['result'],
        data: Option.fromJson(json['data'][0]),
        message: json['message']);
  }
}
