//
//  GDBaseViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseViewController.h"
#import "GDEditViewController.h"
@interface GDBaseViewController ()

@property (nonatomic, strong) UIButton *rightItem;
@property (nonatomic, strong) UIImageView *titleImgView;

@end

@implementation GDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];

    [self setUpView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%@--WillAppear",NSStringFromClass([self class]));
    
}

- (void)setUpView{
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_bg.pic"]];
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setUpItems];
}


- (void)setUpItems{
    
    UIButton *leftItem = [[UIButton alloc] init];
    [leftItem setBackgroundImage:[UIImage imageNamed:@"home_menu"] forState:0];
    [self.view addSubview:leftItem];
    [leftItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(Item_Space);
        make.top.equalTo(self.view).offset(15);
        make.width.equalTo(@19);
        make.height.equalTo(@15);
    }];
    [leftItem addTarget:self action:@selector(leftBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightItem = [[UIButton alloc] init];
    [rightItem setBackgroundImage:[UIImage imageNamed:@"home_edit"] forState:0];
    [self.view addSubview:rightItem];
    [rightItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-Item_Space+3);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
        make.centerY.equalTo(leftItem.mas_centerY);
    }];
    [rightItem addTarget:self action:@selector(rightBarButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.rightItem = rightItem;
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_title"]];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(leftItem.mas_centerY);

    }];
    self.titleImgView = imgView;
    

}

- (void)hideItem:(BOOL)isHide{
    
    self.rightItem.hidden = isHide;
    self.titleImgView.hidden = isHide;
}

- (void)rightBarButtonItemClick{
    
    [self presentViewController:[GDEditViewController new] animated:YES completion:nil];
}

- (void)leftBarButtonItemClick{
    
    [GDHomeManager showDrawer];
}

@end
