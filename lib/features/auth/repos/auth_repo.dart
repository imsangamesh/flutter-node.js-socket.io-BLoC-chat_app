import 'package:chat_app/core/constants/constants.dart';
import 'package:chat_app/core/errors/failure.dart';
import 'package:chat_app/core/services/typedefs.dart';
import 'package:chat_app/features/auth/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hive/hive.dart';

class AuthRepo {
  AuthRepo({required HiveInterface hive}) : _hive = hive;
  final HiveInterface _hive;

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `GETTERS`

  Box<dynamic> get appBox => _hive.box(BoxKeys.app);

  Box<UserModel> get usersBox => _hive.box<UserModel>(BoxKeys.allUsers);

  UserModel? get user {
    final userIndex = appBox.get(BoxKeys.userIndex) as int?;
    return userIndex == null ? null : usersBox.getAt(userIndex);
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `SIGN UP`
  FutureVoid signUp(UserModel userModel) async {
    try {
      await usersBox.add(userModel);
      await _storeUserIndex(usersBox.length - 1);
      return right(null);
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `SIGN IN`
  FutureVoid signIn(String email, String password) async {
    try {
      var isUserExists = false;

      // Check if user exists
      for (final user in usersBox.values) {
        if (user.email == email) {
          isUserExists = true;
          break;
        }
      }

      if (!isUserExists) {
        return left(const ApiFailure('User does not exist, please SignUp!'));
      }

      // Check if credentials are valid
      for (var i = 0; i < usersBox.values.length; i++) {
        final user = usersBox.values.toList()[i];

        if (user.email == email && user.password == password) {
          await _storeUserIndex(i);
          return right(null);
        }
      }

      return left(const ApiFailure('Invalid credentials'));
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `SIGN OUT`
  FutureVoid signOut() async {
    try {
      await appBox.put(BoxKeys.userIndex, null);
      return right(null);
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - - - -  `EDIT USER`
  FutureVoid editUser(UserModel editedUser) async {
    try {
      final userIndex = appBox.get(BoxKeys.userIndex) as int;
      await usersBox.putAt(userIndex, editedUser);
      return right(null);
    } catch (e) {
      return left(ApiFailure(e.toString()));
    }
  }

  ///

  Future<void> _storeUserIndex(int index) async {
    await appBox.put(BoxKeys.userIndex, index);
  }
}
