//
//  ViewController.m
//  lean
//
//  Created by kobe on 16/12/22.
//  Copyright © 2016年 Gust50. All rights reserved.
//

#import "ViewController.h"
#import "SignupViewController.h"
#import "ForgetPasswordViewController.h"
#import "MainViewController.h"
@interface ViewController ()
@property(nonatomic,strong)UITextField *inputUsername;
@property(nonatomic,strong)UITextField *inputPassword;
@property(nonatomic,strong)UIButton *login;
@property(nonatomic,strong)UIButton *signup;
@property(nonatomic,strong)UIButton *forgetPassword;
@end

@implementation ViewController
- (UITextField *)inputUsername{
    if (!_inputUsername) {
        _inputUsername = [UITextField new];
        _inputUsername.placeholder = @"请输入用户名";
        _inputUsername.layer.borderWidth = 1;
        _inputUsername.layer.borderColor = [UIColor blackColor].CGColor;
        _inputUsername.layer.cornerRadius = 5;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
       NSString *a = [defaults objectForKey:@"username"];
        if (![a isEqualToString:@""]) {
            _inputUsername.text = a;
        }
    }
    return _inputUsername;
}
- (UITextField *)inputPassword{
    if (!_inputPassword) {
        _inputPassword = [UITextField new];
        _inputPassword.placeholder = @"请输入密码";
        _inputPassword.layer.borderWidth = 1;
        _inputPassword.layer.borderColor = [UIColor blackColor].CGColor;
        _inputPassword.layer.cornerRadius = 5;
        _inputPassword.secureTextEntry = YES;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *a =  [defaults objectForKey:@"password"];
        if (![a isEqualToString:@""]) {
            _inputPassword.text = a;
        }
    }
    return _inputPassword;
}
- (UIButton *)login{
    if (!_login) {
        _login = [UIButton new];
        [_login setTitle:@"登录" forState:UIControlStateNormal
         ];
        [_login setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_login addTarget:self action:@selector(loginAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _login;
}
- (UIButton *)signup{
    if (!_signup) {
        _signup = [UIButton new];
        [_signup setTitle:@"注册" forState:UIControlStateNormal
         ];
        [_signup setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_signup addTarget:self action:@selector(signupAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signup;
}

- (UIButton *)forgetPassword{
    if (!_forgetPassword) {
        _forgetPassword = [UIButton new];
        [_forgetPassword setTitle:@"忘记密码" forState:UIControlStateNormal
         ];
        [_forgetPassword setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_forgetPassword addTarget:self action:@selector(forgetPasswordAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.inputUsername];
    [self.view addSubview:self.inputPassword];
    [self.view addSubview:self.login];
    [self.view addSubview:self.signup];
    [self.view addSubview:self.forgetPassword];
    [self updateViewConstraints];
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    WS(weakSelf);
    [_inputUsername mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@150);
        make.top.equalTo(weakSelf.view.mas_top).offset(250);
        make.height.equalTo(@30);
    }];
    [_inputPassword mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inputUsername);
        make.width.equalTo(_inputUsername);
        make.top.equalTo(_inputUsername.mas_bottom).offset(15);
        make.height.equalTo(_inputUsername);
    }];
    [_login mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inputUsername);
        make.width.equalTo(@60);
        make.top.equalTo(_inputPassword.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    [_signup mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_login);
        make.right.equalTo(_login.mas_left).offset(-10);
        make.width.equalTo(_login);
        make.height.equalTo(_login);
    }];
    [_forgetPassword mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(_login);
        make.width.equalTo(@80);
        make.left.equalTo(_login.mas_right).offset(10);
    }];
}
- (void)loginAC{
    NSString *username = self.inputUsername.text;
    NSString *password = self.inputPassword.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    if (username && password) {
        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
            if (error) {
                NSLog(@"登录失败 %@", error);
            } else {
        
                NSLog(@"登录成功");
                MainViewController *mainVC = [MainViewController new];
                [self presentViewController:mainVC animated:YES completion:nil];
            }
        }];
    }
}

- (void)signupAC{
    SignupViewController *signupVC = [SignupViewController new];
    [self presentViewController:signupVC animated:YES completion:nil];
}
- (void)forgetPasswordAC{
    ForgetPasswordViewController *forgetPasswordVC = [ForgetPasswordViewController new];
    [self presentViewController:forgetPasswordVC animated:YES completion:nil];
}
@end
