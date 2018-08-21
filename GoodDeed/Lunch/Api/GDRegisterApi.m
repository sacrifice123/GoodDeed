//
//  GDRegisterApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDRegisterApi.h"

@implementation GDRegisterApi
{
    NSString *_mail;
    NSString *_password;
    NSNumber *_type;
    NSString *_token;
    
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
- (instancetype)initWith:(NSString *)mail
                password:(NSString *)password
                    type:(NSNumber *)type
                   {
    if (self == [super init]) {
        
    }
    
    return self;
}

/*{
    "data": {
        "mail": "string",
        "password": "string",
        "resultReqVo": {
            "organId": 0,
            "writeReqVo": {
                "surveyId": 0,
                "uid": "string",
                "writeReqVoList": [
                                   {
                                       "content": "string",
                                       "optionId": 0,
                                       "optionOrder": 0,
                                       "questionId": 0,
                                       "type": 0
                                   }
                                   ]
            }
        },
        "type": 0
    },
    "token": "string"
}*/
/*
 
"resultReqVo": {
    "organId": 0,//公益组织id
    "writeReqVo": {//回答问题结果
        "surveyId": 0,// 调查表id
        "uid": "string",
        "writeReqVoList": [
                           {
                               "content": "string",//type为7填写题内容
                               "optionId": 0,//如果是填写题为0
                               "optionOrder": 0,// type3滑动题 左到右（1-6 7-11） type为5 选项顺序
                               "questionId": 0,// 问题id
                               "type": 0
                           }
                           ]
    }
},
 */
- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl{
    
    return  @"/login/onLogin";
}

- (id)requestArgument{
    return @{
             @"data":@{
                     
                     },
             @"token":@""
             };
    
}
@end
