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
#import "GDQuestionView.h"
#import "GDLaunchReadyView.h"
#import "GDQuestionScrollView.h"
#import "GDOrgAnimationView.h"
#import "GDPGChooseViewController.h"
#import "GDAnswerFinishViewController.h"

@interface GDLaunchQuestionController ()<UIScrollViewDelegate,GDLaunchReadyViewDelegate>

@property (nonatomic, strong) GDQuestionScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *pages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *backButton;

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
    [backButton setImage:[UIImage imageNamed:@"nav_back_blue"] forState:0];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:backButton];
    self.backButton = backButton;

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView *view = [self.view viewWithTag:666];
    if (view) {
        [view removeFromSuperview];
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
    
}

- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSMutableArray *)pages{
    if (_pages == nil) {
        _pages = [NSMutableArray array];
      
        __weak typeof(self) weakSelf = self;
        GDLaunchReadyView *readyView = [[GDLaunchReadyView alloc] initWithFrame:self.view.frame];
        readyView.finishBlock = ^(NSInteger index) {
            [weakSelf animationFinish:index];
        };
        GDFirstQuestionListModel *model = [GDFirstQuestionListModel new];
        model.type = GDReadyType;
        [_pages addObject:readyView];

        for (GDFirstQuestionListModel*model in [GDLunchManager sharedManager].suveryList) {
            
            GDQuestionView *view = [[GDQuestionView alloc] initWithFrame:self.view.frame listModel:model];
            view.isAnswer = NO;
            view.finishBlock = ^(NSInteger index) {
                [weakSelf animationFinish:index];
            };
            [_pages addObject:view];
        }

    }
    
    return _pages;
}

- (void)animationFinish:(NSInteger)index{
    GDOrgAnimationView *view = [GDOrgAnimationView sharedView];
    [view removeFromSuperview];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [view animationStart:index completion:^(BOOL finished) {
        
        if (finished) {
            if ([GDLunchManager sharedManager].suveryList.count>self.pageControl.currentPage) {
                [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*(index), 0) animated:YES];
            }else{//题做完了
                GDBaseNavigationController *nav = [[GDBaseNavigationController alloc] initWithRootViewController:[GDAnswerFinishViewController new]];
                [self presentViewController:nav animated:YES completion:^{
                    [GDOrgAnimationView destory];
                }];
            }
            
        }
    }];
}

- (GDQuestionScrollView *)scrollView{
    
    if (_scrollView == nil) {
        _scrollView = [[GDQuestionScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*self.pages.count, SCREEN_HEIGHT);
        _scrollView.showsHorizontalScrollIndicator = NO;
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
    
    GDLaunchReadyView *readyView = self.pages.firstObject;
    readyView.delegate = self;
    [self.scrollView addSubview:readyView];
}

- (UIView *)hh_transitionAnimationView{

    return self.view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    if (scrollView.contentOffset.x>0) {//禁止左滑
//        [scrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y) animated:NO];
//
//    }
    [self scrollViewDidEndScroll:scrollView];
}


- (void)scrollViewDidEndScroll:(UIScrollView *)scrollView{
    
    GDQuestionBaseView *currQuesView = self.pages[self.pageControl.currentPage];
    if (!currQuesView.isAnswer&&(scrollView.contentOffset.x>SCREEN_WIDTH*self.pageControl.currentPage)) {
        [scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*self.pageControl.currentPage, 0) animated:NO];
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX/SCREEN_WIDTH;
    self.pageControl.currentPage = index;
    GDQuestionBaseView *quesView = self.pages[index];
    quesView.frame = CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    if (![scrollView.subviews containsObject:quesView]) {
        [scrollView addSubview:quesView];

    }


}


#pragma mark - GDLaunchReadyViewDelegate
- (void)readyClickedEvent:(BOOL)isAnimation{
    
    self.backButton.hidden = YES;
    [self animationFinish:1];
}

@end
