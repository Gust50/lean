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
#import <AVOSCloudSNS.h>
@interface ViewController ()
@property(nonatomic,strong)UITextField *inputUsername;
@property(nonatomic,strong)UITextField *inputPassword;
@property(nonatomic,strong)UIButton *login;
@property(nonatomic,strong)UIButton *signup;
@property(nonatomic,strong)UIButton *forgetPassword;
@property(nonatomic,strong)UIButton *code;
@property(nonatomic,strong)UIButton *fastLogin;
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
-(UIButton *)code{
    if (!_code) {
        _code = [UIButton new];
        [_code setTitle:@"验证码" forState:UIControlStateNormal];
        [_code setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_code addTarget:self action:@selector(codeAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _code;
}
- (void)codeAC{
    NSLog(@"获取验证码");
    [AVUser requestLoginSmsCode:self.inputUsername.text withBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"获取验证码成功");
        }else{
            NSLog(@"获取验证码错误");
        }
    }];
}
- (UIButton *)fastLogin{
    if (!_fastLogin) {
        _fastLogin = [UIButton new];
        [_fastLogin setTitle:@"一键登录" forState:UIControlStateNormal];
        [_fastLogin setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_fastLogin addTarget:self action:@selector(fastLoginAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fastLogin;
}
- (void)fastLoginAC{
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSSinaWeibo withAppKey:@"" andAppSecret:@"" andRedirectURI:@""];
    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }else{
//            NSString *accessToken = object[@"access_token"];
//            NSString *username = object[@"username"];
//            NSString *avatar = object[@"avatar"];
//            NSDictionary *rawUser = object[@"raw-user"];
        }
    }toPlatform:AVOSCloudSNSSinaWeibo];
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
    [self.view addSubview:self.code];
    [self.view addSubview:self.fastLogin];
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
    [_code mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputPassword.mas_right).offset(5);
        make.width.equalTo(@60);
        make.centerY.equalTo(_inputPassword);
        make.height.equalTo(_inputPassword);
    }];
    [_fastLogin mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.view).offset(-80);
        make.right.equalTo(weakSelf.view).offset(-30);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
}
- (void)loginAC{
    NSString *username = self.inputUsername.text;
    NSString *password = self.inputPassword.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:username forKey:@"username"];
    [defaults setObject:password forKey:@"password"];
    if (username && password) {

        [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                NSLog(@"登录失败");
            }else{
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
