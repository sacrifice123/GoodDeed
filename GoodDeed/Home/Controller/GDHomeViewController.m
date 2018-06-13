//
//  GDHomeViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDHomeViewController.h"
#import "GDPreviewViewController.h"
#import "SCAdView.h"

@interface GDHomeViewController ()<SCAdViewDelegate,GDOperationDelegate>

@property (nonatomic, strong) SCAdView *adView;
@property (nonatomic, strong) UIView *transitionView;

@end

@implementation GDHomeViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
   // [self setleftItem];
    [self showAdHorizontally];
    
}



- (void)showAdHorizontally{
    NSArray *testArray =@[@"刘备",@"李白",@"嬴政",@"韩信",@"韩信"];
    //模拟服务器获取到的数据
    NSMutableArray *arrayFromService  = [NSMutableArray array];
    for (NSString *text in testArray) {
        HeroModel *hero = [HeroModel new];
        hero.imageName = text;
        hero.introduction = [NSString stringWithFormat:@"我是王者农药的:---->%@",text];
        [arrayFromService addObject:hero];
    }
    
    SCAdView *adView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = arrayFromService;
        builder.viewFrame = (CGRect){0,44,SCREEN_WIDTH,SCREEN_HEIGHT-54};
        builder.adItemSize = (CGSize){SCREEN_WIDTH-Item_Space*2,SCREEN_HEIGHT-54};
        builder.allowedInfinite = NO;
        builder.minimumLineSpacing = Item_Space*0.5;
        builder.secondaryItemMinAlpha = 0.6;
        builder.threeDimensionalScale = 0;
        builder.itemCellNibName = @"GDSurveyCell";
    }];
    adView.backgroundColor = [UIColor clearColor];
    adView.dataArray = arrayFromService;
    adView.delegate = self;
    _adView = adView;
    [self.view addSubview:adView];
    [_adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(44);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
}

#pragma mark -delegate
- (void)sc_didClickAd:(id)adModel{
    NSLog(@"sc_didClickAd-->%@",adModel);
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

#pragma mark GDOperationDelegate
- (void)gotoPreVc:(UIView *)view{
//    [UIView animateWithDuration:1 animations:^{
//        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
//    }];
//    [self presentViewController:[GDPreviewViewController new] animated:YES completion:nil];
    self.transitionView = view;
    [self.navigationController hh_pushScaleViewController:[GDPreviewViewController new]];
}

- (UIView *)hh_transitionAnimationView{
    
    return self.transitionView;
}
@end
