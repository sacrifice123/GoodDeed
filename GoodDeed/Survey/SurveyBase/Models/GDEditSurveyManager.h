//
//  GDEditSurveyManager.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyDefine.h"
#import "GDEditToolViewModel.h"
#import "GDEditQuestionViewModel.h"
#import "GDEditImageViewModel.h"
#import "GDEditTextViewModel.h"

typedef void (^UpdatePagesBlock) (NSInteger index);


@interface GDEditSurveyManager : NSObject


#pragma mark - Common
// 标题
@property (copy, nonatomic) NSString *title;
// 封面
@property (strong, nonatomic) UIImage *coverImage;

@property (strong, nonatomic, readonly) NSArray <UIViewController *>*pages;

@property (nonatomic) NSInteger pageIndex;

- (instancetype)initWithUpdatePages:(UpdatePagesBlock)updatePages;
- (void)initializePages;

- (void)createChoosePage;

- (void)createPageWithType:(GDSurveyEditType)type hasIncludedImage:(BOOL)hasIncludedImage;

#pragma mark - QuestionAbout

// 问题封面图
@property (strong, nonatomic) GDEditImageViewModel *questionCoverImageModel;
// 选择问卷类型
@property (nonatomic, readonly) GDSurveyEditType type;
// 文件数据
@property (strong, nonatomic, readonly) NSMutableArray *dataSource;

// 更新问卷图片
- (void)updateIncludeImage:(UIImage *)image;

// 增加选项
- (void)addOptionFinished:(dispatch_block_t)finished;

- (NSInteger)numberOfItems;
- (GDEditBaseViewModel *)itemAtIndex:(NSInteger)index;

@end
