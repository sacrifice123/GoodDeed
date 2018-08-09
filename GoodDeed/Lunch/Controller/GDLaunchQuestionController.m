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
#import "GDLaunchReadyView.h"
#import "GDLunchManager.h"

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
        
        for (int i=0; i<[GDLunchManager sharedManager].suveryList.count; i++) {
            GDQuestionBaseView *view;
            if (i==0) {
                view = [[GDLaunchReadyView alloc] initWithFrame:self.view.frame];
            }else{
                view = [GDQuestionBaseView new];
            }
            view.type = i;
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


- (void)setUpSubViews{
    for (GDQuestionBaseView *view in self.pages) {
        [_scrollView addSubview:view];
        view.frame = CGRectMake(view.type*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        if (view.type>0) {
            if (view.type%2) {
                view.backgroundColor = [UIColor redColor];
            }else{
                view.backgroundColor = [UIColor blueColor];
                
            }
        }
    }
    
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

@end
