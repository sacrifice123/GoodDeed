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
//首页
- (NSMutableArray *)homeArray{
    
    if (_homeArray == nil) {/*
                             1.是不是有card
                             2.有没有创建团队
                             3.有没有可回答的问卷
                             */
        _homeArray = [[NSMutableArray alloc] init];

    }
    if (_homeArray.count>1) {
       NSArray *array = [_homeArray sortedArrayUsingComparator:^NSComparisonResult(GDHomeModel *obj1, GDHomeModel *obj2) {
           return obj1.type>obj2.type;
        }];
        [_homeArray removeAllObjects];
        [_homeArray addObjectsFromArray:array];
    }
    return _homeArray;
}
//团队
- (NSMutableArray *)teamArray{
    
    if (_teamArray == nil) {
        _teamArray = [[NSMutableArray alloc] init];

    }

    return _teamArray;
}
//问卷
- (NSMutableArray *)surveyArray{
    
    if (_surveyArray == nil) {
        _surveyArray = [[NSMutableArray alloc] init];

    }

    return _surveyArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
   // [self setleftItem];
    [self showAdHorizontally];
    [self groupRequest];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(answerFinish:) name:GDAnswerFinishNoti object:nil];
}

- (void)groupRequest{
    
    //1.创建队列
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    //2.创建队列组
    
    dispatch_group_t group =dispatch_group_create();
    
    //3.异步函数
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        [GDHomeManager getUserInfoWithCompletionBlock:^(BOOL result) {
            
            if (result) {
                GDUserModel *model =  [GDLunchManager sharedManager].userModel;
                if (model.isCreatedGroup) {
                    GDHomeModel *model = [GDHomeModel new];
                    model.type = GDHomeTeamFinishType;//创建团队结束
                    @synchronized (self.homeArray){
                        [self.homeArray addObject:model];
                    }
                }else{
                    GDHomeModel *model = [GDHomeModel new];
                    model.type = GDHomeTeamType;//创建团队
                    @synchronized (self.homeArray){
                        [self.teamArray addObject:model];
                        
                    }
                }
            }
            NSLog(@"1----%@",[NSThread currentThread]);
            dispatch_group_leave(group);

            
        }];

        
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        //获取card
        [GDHomeManager getRegisterCardWithCompletionBlock:^(GDCardModel *model) {
            if (model) {
                GDHomeModel *homeModel = [GDHomeModel new];
                homeModel.type = GDHomeCardType;
                homeModel.cardModel = model;
                @synchronized (self.homeArray){
                    [self.homeArray addObject:homeModel];
                    
                }
            }
            NSLog(@"2----%@",[NSThread currentThread]);
            dispatch_group_leave(group);

        }];

        
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        //查询可回答的问卷
        [GDHomeManager findMySurveyTaskWithCompletionBlock:^(NSArray *array) {
            
            if (!array||(array&&array.count == 0)) {//没有可回答问卷
                GDHomeModel *model = [GDHomeModel new];
                model.type = GDHomeSuveryStatusType;
                model.isHasSurvery = NO;
                model.taskModel.status = NO;
                @synchronized (self.homeArray){
                    [self.homeArray addObject:model];
                    
                }
            }else{

                NSMutableArray *taskArray = [[NSMutableArray alloc] init];
                for (GDSurveyTaskModel *obj in array) {
                    if (!obj.status) {//有未回答完的问卷
                        [GDHomeManager getSurveyListWithSurveyId:obj.surveyId completionBlock:^(NSArray *array) {}];
                    }
                    GDHomeModel *homeModel = [GDHomeModel new];
                    homeModel.type = GDHomeSuveryStatusType;
                    homeModel.isHasSurvery = YES;
                    homeModel.taskModel = obj;
                    [taskArray addObject:homeModel];
                }
                @synchronized (self.homeArray){
                    [self.homeArray addObjectsFromArray:taskArray];
                    
                }
                

            }
            NSLog(@"3----%@",[NSThread currentThread]);
            dispatch_group_leave(group);

        }];

        
    });
    
    //拦截通知,当队列组中所有的任务都执行完毕的时候回进入到下面的方法
    
    dispatch_group_notify(group, queue, ^{
        
        NSLog(@"-------dispatch_group_notify-------");
         [self.adView reloadWithDataArray:self.homeArray];
    });
    
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

//刷新页面
- (void)reloadDataWithIndex:(NSInteger)index{

    NSMutableArray *array = [[NSMutableArray alloc] init];
    switch (index) {
        case 0:{//首页
            BOOL isFinish = NO;
            for (GDHomeModel *model in self.homeArray) {
                if (model.type==GDHomeTeamFinishType) {
                    isFinish = YES;
                    break;
                }
            }
            if (!isFinish) {
                GDUserModel *homeModel = [GDLunchManager sharedManager].userModel;
                if (homeModel.isCreatedGroup) {
                    GDHomeModel *homeModel = [GDHomeModel new];
                    homeModel.type = GDHomeTeamFinishType;
                    [self.homeArray addObject:homeModel];
                    
                }

            }
            array = self.homeArray;
        }
            break;
        case 2:{//我的团队
            
            GDUserModel *model = [GDLunchManager sharedManager].userModel;
            GDHomeCellType type = GDHomeTeamType;
            if (model.isCreatedGroup) {
                type = GDHomeTeamFinishType;
            }
            GDHomeModel *homeModel = [GDHomeModel new];
            homeModel.type = type;
            [array addObject:homeModel];
                
        }
            break;
        case 3:{//我的调查
            
        }
            
            break;
        case 4:{//反馈与帮助
        }
            break;
            
        default:
            break;
    }
    
    [self.adView reloadWithDataArray:array];
}

#pragma mark -delegate
- (void)sc_didClickAd:(id)adModel{
}

- (void)sc_scrollToIndex:(NSInteger)index{
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

//问卷回答结束
- (void)answerFinish:(NSNotification *)noti{
    
    if (noti.userInfo) {
        NSDictionary *dic = noti.userInfo;
        GDCardModel *cardModel = [dic objectForKey:@"card"];
        cardModel.isHome = YES;
        GDSurveyTaskModel *taskModel = [dic objectForKey:@"task"];
        if (cardModel) {//有card
//            GDHomeModel *model = [GDHomeModel new];
//            model.type = GDHomeCardType;
//            model.cardModel = cardModel;
            for (GDHomeModel *obj in self.homeArray) {
                if (obj.type == GDHomeSuveryStatusType&&
                    [cardModel.surveyId isEqualToString:obj.taskModel.surveyId]) {
                    obj.cardModel = cardModel;
                    obj.type = GDHomeCardType;
                    break;
                }
            }

            
        }else if (taskModel){
            for (GDHomeModel *obj in self.homeArray) {
                if (obj.type == GDHomeSuveryStatusType&&
                    [taskModel.surveyId isEqualToString:obj.taskModel.surveyId]) {
                    obj.taskModel = taskModel;
                    break;
                }
            }
        }
        [self.adView reloadWithDataArray:_homeArray];

    }
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
