import 'package:ds_fact/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ds_fact/features/auth/data/models/user_model.dart';
import 'package:ds_fact/features/auth/domain/entities/user.dart';
import 'package:ds_fact/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepositoryImpl(this._remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    final userModel = await _remoteDataSource.login(email, password);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    // Implement logout logic
  }

  @override
  Future<User?> getCurrentUser() async {
    // Implement get current user logic
    return null;
  }
}
