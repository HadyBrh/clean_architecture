class SignUpErrorResponse {
  String message;
  Map<String, String> errors;

  SignUpErrorResponse({required this.message, required this.errors});

  factory SignUpErrorResponse.fromJson(Map<String, dynamic> json) {
    Map<String, String> errorMap = {};
    json['errors'].forEach((key, value) {
      errorMap[key] = value as String;
    });

    return SignUpErrorResponse(
      message: json['message'] as String,
      errors: errorMap,
    );
  }
}