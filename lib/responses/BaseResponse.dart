/// Defines a response structure for async results.
///
/// bool [success] defines if response succeeded or not.
/// dynamic [value] is response data on success or error message on fail.
class BaseResponse {
  bool success;
  dynamic? value;
  String? errorMessage;

  BaseResponse({required this.success, this.value, this.errorMessage});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      success: json["success"],
      value: json["value"],
      errorMessage: json["errorMessage"],
    );
  }

  @override
  String toString() {
    return 'BaseResponse{success: $success, value: $value, errorMessage: $errorMessage}';
  }
}
