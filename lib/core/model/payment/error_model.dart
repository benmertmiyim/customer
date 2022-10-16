class Error {
  Error({
    required this.status,
    required this.errorCode,
    required this.errorMessage,
    required this.locale,
    required this.systemTime,
  });

  final String status;
  final String errorCode;
  final String errorMessage;
  final String locale;
  final int systemTime;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    status: json["status"],
    errorCode: json["errorCode"],
    errorMessage: json["errorMessage"],
    locale: json["locale"],
    systemTime: json["systemTime"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "errorCode": errorCode,
    "errorMessage": errorMessage,
    "locale": locale,
    "systemTime": systemTime,
  };

  @override
  String toString() {
    return 'Error{status: $status, errorCode: $errorCode, errorMessage: $errorMessage, locale: $locale, systemTime: $systemTime}';
  }
}
