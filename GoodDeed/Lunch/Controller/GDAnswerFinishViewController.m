//
//  GDAnswerFinishViewController.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/23.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDAnswerFinishViewController.h"
#import "GDLoginViewController.h"

@interface GDAnswerFinishViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation GDAnswerFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBarHidden = YES;
    self.contentLabel.text = @"请创建一个账号，这样我们就可以把\n善款捐给红十字会";
    //NSMutableArray *array = [GDLunchManager sharedManager].writeReqVoList;
    
}

- (IBAction)create:(id)sender {
    
    GDLoginViewController *login = [GDLoginViewController new];
    login.isUser = NO;
    [self.navigationController pushViewController:login animated:YES];
}

@end
