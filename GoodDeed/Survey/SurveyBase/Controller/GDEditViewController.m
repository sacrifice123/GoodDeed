//
//  GDEditViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/13.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDEditViewController.h"
#import "GDEditCoverViewController.h"
#import "GDChooseQuestionTypeViewController.h"

#import "GDEditBottomView.h"
#import <Masonry.h>

#import "GDEditSurveyManager.h"


@interface GDEditViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) GDEditBottomView *bottomView;
@property (strong, nonatomic) GDEditSurveyManager *manager;

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


#pragma mark - Action
- (void)saveAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{ }];
    
}
- (void)nextAction
{
    
    __weak typeof(self) weak_self = self;
    NSInteger index = self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    if (index < self.manager.pages.count) {
        UIViewController <GDSurveyPageProtocol>*page = (UIViewController <GDSurveyPageProtocol>*)[self.manager.pages objectAtIndex:index];
        if ([page conformsToProtocol:@protocol(GDSurveyPageProtocol)]) {
            [page nextStep:^(UIViewController<GDSurveyPageProtocol> *surveyVC) {
                switch ([surveyVC surveyType]) {
                    case GDSurveyTypeCoverInfo: {
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
}



#pragma mark - Setter, Getter
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = YES;
    }
    return _scrollView;
}


- (GDEditBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [GDEditBottomView editBottomView];
        __weak typeof(self) weak_self = self;
        _bottomView.saveEvent = ^{
            [weak_self saveAction];
        };
        
        _bottomView.nextEvent = ^{
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


@end
