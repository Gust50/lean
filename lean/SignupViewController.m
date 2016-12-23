//
//  SignupViewController.m
//  lean
//
//  Created by kobe on 16/12/23.
//  Copyright © 2016年 Gust50. All rights reserved.
//

#import "SignupViewController.h"
#import "MainViewController.h"
@interface SignupViewController ()
@property(nonatomic,strong)UITextField *inputUsername;
@property(nonatomic,strong)UITextField *inputPassword;
@property(nonatomic,strong)UITextField *inputEmail;
@property(nonatomic,strong)UIButton *signup;
@property(nonatomic,strong)UIButton *back;
@property(nonatomic,strong)UIButton *code;
@end

@implementation SignupViewController
- (UITextField *)inputUsername{
    if (!_inputUsername) {
        _inputUsername = [UITextField new];
        _inputUsername.placeholder = @"请输入用户名";
        _inputUsername.layer.borderWidth = 1;
        _inputUsername.layer.borderColor = [UIColor blackColor].CGColor;
        _inputUsername.layer.cornerRadius = 5;
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
    }
    return _inputPassword;
}
- (UITextField *)inputEmail{
    if (!_inputEmail) {
        _inputEmail = [UITextField new];
        _inputEmail.placeholder = @"请输入邮箱";
        _inputEmail.layer.borderWidth = 1;
        _inputEmail.layer.borderColor = [UIColor blackColor].CGColor;
        _inputEmail.layer.cornerRadius = 5;
    }
    return _inputEmail;
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
- (UIButton *)back{
    if (!_back) {
        _back = [UIButton new];
        [_back setTitle:@"返回" forState:UIControlStateNormal
         ];
        [_back setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_back addTarget:self action:@selector(backAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _back;
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
    [AVOSCloud requestSmsCodeWithPhoneNumber:self.inputUsername.text callback:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"获取验证码成功");
        }else{
            NSLog(@"获取验证码错误");
        }
    }];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.inputUsername];
    [self.view addSubview:self.inputPassword];
    [self.view addSubview:self.inputEmail];
    [self.view addSubview:self.signup];
    [self.view addSubview:self.back];
    [self.view addSubview:self.code];
    self.code.hidden = YES;
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
    [_inputEmail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inputUsername);
        make.width.equalTo(_inputUsername);
        make.top.equalTo(_inputPassword.mas_bottom).offset(15);
        make.height.equalTo(_inputUsername);
    }];
    [_signup mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_inputUsername);
        make.width.equalTo(@60);
        make.top.equalTo(_inputEmail.mas_bottom).offset(20);
        make.height.equalTo(@20);
    }];
    [_back mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(40);
        make.left.equalTo(weakSelf.view).offset(20);
        make.width.equalTo(@40);
        make.height.equalTo(@20);
    }];
    [_code mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_inputPassword.mas_right).offset(5);
        make.width.equalTo(@60);
        make.centerY.equalTo(_inputPassword);
        make.height.equalTo(_inputPassword);
    }];
}

- (void)signupAC{
        NSString *userName = self.inputUsername.text;
        NSString *password = self.inputPassword.text;
        NSString *email = self.inputEmail.text;
        if (userName && password && email) {
            AVUser *user = [AVUser user];
            user.username = userName;
            user.password = password;
            user.email = email;
            [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    NSLog(@"注册成功!!!");
                    MainViewController *mainVC = [MainViewController new];
                    [self presentViewController:mainVC animated:YES completion:nil];
                }
                else{
                    NSLog(@"注册失败 %@",error);
                }
            }];
        }
    
//    if (userName && password) {
//        AVUser *user = [AVUser user];
//        user.username = userName;
//        user.password = password;
//        [AVUser signUpOrLoginWithMobilePhoneNumberInBackground:userName smsCode:password block:^(AVUser * _Nullable user, NSError * _Nullable error) {
//            if (!error) {
//                NSLog(@"注册成功!!!");
//                MainViewController *mainVC = [MainViewController new];
//                [self presentViewController:mainVC animated:YES completion:nil];
//            }
//            else{
//                NSLog(@"注册失败 %@",error);
//            }
//        }];
//    }

}
- (void)backAC{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
