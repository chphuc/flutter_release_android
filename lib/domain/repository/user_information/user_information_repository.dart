import 'dart:async';

import 'package:boilerplate/domain/entity/user_information/user_information.dart';

abstract class UserInformationRepository {
  Future<UserInformation> getUserInformation();
}
