import 'package:ds_fact/features/auth/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    // Simulating network delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (email == 'test@test.com' && password == '123456') {
      return const UserModel(
        id: '1',
        email: 'test@test.com',
        name: 'Test User',
        photoUrl: null,
      );
    } else {
      throw Exception('Credenciales inválidas');
    }
  }
}
