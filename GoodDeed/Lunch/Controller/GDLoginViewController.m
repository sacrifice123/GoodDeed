//
//  GDLoginViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLoginViewController.h"
#import "GDResetPwdController.h"
#import "GDOpenNotiViewController.h"

@interface GDLoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UITextField *mailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *textView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;

@end

@implementation GDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    
    self.pwdView.layer.borderWidth = 1;
    self.pwdView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;

    if (self.isUser) {
        self.titleLabel.text = @"通过邮箱登录：";
        [self.loginButton setTitle:@"登录" forState:0];
        [self.checkButton setTitle:@"忘记密码？" forState:0];
        [self.backButton setTitle:@"取消" forState:0];

    }else{
        [self.backButton setTitle:@"返回" forState:0];
        [self.backButton setImage:[UIImage imageNamed:@"nav_back"] forState:0];
    }
    
}

//登录与注册
- (IBAction)loginAndRegister:(id)sender {
    
    [self.view endEditing:YES];
    if (self.isUser) {//登陆
        [GDLunchManager loginWithMail:self.mailTextField.text password:self.pwdTextField.text type:@1 token:@"" completionBlock:^(BOOL result) {
            if (result) {
                [self dismissViewControllerAnimated:YES completion:^{
                    GDWindow.rootViewController = [GDHomeManager getRootController:YES];
                    
                }];
                
            }
            
        }];

    }else{//注册
        [GDLunchManager registerWithMail:self.mailTextField.text password:self.pwdTextField.text type:@1 completionBlock:^(BOOL result) {
            
            if (result) {
                [self dismissViewControllerAnimated:YES completion:^{
                    GDWindow.rootViewController = [[GDBaseNavigationController alloc] initWithRootViewController:[GDOpenNotiViewController new]];
                    
                }];

            }
            
        }];
        
    }
    
}

//退出页面
- (IBAction)close:(id)sender {
    
    if (self.isUser) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//忘记密码/登录
- (IBAction)forgetPwdOrLogin:(id)sender {
    
    if (self.isUser) {//忘记密码
        [self showAlertController];
    }else{//登陆
        
    }
}


- (void)showAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"重置您的密码" message:@"请输入您的邮箱地址" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"邮箱";
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"重置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.textField&&self.textField.text&&self.textField.text.length>0) {
            GDResetPwdController *resetVc = [GDResetPwdController new];
            resetVc.mailText = self.textField.text;
           [self presentViewController:resetVc animated:YES completion:nil];
        }else{
             [GDWindow showWithString:@"请输入邮箱"];
        }
        
    }];

    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    self.textField = alert.textFields.lastObject;
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

@end
