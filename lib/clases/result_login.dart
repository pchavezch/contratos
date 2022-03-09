// ignore_for_file: non_constant_identifier_names

class User {
  final int Usersystemid;
  final String Name;
  final String Password;
  final String Identitynumber;
  final String Ballot;
  final String Title;
  final String Address;
  final String Telephone;
  final String Mail;
  final String Movil;
  final int Cityid;
  final int Customerid;
  final String Username;
  final String Lastname;
  final int Profileid;
  final int Profiletype;
  final int Totalaccess;
  final bool Status;
  final int Createuserid;
  final int Updateuserid;
  final int Cityagencyid;
  final bool CityRestricted;

  const User(
      {required this.Usersystemid,
      required this.Name,
      required this.Password,
      required this.Identitynumber,
      required this.Ballot,
      required this.Title,
      required this.Address,
      required this.Telephone,
      required this.Mail,
      required this.Movil,
      required this.Cityid,
      required this.Customerid,
      required this.Username,
      required this.Lastname,
      required this.Profileid,
      required this.Profiletype,
      required this.Totalaccess,
      required this.Status,
      required this.Createuserid,
      required this.Updateuserid,
      required this.Cityagencyid,
      required this.CityRestricted});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        Usersystemid: json['Usersystemid'],
        Name: json['Name'],
        Password: json['Password'],
        Identitynumber: json['Identitynumber'],
        Ballot: json['Ballot'],
        Title: json['Title'],
        Address: json['Address'],
        Telephone: json['Telephone'],
        Mail: json['Mail'],
        Movil: json['Movil'],
        Cityid: json['Cityid'],
        Customerid: json['Customerid'],
        Username: json['Username'],
        Lastname: json['Lastname'],
        Profileid: json['Profileid'],
        Profiletype: json['Profiletype'],
        Totalaccess: json['Totalaccess'],
        Status: json['Status'],
        Createuserid: json['Createuserid'],
        Updateuserid: json['Updateuserid'],
        Cityagencyid: json['Cityagencyid'],
        CityRestricted: json['CityRestricted']);
  }
}

class ResultLogin {
  final int result;
  final User data;
  final String message;

  const ResultLogin(
      {required this.result, required this.data, required this.message});
  factory ResultLogin.fromJson(Map<String, dynamic> json) {
    return ResultLogin(
        result: json['result'],
        data: User.fromJson(json['data']),
        message: json['message']);
  }
}
