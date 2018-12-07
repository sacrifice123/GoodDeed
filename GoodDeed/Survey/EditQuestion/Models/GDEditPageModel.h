//
//  GDEditPageModel.h
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyDefine.h"
#import "GDEditImageViewModel.h"
#import "GDEditQuestionViewModel.h"
#import "GDEditTextViewModel.h"
#import "GDEditToolViewModel.h"
#import "GDEditSlidingScaleViewModel.h"
#import "GDEditBoundRangeViewModel.h"
#import "GDEditRankIndexViewModel.h"
#import "GDEditRankEmptyViewModel.h"



@interface GDEditPageModel : NSObject

@property (nonatomic, readonly) GDSurveyEditType type;
@property (strong, nonatomic, readonly) GDEditImageViewModel *imageModel;

- (instancetype)initWithType:(GDSurveyEditType)type withImage:(BOOL)image;

// 数据源
- (NSInteger)numberOfItems;
- (GDEditBaseViewModel *)itemAtIndex:(NSInteger)index;

// 增加选项
- (void)addOption;
// 删除选项
- (void)removeOption:(GDEditBaseViewModel *)option;

// 更新问卷图片
- (void)updateIncludeImage:(UIImage *)image;

//+ (NSDictionary *)
- (void)updateDeleteEnabelOfItems:(BOOL)deleteEnabel addOption:(GDEditBaseViewModel *)item;
@end
