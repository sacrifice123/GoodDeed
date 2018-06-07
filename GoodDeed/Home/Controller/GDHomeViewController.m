//
//  GDHomeViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeViewController.h"

@interface GDHomeViewController ()

@end

@implementation GDHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    [self setleftItem];
    
}

- (void)setleftItem{
    
    UIButton *leftItem = [[UIButton alloc] init];
    leftItem.backgroundColor = [UIColor redColor];
    [self.view addSubview:leftItem];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(30);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [leftItem addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
 
}

- (void)leftBarButtonItemClick{

    [GDHelper showDrawer];
}


@end
