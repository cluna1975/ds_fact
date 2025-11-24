import 'package:ds_fact/core/di/injection.dart';
import 'package:ds_fact/features/auth/domain/usecases/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class Login extends _$Login {
  @override
  FutureOr<void> build() {
    // Initial state is void (idle)
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final loginUseCase = getIt<LoginUseCase>();
      await loginUseCase(email, password);
    });
  }
}
