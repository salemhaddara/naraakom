class authrepository {
  Future<void> login() async {
    print('attempt login');
    await Future.delayed(const Duration(seconds: 3));
    print('login Succeful');
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
}
