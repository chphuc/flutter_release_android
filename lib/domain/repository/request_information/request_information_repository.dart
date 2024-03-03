import 'dart:async';

import 'package:boilerplate/domain/entity/request_information/request_information.dart';

abstract class RequestInformationRepository {
  Future<RequestInformation> getRequestInformation(int idRequest);
}
