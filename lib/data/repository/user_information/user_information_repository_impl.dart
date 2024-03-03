import 'package:boilerplate/data/network/apis/user_information/user_information_api.dart';
import 'package:boilerplate/domain/entity/user_information/user_information.dart';
import 'package:boilerplate/domain/repository/user_information/user_information_repository.dart';

class UserInformationRepositoryImpl extends UserInformationRepository {
  final UserInformationApi _userInformationApi;

  UserInformationRepositoryImpl(this._userInformationApi);

  @override
  Future<UserInformation> getUserInformation() async {
    return await _userInformationApi.getUserInformation().then((userInformation) {
      return userInformation;
    }).catchError((error) => throw error);
  }
}
