//
//  GDEditBaseViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

NSString *const kCommonQuestionCell = @"kCommonQuestionCell";

NSString * const kChooseOneAnswerCell = @"kChooseOneAnswerCell";
NSString * const kChooseOneAddOptionCell = @"kChooseOneAddOptionCell";

NSString * const kChooseMultipleAnswerCell = @"kChooseMultipleAnswerCell";
NSString * const kChooseMultipleAddOptionCell = @"kChooseMultipleAddOptionCell";

NSString * const kSlidingScaleAnswerCell = @"kSlidingScaleAnswerCell";

NSString * const kBoundedRangeAnswerCell = @"kBoundedRangeAnswerCell";
NSString * const kBoundedRangeAddOptionCell = @"kBoundedRangeAddOptionCell";

NSString * const kStackRankIndexCell = @"kStackRankIndexCell";
NSString * const kStackRankEmptyCell = @"kStackRankEmptyCell";
NSString * const kStackRankAnswerCell = @"kStackRankAnswerCell";
NSString * const kStackRankAddOptionCell = @"kStackRankAddOptionCell";

NSString * const kImageVoteQuestionCell = @"kImageVoteQuestionCell";
NSString * const kImageVoteAnswerCell = @"kImageVoteAnswerCell";
NSString * const kImageVoteAddOptionCell = @"kImageVoteAddOptionCell";

NSString * const kTextAnswerCell = @"kTextAnswerCell";

@implementation GDEditBaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _sectionFooterHeight = 10.f;
    }
    return self;
}


- (CGFloat)cellHeight
{
    if (_cellHeight < self.cellDefaultHeight) {
        return self.cellDefaultHeight;
    } else {
        return _cellHeight;
    }
}


@end
