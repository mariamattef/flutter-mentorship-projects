class ErrorModel {
  final int? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    String message = jsonData["message"] ?? "Unknown error";
    if (jsonData.containsKey('errors')) {
      final errors = jsonData['errors'] as Map<String, dynamic>;
      final errorMessages = errors.entries
          .map((entry) => '${entry.key}: ${(entry.value as List).join(', ')}')
          .join('\n');
      if (errorMessages.isNotEmpty) {
        message = errorMessages;
      }
    }
    return ErrorModel(errorMessage: message, status: jsonData["status"]);
  }
}
