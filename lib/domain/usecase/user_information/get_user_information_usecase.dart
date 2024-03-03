import 'package:boilerplate/domain/entity/user_information/user_information.dart';
import 'package:boilerplate/domain/repository/user_information/user_information_repository.dart';

import '../../../core/domain/usecase/use_case.dart';

class GetUserInformationUseCase extends UseCase<UserInformation, void> {
  final UserInformationRepository _userInformationRepository;

  GetUserInformationUseCase(this._userInformationRepository);

  @override
  Future<UserInformation> call({required params}) {
    return _userInformationRepository.getUserInformation();
  }
}
