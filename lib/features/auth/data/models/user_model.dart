import 'package:ds_fact/features/auth/domain/entities/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
      
  // Helper to convert to Entity if needed, though UserModel is already compatible structure-wise
  // In Clean Arch strict mode, we might map it. Here we can treat UserModel as User implementation
}

extension UserModelX on UserModel {
  User toEntity() => User(
        id: id,
        email: email,
        name: name,
        photoUrl: photoUrl,
      );
}
