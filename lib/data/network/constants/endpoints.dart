class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://localhost:44372/api";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  //login
  static const String login =
      baseUrl + "/MobileAuthentication/NormalAuthenticate";

  static const String getStatusBarRequest =
      baseUrl + "/ProcessRequest/GetProcessRequestNumber";

  static const String getRequests =
      baseUrl + "/ProcessRequest/GetProcessRequestListFilter";

  static const String getProcessingSteps =
      baseUrl + "/ProcessStep/GetProcessStepNameList";

  static const String getRequestDepartments = baseUrl + "/Unit/GetUnitNameList";

  static const String getRequestTypes =
      baseUrl + "/RequestType/GetRequestTypeNameList";

  static const String getRequestStatuses =
      baseUrl + "/Status/GetStatusNameList";

  static const String getRequestInformation =
      baseUrl + "/ProcessRequest/GetProcessRequestById";

  static const String getUserInformation =
      "/services/app/Profile/GetCurrentUserProfileForEdit";
}
