//
//  GDAnswerFinishViewController.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/23.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDAnswerFinishViewController.h"

@interface GDAnswerFinishViewController ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation GDAnswerFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.contentLabel.text = @"请创建一个账号，这样我们就可以把\n善款捐给红十字会";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
