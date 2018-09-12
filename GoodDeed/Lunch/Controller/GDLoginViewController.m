//
//  GDLoginViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLoginViewController.h"

@interface GDLoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation GDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isUser) {
        self.titleLabel.text = @"通过邮箱登录：";
        [self.loginButton setTitle:@"登录" forState:0];
        [self.checkButton setTitle:@"忘记密码？" forState:0];

    }
    
}

//登录与注册
- (IBAction)loginAndRegister:(id)sender {
    
    [GDLunchManager loginWithMail:self.mailTextField.text password:self.pwdTextField.text type:@1 token:@"" completionBlock:^(BOOL result) {
        
    }];
    
}

//退出页面
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
