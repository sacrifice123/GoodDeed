//
//  GDSurveyPageProtocol.h
//  GoodDeed
//
//  Created by HK on 2018/8/27.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDSurveyDefine.h"
@protocol GDSurveyPageProtocol;

typedef void (^GDSurveyNextStepEvent) (UIViewController <GDSurveyPageProtocol>*surveyVC);


@protocol GDSurveyPageProtocol <NSObject>

// 问卷类型
- (GDSurveyEditType)surveyType;

// 下一步
- (void)nextStep:(GDSurveyNextStepEvent)nextStep;

// 问卷内容
- (id)surveyContent;

@end
