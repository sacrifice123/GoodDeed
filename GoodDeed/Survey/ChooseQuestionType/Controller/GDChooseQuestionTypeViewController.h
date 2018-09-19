//
//  GDChooseQuestionTypeViewController.h
//  GoodDeed
//
//  Created by HK on 2018/8/9.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDSurveyPageProtocol.h"
#import "GDSurveyDefine.h"

typedef void (^ChooseQuestion) (GDSurveyEditType type, NSInteger index);

@interface GDChooseQuestionTypeViewController : UIViewController <GDSurveyPageProtocol>

@property (nonatomic) ChooseQuestion chooseQuestion;

@end
