//
//  MainViewController.m
//  lean
//
//  Created by kobe on 16/12/23.
//  Copyright © 2016年 Gust50. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
@interface MainViewController ()
@property(nonatomic,strong)UIButton *logout;
@property(nonatomic,strong)UIButton *addButton;
@end

@implementation MainViewController
- (UIButton *)logout{
    if (!_logout) {
        _logout = [UIButton new];
        [_logout setTitle:@"退出" forState:UIControlStateNormal];
        [_logout setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_logout addTarget:self action:@selector(logoutAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logout;
}
- (void)logoutAC{
    [AVUser logOut];
    ViewController *v = [ViewController new];
    [self presentViewController:v animated:YES completion:nil];
}
- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton new];
        [_addButton setTitle:@"增加商品" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addAC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
- (void)addAC{
    NSString *title = @"商品";
    NSNumber *price = [NSNumber numberWithInt:10];
    NSString *description = @"商品的测试";
    UIImageView *icon = [UIImageView new];
    icon.image = [UIImage imageNamed:@"矢量智能对象2"];
    NSData *data = UIImagePNGRepresentation(icon.image);
    AVFile *file = [AVFile fileWithData:data];
    
    AVUser *currentUser = [AVUser currentUser];
    
    AVObject *product = [AVObject objectWithClassName:@"Product"];
    [product setObject:title forKey:@"title"];
    [product setObject:price forKey:@"price"];
    
    // owner 字段为 Pointer 类型，指向 _User 表
    [product setObject:currentUser forKey:@"owner"];
    // image 字段为 File 类型
    [product setObject:file forKey:@"image"];
    [product setObject:description forKey:@"description"];
    [product saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"保存新物品成功");
    
        } else {
            NSLog(@"保存新物品出错 %@", error);
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)initUI{
    [self.view addSubview:self.logout];
    [self.view addSubview:self.addButton];
    [self updateViewConstraints];
}
- (void)updateViewConstraints{
    [super updateViewConstraints];
    WS(weakSelf);
    [_logout mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@40);
        make.right.equalTo(@-20);
        make.top.equalTo(@50);
        make.height.equalTo(@30);
    }];
    [_addButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@80);
        make.top.equalTo(@200);
        make.height.equalTo(@30);
    }];
}
@end
