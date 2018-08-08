//
//  GDLaunchViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLaunchViewController.h"
#import "GDKnowViewController.h"
#import "GDLoginViewController.h"
#import "GDLunchManager.h"

@interface GDLaunchViewController ()
@property (strong, nonatomic) IBOutlet UIView *startView;

@end

@implementation GDLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];

}


- (IBAction)startHere:(id)sender {

    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.startView];
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

//去答题首页
- (IBAction)Go:(id)sender {
    [GDLunchManager getFirstSurveyListWithCompletionBlock:^(NSArray *list) {
        
        GDKnowViewController *vc = [[GDKnowViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];

    
}

//登录
- (IBAction)login:(id)sender {
    
    GDLoginViewController *loginVc = [GDLoginViewController new];
    loginVc.isUser = YES;
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

@end
