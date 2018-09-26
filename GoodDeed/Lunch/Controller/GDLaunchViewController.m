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
#import "GDGuideTestView.h"

@interface GDLaunchViewController ()
@property (strong, nonatomic) IBOutlet UIView *startView;

@end

@implementation GDLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];

}

//从这里开始
- (IBAction)startHere:(id)sender {

//    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.view addSubview:self.startView];
//    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    [self showTestView];
}

//去答题首页
- (IBAction)Go:(id)sender {
    [GDLunchManager getFirstSurveyListWithCompletionBlock:^(NSArray *list) {
        
        GDKnowViewController *vc = [[GDKnowViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];

    }];

    
}


- (void)showTestView{
    
    GDGuideTestView *testView = [[NSBundle mainBundle] loadNibNamed:@"GDGuideTestView" owner:nil options:nil].lastObject;
    [self.view addSubview:testView];
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

//登录
- (IBAction)login:(id)sender {
    
    GDLoginViewController *loginVc = [GDLoginViewController new];
    loginVc.isUser = YES;
    [self presentViewController:loginVc animated:YES completion:nil];
    
}

@end
