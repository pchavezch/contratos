class Contract {
  final int contractid;
  final String applicant;
  final String customer;
  final String customerid;
  final String vehicle;
  final String path;
  const Contract(
      {required this.contractid,
      required this.applicant,
      required this.customer,
      required this.customerid,
      required this.vehicle,
      required this.path});
  factory Contract.fromJson(Map<String, dynamic> json) {
    return Contract(
      contractid: json['contractid'],
      applicant: json['applicant'],
      customer: json['customer'],
      customerid: json['customerid'],
      vehicle: json['vehicle'],
      path: json['path'],
    );
  }
}

class ResultContract {
  final int result;
  final Contract data;
  final String message;

  const ResultContract(
      {required this.result, required this.data, required this.message});
  factory ResultContract.fromJson(Map<String, dynamic> json) {
    return ResultContract(
        result: json['result'],
        data: Contract.fromJson(json['data']),
        message: json['message']);
  }
}
