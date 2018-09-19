//
//  GDEditTextViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditTextViewModel.h"

@implementation GDEditTextViewModel

+ (GDEditTextViewModel *)chooseOneViewModelWithSortIndex:(NSInteger)index
                                            deleteEnabel:(BOOL)deleteEnabel

{
    GDEditTextViewModel *model = [[GDEditTextViewModel alloc] init];
    model.type = GDSurveyTypeChooseOne;
    model.sortIndex = index;
    model.deleteEnabel = deleteEnabel;
    model.kCellReuseId = kChooseOneAnswerCell;
    model.placeholder = [NSString stringWithFormat:@"选项%ld", index + 1];
    model.cellDefaultHeight = 71.f;
    return model;
}

+ (GDEditTextViewModel *)chooseMultipViewModelWithSortIndex:(NSInteger)index
                                               deleteEnabel:(BOOL)deleteEnabel
{
    GDEditTextViewModel *model = [[GDEditTextViewModel alloc] init];
    model.type = GDSurveyTypeChooseMultiple;
    model.sortIndex = index;
    model.deleteEnabel = deleteEnabel;
    model.kCellReuseId = kChooseMultipleAnswerCell;
    model.placeholder = [NSString stringWithFormat:@"选项%ld", index + 1];
    model.cellDefaultHeight = 36.f;
    return model;
}

// Stack Range
+ (GDEditTextViewModel *)stackRangeViewModel:(NSInteger)index
                                deleteEnabel:(BOOL)deleteEnabel
{
    GDEditTextViewModel *model = [[GDEditTextViewModel alloc] init];
    model.type = GDSurveyTypeStackRank;
    model.deleteEnabel = deleteEnabel;
    model.kCellReuseId = kStackRankAnswerCell;
    model.cellDefaultHeight = 33.5;
    return model;
}

// Text
+ (GDEditTextViewModel *)textViewModel
{
    GDEditTextViewModel *model = [[GDEditTextViewModel alloc] init];
    model.type = GDSurveyTypeText;
    model.kCellReuseId = kTextAnswerCell;
    model.cellDefaultHeight = 77.f;
    return model;
}

@end
