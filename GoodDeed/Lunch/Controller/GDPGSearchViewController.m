//
//  GDPGSearchViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGSearchViewController.h"
#import "GDLunchManager.h"
#import "GDPGChooseView.h"

@interface GDPGSearchViewController ()

@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UILabel *inviteLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) GDPGChooseView *searchView;

@end

@implementation GDPGSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchView = [[GDPGChooseView alloc] init];
    self.searchView.isSearch = YES;
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom).offset(20);
    }];
    [self.textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(UITextField*)textField {
    
    //搜索
    [GDLunchManager searchOrganWithName:textField.text uid:@"" completionBlock:^(NSArray *list) {
        
        self.inviteView.hidden = (list.count>0);
        if (list.count>0) {
            [self.searchView reloadWithDatas:list];
        }else{
            [self.view bringSubviewToFront:self.inviteView];
            if (textField.text.length>0) {
                self.inviteLabel.text = [NSString stringWithFormat:@"抱歉，我们暂时没有匹配到%@，是想让我们邀请该公益组织加入吗？",textField.text];

            }else{
                self.inviteView.hidden = YES;
            }
        }
        
    }];
}

//点击邀请
- (IBAction)inviteButtonClicked:(id)sender {
    
    [GDLunchManager addOrganWithName:self.textField.text uid:@"" completionBlock:^(BOOL result) {
        
        if (result) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"感谢提交!" message:[NSString stringWithFormat:@"我们已经收到了您的请求，邀请“%@”加入，我们会尽快联系.",self.textField.text] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];

        }
    }];
}


- (IBAction)searchButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:self completion:nil];

}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:self completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.textField resignFirstResponder];
}

@end
