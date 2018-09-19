//
//  GDCreateServeyManager.h
//  GoodDeed
//
//  Created by HK on 2018/8/27.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDEditPageModel.h"
#import "GDEditTableViewController.h"
#import "GDEditCollectionViewController.h"


@interface GDCreateServeyFactory : NSObject

+ (UIViewController *)surveyEditerViewControllerWithType:(GDSurveyEditType)type withImage:(BOOL)image;

@end
