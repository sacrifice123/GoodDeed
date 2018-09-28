//
//  GDHomeViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeViewController.h"
#import "GDPreviewViewController.h"

@interface GDHomeViewController ()<SCAdViewDelegate,GDOperationDelegate>

@property (nonatomic, strong) SCAdView *adView;
@property (nonatomic, strong) UIView *transitionView;
@property (nonatomic, strong) UIView *helpView;
@property (nonatomic, strong) NSMutableArray *homeArray;
@property (nonatomic, strong) NSMutableArray *teamArray;
@property (nonatomic, strong) NSMutableArray *surveyArray;

@end

@implementation GDHomeViewController

//横向滑动的数据源
- (NSMutableArray *)homeArray{
    
    if (_homeArray == nil) {
        _homeArray = [[NSMutableArray alloc] init];
        [_homeArray addObject:@""];
        [_homeArray addObject:@""];

    }
    return _homeArray;
}

- (NSMutableArray *)teamArray{
    
    if (_teamArray == nil) {
        _teamArray = [[NSMutableArray alloc] init];
        [_teamArray addObject:@""];

    }

    return _teamArray;
}

- (NSMutableArray *)surveyArray{
    
    if (_surveyArray == nil) {
        _surveyArray = [[NSMutableArray alloc] init];
        [_surveyArray addObject:@""];
        [_surveyArray addObject:@""];
        [_surveyArray addObject:@""];
        [_surveyArray addObject:@""];

    }

    return _surveyArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // [self setleftItem];
    [self showAdHorizontally];
    [GDHomeManager getUserInfoWithCompletionBlock:^(BOOL result) {
        
        if (result) {
            [self reloadDataWithType:GDHomeType];
        }
        
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

//反馈与帮助页面
- (void)showHelpView{
    [self hideItem:YES];
    self.adView.hidden = YES;
    self.helpView.hidden = NO;
    if (self.helpView&&[self.view.subviews containsObject:self.helpView]) {
        return;
    }
    self.helpView = [UIView new];
    self.helpView.tag = 1000;
    [self.view addSubview:self.helpView];
    [self.helpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    UIButton *mail = [[UIButton alloc] init];
    mail.tag = 100;
    [mail setBackgroundImage:[UIImage imageNamed:@"help_mail"] forState:0];
    [mail addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.helpView addSubview:mail];
    [mail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-84);
        make.width.equalTo(@125);
        make.height.equalTo(@125);
    }];

    UIButton *phone = [[UIButton alloc] init];
    phone.tag = 101;
    [phone setBackgroundImage:[UIImage imageNamed:@"help_phone"] forState:0];
    [phone addTarget:self action:@selector(helpButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.helpView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(84);
        make.width.equalTo(@125);
        make.height.equalTo(@125);
    }];

    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont fontWithName:@"PingFangSC-Light" size:24];
    label.text = @"需要帮助？\n想要联系我们？";
    [self.helpView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(mail.mas_top).offset(-50);
    }];
    
}

- (void)showAdHorizontally{
   
    [self hideItem:NO];
    self.helpView.hidden = YES;
    self.adView.hidden = NO;
    if (self.adView&&[self.view.subviews containsObject:self.adView]) {
        return;
    }
    [self createHorizontallyView];
}

//
- (void)createHorizontallyView{
    
    __weak typeof(self) weakSelf = self;
    SCAdView *adView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = weakSelf.surveyArray;
        builder.viewFrame = (CGRect){0,44,SCREEN_WIDTH,SCREEN_HEIGHT-54};
        builder.adItemSize = (CGSize){SCREEN_WIDTH-Item_Space*2,SCREEN_HEIGHT-54};
        builder.allowedInfinite = NO;
        builder.minimumLineSpacing = Item_Space*0.5;
        builder.secondaryItemMinAlpha = 0.6;
        builder.threeDimensionalScale = 0;
        
    }];
    adView.type = GDHomeSurveyType;
    adView.tag = 1001;
    adView.backgroundColor = [UIColor clearColor];
    adView.dataArray = self.surveyArray;
    adView.delegate = self;
    _adView = adView;
    [self.view addSubview:adView];
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
    }];

}

- (void)reloadDataWithType:(GDHomeCellType)type{
    self.adView.type = type;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if (type == GDHomeType) {
        array = self.homeArray;
    }else if (type == GDHomeSurveyType) {
        array = self.surveyArray;
    }else if (type == GDHomeTeamType||type == GDHomeTeamFinishType) {
        array = self.teamArray;
    }
    [self.adView reloadWithDataArray:array];
}

#pragma mark -delegate
- (void)sc_didClickAd:(id)adModel{
    if ([adModel isKindOfClass:[HeroModel class]]) {
        NSLog(@"%@",((HeroModel*)adModel).introduction);
    }
}

- (void)sc_scrollToIndex:(NSInteger)index{
    if (index == 8) {
        return;
    }
    NSLog(@"sc_scrollToIndex-->%ld",index);
}

- (void)helpButtonClicked:(UIButton *)button{
    
    
}

#pragma mark GDOperationDelegate
- (void)gotoPreVc:(UIView *)view{
    self.transitionView = view;
    [self.navigationController hh_pushScaleViewController:[GDPreviewViewController new]];
}

- (UIView *)hh_transitionAnimationView{
    
    return self.transitionView;
}


@end
