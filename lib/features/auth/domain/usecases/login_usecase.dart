import 'package:ds_fact/features/auth/domain/entities/user.dart';
import 'package:ds_fact/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User> call(String email, String password) {
    return _repository.login(email, password);
  }
}
