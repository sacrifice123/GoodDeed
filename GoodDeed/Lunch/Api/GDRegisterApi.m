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

/*Printing description of jsonData:
 {
 code = 200;
 data =     {
 firstQuestionList =         (
 {
 firstOptionList =                 (
 {
 id = 1;
 optionName = "\U597d";
 position = 0;
 },
 {
 id = 2;
 optionName = "\U4e0d\U597d";
 position = 0;
 }
 );
 id = 1;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U6d66\U4e1c\U73af\U5883";
 sort = 1;
 type = 1;
 },
 {
 firstOptionList =                 (
 {
 id = 3;
 optionName = "\U597d";
 position = 0;
 },
 {
 id = 4;
 optionName = "\U4e0d\U597d";
 position = 0;
 }
 );
 id = 2;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U5468\U6d66\U73af\U5883";
 sort = 2;
 type = 2;
 },
 {
 firstOptionList =                 (
 {
 id = 5;
 optionName = "\U597d";
 position = 0;
 },
 {
 id = 6;
 optionName = "\U4e0d\U597d";
 position = 1;
 }
 );
 id = 3;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U5f90\U6c47\U73af\U5883";
 sort = 3;
 type = 3;
 },
 {
 firstOptionList =                 (
 {
 id = 8;
 optionName = "\U4e0d\U597d";
 position = 0;
 },
 {
 id = 9;
 optionName = "\U8fd8\U884c";
 position = 0;
 },
 {
 id = 10;
 optionName = "\U597d";
 position = 0;
 }
 );
 id = 4;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U9ec4\U6d66\U73af\U5883";
 sort = 4;
 type = 4;
 },
 {
 firstOptionList =                 (
 {
 id = 11;
 optionName = "\U597d";
 position = 0;
 },
 {
 id = 12;
 optionName = "\U4e0d\U597d";
 position = 0;
 }
 );
 id = 5;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U6768\U6d66\U73af\U5883";
 sort = 5;
 type = 5;
 },
 {
 firstOptionList = "<null>";
 id = 7;
 imgUrl = "";
 isSkip = 1;
 questionName = "\U4e0a\U6d77\U5d07\U660e\U73af\U5883";
 sort = 7;
 type = 7;
 }
 );
 id = 1;
 imgUrl = "";
 name = "\U4e0a\U6d77\U73af\U5883";
 personNum = 0;
 personTypeId = 0;
 type = 0;
 uid = "<null>";
 };
 token = "";
 }
 (lldb) */
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
