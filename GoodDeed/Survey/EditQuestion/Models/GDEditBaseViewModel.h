//
//  GDEditBaseViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyDefine.h"

FOUNDATION_EXPORT NSString * const kCommonQuestionCell;

FOUNDATION_EXPORT NSString * const kChooseOneAnswerCell;
FOUNDATION_EXPORT NSString * const kChooseOneAddOptionCell;

FOUNDATION_EXPORT NSString * const kChooseMultipleAnswerCell;
FOUNDATION_EXPORT NSString * const kChooseMultipleAddOptionCell;

FOUNDATION_EXPORT NSString * const kSlidingScaleAnswerCell;

FOUNDATION_EXPORT NSString * const kBoundedRangeAnswerCell;
FOUNDATION_EXPORT NSString * const kBoundedRangeAddOptionCell;


FOUNDATION_EXPORT NSString * const kStackRankIndexCell;
FOUNDATION_EXPORT NSString * const kStackRankEmptyCell;
FOUNDATION_EXPORT NSString * const kStackRankAnswerCell;
FOUNDATION_EXPORT NSString * const kStackRankAddOptionCell;


FOUNDATION_EXPORT NSString * const kImageVoteQuestionCell;
FOUNDATION_EXPORT NSString * const kImageVoteAnswerCell;
FOUNDATION_EXPORT NSString * const kImageVoteAddOptionCell;


FOUNDATION_EXPORT NSString * const kTextAnswerCell;



@interface GDEditBaseViewModel : NSObject

// 类型
@property (nonatomic) GDSurveyEditType type;
@property (nonatomic) BOOL deleteEnabel;
@property (copy, nonatomic) NSString *placeholder;
@property (copy, nonatomic) NSString *kCellReuseId;
@property (nonatomic) NSInteger sortIndex;

@property (nonatomic) CGFloat cellDefaultHeight;
@property (nonatomic) CGFloat cellHeight;

@property (nonatomic) CGFloat sectionFooterHeight;

@end
