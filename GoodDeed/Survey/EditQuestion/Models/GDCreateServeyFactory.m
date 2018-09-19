//
//  GDCreateServeyManager.m
//  GoodDeed
//
//  Created by HK on 2018/8/27.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDCreateServeyFactory.h"

@implementation GDCreateServeyFactory

+ (UIViewController *)surveyEditerViewControllerWithType:(GDSurveyEditType)type withImage:(BOOL)image
{
    
    UIViewController *serveyEditerVC = nil;
    
    GDEditPageModel *pageModel = [[GDEditPageModel alloc] initWithType:type withImage:image];
    switch (type) {
        case GDSurveyTypeChooseOne:
        case GDSurveyTypeChooseMultiple:
        case GDSurveyTypeSlidingScale:
        case GDSurveyTypeBoundedRange:
        case GDSurveyTypeStackRank:
        case GDSurveyTypeText: {
            serveyEditerVC = [[GDEditTableViewController alloc] initWithPageModel:pageModel];
        } break;
        case GDSurveyTypeImageVote: {
            serveyEditerVC = [[GDEditCollectionViewController alloc] initWithPageModel:pageModel];
        } break;
            
        default:
            break;
    }

    
    return serveyEditerVC;
}

@end
