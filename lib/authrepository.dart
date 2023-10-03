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

  static Future<bool> setNewPass(String pass) async {
    print('Setting pass');
    await Future.delayed(const Duration(seconds: 4));
    print('pass setting Successful');
    return true;
  }
}
