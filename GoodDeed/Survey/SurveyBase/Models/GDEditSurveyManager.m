//
//  GDEditSurveyManager.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditSurveyManager.h"

#import "GDEditCoverViewController.h"
#import "GDChooseQuestionTypeViewController.h"
#import "GDEditTableViewController.h"
#import "GDEditCollectionViewController.h"
#import "GDCreateServeyFactory.h"

@interface GDEditSurveyManager ()

@property (strong, nonatomic) NSMutableArray *configPages;

@property (strong, nonatomic) NSMutableArray *dataSource;


@property (strong, nonatomic) UpdatePagesBlock updatePagesEvent;

@end


@implementation GDEditSurveyManager
- (instancetype)initWithUpdatePages:(UpdatePagesBlock)updatePages
{
    self = [super init];
    if (self) {
        _updatePagesEvent = updatePages;
    }
    return self;
}

#pragma mark - Pages
- (void)initializePages
{
    [self.configPages removeAllObjects];
    // 封面 标题
    GDEditCoverViewController *editCoverVC = [GDEditCoverViewController editCoverViewController] ;
    [self addPage:editCoverVC];

    
}

- (void)createChoosePage
{
    if(self.configPages){
        for (UIViewController *obj in self.configPages) {
            if([obj isKindOfClass:[GDChooseQuestionTypeViewController class]]){
                return;
            }
        }
    }
    // 选题类型
    GDChooseQuestionTypeViewController *chooseTypeVC = [[GDChooseQuestionTypeViewController alloc] init];
    [self addPage:chooseTypeVC];
    __weak typeof(self) weak_self = self;
    chooseTypeVC.chooseQuestion = ^(GDSurveyEditType type, NSInteger index) {
        [weak_self createPageWithType:type hasIncludedImage:index];
    };
}

- (void)createPageWithType:(GDSurveyEditType)type hasIncludedImage:(BOOL)hasIncludedImage
{
    UIViewController *vc = [self.configPages lastObject];
    if ([vc isKindOfClass:[GDEditListViewController class]]) {
        [self removePage:vc];
    }
    
    UIViewController *surveyVC = [GDCreateServeyFactory surveyEditerViewControllerWithType:type withImage:hasIncludedImage];
    if (surveyVC) {
        [self addPage:surveyVC];
    }
}

- (void)addPage:(UIViewController *)page
{
    [self.configPages addObject:page];
    if (self.updatePagesEvent) {
        self.updatePagesEvent([self.configPages indexOfObject:page]);
    }
}

- (void)removePage:(UIViewController *)page
{
    [self.configPages removeObject:page];
    if (self.updatePagesEvent) {
        self.updatePagesEvent(self.configPages.count - 1);
    }
}


#pragma mark - QuestionAbout
- (void)setupType:(GDSurveyEditType)type hasIncludedImage:(BOOL)hasIncludedImage
{

    
}

- (NSInteger)numberOfItems
{
    return self.dataSource.count;
}

- (GDEditBaseViewModel *)itemAtIndex:(NSInteger)index
{
    if (self.dataSource.count > index) {
        return [self.dataSource objectAtIndex:index];
    }
    return nil;
}

#pragma mark - Private
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)configPages
{
    if (!_configPages) {
        _configPages = [[NSMutableArray alloc] init];
    }
    return _configPages;
}

- (NSArray<UIViewController *> *)pages
{
    return [self.configPages copy];
}

@end
