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

@interface GDLaunchQuestionController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pages;
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


- (NSMutableArray *)pages{
    if (_pages == nil) {
        _pages = [NSMutableArray array];
        
        GDQuestionBaseView *readyView = [[GDLaunchReadyView alloc] initWithFrame:self.view.frame];
        GDFirstQuestionListModel *model = [GDFirstQuestionListModel new];
        model.type = GDReadyType;
        [_pages addObject:readyView];
       // [_pages addObjectsFromArray:[GDLunchManager sharedManager].suveryList];
        for (GDFirstQuestionListModel*obj in [GDLunchManager sharedManager].suveryList) {
            
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
    
    UIPageControl *pc = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 19, 5, 5)];
    pc.center = CGPointMake(self.view.center.x, pc.center.y);
    pc.numberOfPages = self.pages.count;
    pc.currentPage = 0;
    pc.pageIndicatorTintColor = [UIColor colorWithHexString:@"#AAAAAA"];
    pc.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#555555"];
    [self.view addSubview:pc];

    
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
    GDQuestionBaseView *quesView = self.pages[index];
    [scrollView addSubview:quesView];
}

- (GDQuestionBaseView *)createSurveyView:(GDSurveyType)type{
    
    GDQuestionBaseView *surveyView;
    switch (type) {
        case 0:{
            
        }
            
            break;
        case 1:{
            
        }
            
            break;
        case 2:{
            
        }
            
            break;
        case 3:{
            
        }
            
            break;
        case 4:{
            
        }
            
            break;
        case 5:{
            
        }
            
            break;
        case 6:{
            
        }
            
            break;
        case 7:{
            
        }
            
            break;

        default:
            surveyView = [[GDQuestionBaseView alloc] init];
            break;
    }
    
    return surveyView;
}

@end
