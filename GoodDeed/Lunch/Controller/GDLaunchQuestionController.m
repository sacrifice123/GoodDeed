//
//  GDLaunchQuestionController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLaunchQuestionController.h"
#import "GDLaunchReadyView.h"
#import "GDQuestionBaseView.h"
#import "GDLunchManager.h"
#import "GDLaunchReadyView.h"
//7大问题页面
#import "GDSingleSelQuestionView.h"
#import "GDMoreSelQuestionView.h"
#import "GDSlideQuestionView.h"
#import "GDQuantifyQuestionView.h"
#import "GDSortQuestionView.h"
#import "GDImageSelQuestionView.h"
#import "GDWriteQuestionView.h"
#import "GDPGChooseViewController.h"

@interface GDLaunchQuestionController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation GDLaunchQuestionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self setUpSubViews];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 18, 25)];
    [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:0];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:backButton];

}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
- (NSMutableArray *)pages{
    if (_pages == nil) {
        _pages = [NSMutableArray array];
        
        GDQuestionBaseView *readyView = [[GDLaunchReadyView alloc] initWithFrame:self.view.frame];
        GDFirstQuestionListModel *model = [GDFirstQuestionListModel new];
        model.type = GDReadyType;
        [_pages addObject:readyView];

        for (GDFirstQuestionListModel*obj in [GDLunchManager sharedManager].suveryList) {
            GDQuestionBaseView *view = [self createSurveyView:obj.type];
            view.model = obj;
            [_pages addObject:view];
        }

    }
    
    return _pages;
}


- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.pages.count, SCREEN_HEIGHT);
    }
    return _scrollView;
}

- (void)setUpChildVc{
    
    
}

- (void)setUpSubViews{
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 19, 5, 5)];
    pageControl.center = CGPointMake(self.view.center.x, pageControl.center.y);
    pageControl.numberOfPages = self.pages.count;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#AAAAAA"];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    [self.scrollView addSubview:self.pages.firstObject];
}

- (UIView *)hh_transitionAnimationView{

    return self.view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if (scrollView.contentOffset.x>0) {//禁止左滑
//        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y) animated:NO];
//
//    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/SCREEN_WIDTH;
    self.pageControl.currentPage = index;
    GDQuestionBaseView *quesView = self.pages[index];
    quesView.frame = CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (![scrollView.subviews containsObject:quesView]) {
        [scrollView addSubview:quesView];

    }
}

//GDReadyType = 0,    //准备
//GDSingleType,       //单选题
//GDMultipleType,     //多选题
//GDSlideType,        //滑动题
//GDQuantitativeType, //定量题
//GDSortType,         //排序题
//GDSelectType,       //勾选图片题
//GDWriteType         //填写题

- (GDQuestionBaseView *)createSurveyView:(GDSurveyType)type{
    
    GDQuestionBaseView *surveyView;
    switch (type) {
        case 0:{
            surveyView = [[GDLaunchReadyView alloc] init];

        }
            
            break;
        case 1:{
            surveyView = [[GDSingleSelQuestionView alloc] init];

        }
            
            break;
        case 2:{
            surveyView = [[GDMoreSelQuestionView alloc] init];

        }
            
            break;
        case 3:{
            surveyView = [[GDSlideQuestionView alloc] init];

        }
            
            break;
        case 4:{
            surveyView = [[GDQuantifyQuestionView alloc] init];
        }
            
            break;
        case 5:{
            surveyView = [[GDSortQuestionView alloc] init];
        }
            
            break;
        case 6:{
            surveyView = [[GDImageSelQuestionView alloc] init];
        }
            
            break;
        case 7:{
            surveyView = [[GDWriteQuestionView alloc] init];
        }
            
            break;

        default:
            surveyView = [[GDQuestionBaseView alloc] init];
            break;
    }
    return surveyView;
}

@end
