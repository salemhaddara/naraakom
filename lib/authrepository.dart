import 'package:naraakom/core/utils/Models/Schedule.dart';
import 'package:naraakom/core/utils/Models/User.dart';

class authrepository {
  Future<String> login() async {
    print('attempt login');
    await Future.delayed(const Duration(seconds: 3));
    print('login Succeful');
    String UserId = 'id3';
    return UserId;
  }

  Future<void> signUp() async {
    print('attempt Sign Up');
    await Future.delayed(const Duration(seconds: 3));
    print('Sign Up Successful');
  }

  Future<String> sendVerificationCode(String phoneNumber) async {
    print('Sending Verification code');
    await Future.delayed(const Duration(seconds: 4));
    print('Sending Successful');
    return '2345';
  }

  Future<User> setNewPass(String pass, String userId) async {
    //THE user id is getten from the otp verification so we can modify the user from it
    print('Setting pass');
    await Future.delayed(const Duration(seconds: 4));
    print('pass setting Successful');
    return User(
        username: 'username',
        id: 'id',
        email: 'email',
        password: 'password',
        notifications: []);
  }
}
