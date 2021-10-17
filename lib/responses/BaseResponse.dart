/// Defines a response structure for async results.
///
/// bool [success] defines if response succeeded or not.
/// dynamic [value] is response data on success or error message on fail.
class BaseResponse {
  bool success;
  dynamic value;

  BaseResponse({this.success, this.value});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json["success"],
      value: json["value"],
    );
  }

  @override
  String toString() {
    return 'BaseResponse{success: $success, value: $value}';
  }
}
