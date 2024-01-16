class EmployeeResponse {
  int count;
  String next;
  dynamic previous;
  String msg;
  int code;
  List<EmployeeModel> data;

  EmployeeResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.msg,
    required this.code,
    required this.data,
  });

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) {
    return EmployeeResponse(
      count: json['count'] ?? 0,
      next: json['next'] ?? "",
      previous: json['previous'],
      msg: json['msg'] ?? "",
      code: json['code'] ?? 0,
      data: List<EmployeeModel>.from(
        (json['data'] as List<dynamic>).map(
              (employee) => EmployeeModel.fromJson(employee),
        ),
      ),
    );
  }
}

class EmployeeModel {
  int id;
  String empCode;
  String firstName;
  String? lastName;
  String? nickname;
  String formatName;
  String photo;
  String fullName;
  String? devicePassword;
  String? cardNo;
  DepartmentModel department;

  EmployeeModel({
    required this.id,
    required this.empCode,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.formatName,
    required this.photo,
    required this.fullName,
    required this.devicePassword,
    required this.cardNo,
    required this.department,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] ?? 0,
      empCode: json['emp_code'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'],
      nickname: json['nickname'],
      formatName: json['format_name'] ?? "",
      photo: json['photo'] ?? "",
      fullName: json['full_name'] ?? "",
      devicePassword: json['device_password'],
      cardNo: json['card_no'],
      department: DepartmentModel.fromJson(json['department']),
    );
  }
}

class DepartmentModel {
  int id;
  String deptCode;
  String deptName;

  DepartmentModel({
    required this.id,
    required this.deptCode,
    required this.deptName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] ?? 0,
      deptCode: json['dept_code'] ?? "",
      deptName: json['dept_name'] ?? "",
    );
  }
}
