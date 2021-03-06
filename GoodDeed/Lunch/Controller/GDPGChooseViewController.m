//
//  GDPGChooseViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGChooseViewController.h"
#import "GDPGChooseView.h"

@interface GDPGChooseViewController ()

@end

@implementation GDPGChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    GDPGChooseView *chooseView = [[GDPGChooseView alloc] initWithFrame:self.view.frame];
    chooseView.isClose = self.isClose;
    [self.view addSubview:chooseView];
    if (self.organList&&self.organList.count>0) {
        [chooseView reloadWithDatas:self.organList];
    }else{
        [GDLunchManager getOrganListWithCompletionBlock:^(NSArray *list) {
            [chooseView reloadWithDatas:list];
        }];
    }
    
}



@end
