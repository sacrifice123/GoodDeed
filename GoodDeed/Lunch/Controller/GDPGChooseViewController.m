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
    GDPGChooseView *view = [[GDPGChooseView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:view];
    
}



@end
