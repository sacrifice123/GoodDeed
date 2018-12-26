//
//  GDEditViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/13.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDEditViewController.h"
#import "GDEditCoverViewController.h"
#import "GDEditTableViewController.h"
#import "GDChooseQuestionTypeViewController.h"

#import "GDEditBottomView.h"
#import <Masonry.h>

#import "GDEditSurveyManager.h"
#import "GDFirstSurveyModel.h"

@interface GDEditViewController ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) GDEditBottomView *bottomView;
@property (strong, nonatomic) GDEditSurveyManager *manager;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation GDEditViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

+ (GDEditViewController *)editViewController
{
    return [[GDEditViewController alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupViews];
    [self.manager initializePages];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//GDSurveyTypeCoverInfo,       // 封面信息
//GDSurveyTypeChooseType,      // 选择类型
//GDSurveyTypeEditChooseType,  // 编辑选择类型
//GDSurveyTypeChooseOne,       // 单选
//GDSurveyTypeChooseMultiple,  // 多选
//GDSurveyTypeSlidingScale,    // 滑动
//GDSurveyTypeBoundedRange,    // 定量
//GDSurveyTypeStackRank,       // 排序
//GDSurveyTypeImageVote,       // 勾选图片
//GDSurveyTypeText,            //  填写

- (GDSurveyType)getQuestionType:(GDSurveyEditType)type{
    
    GDSurveyType surveyType;
    switch (type) {
        case GDSurveyTypeChooseOne : {       // 单选
            surveyType = GDSingleType;
        } break;
        case GDSurveyTypeChooseMultiple : {  // 多选
            surveyType = GDMultipleType;
        } break;
        case GDSurveyTypeSlidingScale : {    // 滑动
            surveyType = GDSlideType;
        } break;
        case GDSurveyTypeBoundedRange : {    // 定量
            surveyType = GDQuantitativeType;
        } break;
        case GDSurveyTypeStackRank : {       // 排序
            surveyType = GDSortType;
        } break;
        case GDSurveyTypeImageVote : {       // 勾选图片
            surveyType = GDSelectType;
        } break;
        case GDSurveyTypeText : {            //  填写
            surveyType = GDWriteType;
        } break;
        default:
            surveyType = 0;
            break;
    }

    return surveyType;
}


#pragma mark - Action
//保存草稿
- (void)saveAction
{
    [GDDataBaseManager  createSurveyTable];

    GDFirstSurveyModel *surveyModel = [[GDFirstSurveyModel alloc] init];
    surveyModel.surveyId = [self getNowTimestamp];
    NSArray *pages = self.manager.pages;
    NSMutableArray <GDFirstQuestionListModel *>*questionList = [[NSMutableArray alloc] init];
    for (UIViewController<GDSurveyPageProtocol> *page in pages) {
        if ([page conformsToProtocol:@protocol(GDSurveyPageProtocol)]) {
           // GDEditTableViewController *page = (GDEditTableViewController *)obj;
            switch ( [page surveyType]) {
                case GDSurveyTypeCoverInfo:{//问卷封面信息
                    NSDictionary *data = [page surveyContent];
                    surveyModel.imgUrl = [data objectForKey:@"image"];
                    surveyModel.name = [data objectForKey:@"title"];
                }
                    break;
                case GDSurveyTypeChooseType:{
                    
                }
                    break;
                case GDSurveyTypeEditChooseType:{//这里进来的次数就是问卷里问题的个数
                    //问卷具体问题内容,遍历创建问卷的所有问题在这个类型里
                    //一次问卷只能创建一个，但是问题可以创建多个
                    GDEditPageModel *pageModel = [page surveyContent];
                    GDFirstQuestionListModel *listModel = [GDFirstQuestionListModel new];//问题model
                    listModel.questionId = [self getNowTimestamp];
                    listModel.surveyId = surveyModel.surveyId;
                    NSMutableArray <GDOptionModel*>*optionVoList = [[NSMutableArray alloc] init];
                    listModel.type = [self getQuestionType:pageModel.type];
                    for (int i=0; i<pageModel.numberOfItems; i++) {//此处相当于遍历一个问题（遍历页面每个cell）
                        GDEditBaseViewModel *model = [pageModel itemAtIndex:i];
                        if ([model isKindOfClass:[GDEditQuestionViewModel class]]) {//问题的标题
                            GDEditQuestionViewModel *quesModel = (GDEditQuestionViewModel *)model;
                            listModel.questionName = quesModel.text;
                            
                        }else if ([model isKindOfClass:[GDEditTextViewModel class]]){//问题的选项
                            
                            GDEditTextViewModel *textModel = (GDEditTextViewModel *)model;
                            GDOptionModel *optionModel = [GDOptionModel new];
                            optionModel.optionId = [self getNowTimestamp];
                            optionModel.questionId = listModel.questionId;
                            optionModel.optionName = textModel.text;
                            [optionVoList addObject:optionModel];
                        }
                        
                    }//----问卷里一个问题遍历结束
                    
                    listModel.firstOptionList = optionVoList;//问题里的选项
                    [questionList addObject:listModel];


                }
                    break;
                case GDSurveyTypeChooseOne:{//单选
                    
                }
                    break;
                case GDSurveyTypeChooseMultiple:{
                    
                }
                    break;

                    
                default:
                    break;
            }
        }
        
    }//----一个问卷保存结束 
    surveyModel.firstQuestionList = questionList;
    [GDDataBaseManager saveSurvey:surveyModel];
    
//    NSMutableArray *array = [GDDataBaseManager survey_queryAll];
    
//    [[GDLunchManager sharedManager].suveryList removeAllObjects];
//    [GDLunchManager sharedManager].surveyModel = surveyModel;

    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:GDSurveySaveNoti object:surveyModel];
    }];
}

//下一步
- (void)nextAction
{
    
    __weak typeof(self) weak_self = self;
    NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    if(index<self.manager.pages.count-1){
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(index+1), 0) animated:YES];
        return;
    }
    if (index < self.manager.pages.count) {
        UIViewController <GDSurveyPageProtocol>*page = (UIViewController <GDSurveyPageProtocol>*)[self.manager.pages objectAtIndex:index];
        if ([page conformsToProtocol:@protocol(GDSurveyPageProtocol)]) {
            [page nextStep:^(UIViewController<GDSurveyPageProtocol> *surveyVC) {//协议方法在其他地方实现，这里调用
                switch ([surveyVC surveyType]) {
                    case GDSurveyTypeCoverInfo:
                    case GDSurveyTypeEditChooseType:
                    {
                        [weak_self.manager createChoosePage];
                    } break;
                    default:
                        break;
                }
            }];
        }
    } else {
        
    }
}

- (void)manageAction
{
    
}

#pragma mark - Private
- (void)setupViews
{

    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 19, 5, 5)];
    pageControl.center = CGPointMake(self.view.center.x, pageControl.center.y);
    pageControl.numberOfPages = self.manager.pages.count;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#AAAAAA"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    self.pageControl.hidden = (self.manager.pages.count<2);
 
}

- (void)updatePagesWithIndex:(NSInteger)index
{
    UIView *preView = nil;
    for (UIViewController *vc in self.manager.pages) {
        [self.scrollView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            if (preView) {
                make.left.equalTo(preView.mas_right);
            } else {
                make.left.equalTo(self.scrollView);
            }
            
            make.width.equalTo(self.view);
            make.height.equalTo(self.scrollView);
            
            if (vc == [self.manager.pages lastObject]) {
                make.right.equalTo(self.scrollView);
            }
            
        }];
        
        preView = vc.view;
    }
    
    CGPoint offset = CGPointMake(CGRectGetWidth(self.scrollView.bounds) * index, 0);
    [self.scrollView setContentOffset:offset animated:YES];
    self.pageControl.hidden = (self.manager.pages.count<2);
    self.pageControl.numberOfPages = self.manager.pages.count;
}



#pragma mark - Setter, Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
}


- (GDEditBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [GDEditBottomView editBottomView];
        _bottomView.tag = 100;
        __weak typeof(self) weak_self = self;
        _bottomView.saveEvent = ^{//保存到草稿
            [weak_self saveAction];
        };
        
        _bottomView.nextEvent = ^{//下一步
            [weak_self nextAction];
        };
        
        _bottomView.manageEvent = ^{
            [weak_self manageAction];
        };
    }
    return _bottomView;
}

- (GDEditSurveyManager *)manager
{
    if (!_manager) {
        __weak typeof(self) weak_self = self;
        _manager = [[GDEditSurveyManager alloc] initWithUpdatePages:^(NSInteger index) {
            [weak_self updatePagesWithIndex:index];
        }];
    }
    return _manager;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/SCREEN_WIDTH;
    self.pageControl.currentPage = index;
    
}

- (NSString *)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%lli", (long long)([datenow timeIntervalSince1970]*1000*1000)];
    NSLog(@"timeSp===%@",timeSp);

    return timeSp;
}

@end
