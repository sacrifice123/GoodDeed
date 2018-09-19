//
//  GDEditToolViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditToolViewModel.h"

@implementation GDEditToolViewModel

+ (GDEditToolViewModel *)chooseOneViewModel
{
    GDEditToolViewModel *model = [[GDEditToolViewModel alloc] init];
    model.type = GDSurveyTypeChooseOne;
    model.kCellReuseId = kChooseOneAddOptionCell;
    model.cellDefaultHeight = 71.f;
    return model;
}

+ (GDEditToolViewModel *)chooseMultipViewModel
{
    GDEditToolViewModel *model = [[GDEditToolViewModel alloc] init];
    model.type = GDSurveyTypeChooseMultiple;
    model.kCellReuseId = kChooseMultipleAddOptionCell;
    model.cellDefaultHeight = 36.f;
    return model;
}

+ (GDEditToolViewModel *)stackRankViewModel
{
    GDEditToolViewModel *model = [[GDEditToolViewModel alloc] init];
    model.type = GDSurveyTypeStackRank;
    model.kCellReuseId = kStackRankAddOptionCell;
    model.cellDefaultHeight = 33.5;
    return model;
}

+ (GDEditToolViewModel *)imageVoteViewModel
{
    GDEditToolViewModel *model = [[GDEditToolViewModel alloc] init];
    model.type = GDSurveyTypeImageVote;
    model.kCellReuseId = kImageVoteAddOptionCell;
    return model;
}

@end
