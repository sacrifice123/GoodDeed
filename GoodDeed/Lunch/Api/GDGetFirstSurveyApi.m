//
//  GDGetFirstSurveyApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetFirstSurveyApi.h"
#import "NSString+GDMD5.h"

@implementation GDGetFirstSurveyApi

- (NSString *)requestUrl{
    
    return @"/survey/firstSurvey";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

//- (id)requestArgument{
//    return @{
//             @"data":@{
//                     
//                     },
//             @"token":@""
//             };
//    
//}

//- (NSDictionary *)requestHeaderFieldValueDictionary{
//    NSString *authStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"WWW-Authenticate"];
//    NSArray *array = [authStr componentsSeparatedByString:@","];
//    NSString *realm = [self stringWithJsonString:[array objectAtIndex:0]];
//    NSString *qop = [self stringWithJsonString:[array objectAtIndex:1]];
//    NSString *nonce = [self stringWithJsonString:[array objectAtIndex:2]];
//    // NSString *opaque = [self stringWithJsonString:[array objectAtIndex:3]];
//    NSString *username = @"totti@qq.com";
//    NSString *password = @"totti";
//
//    int cnonce = arc4random() % 100000;
//    NSString *md5pwd = [NSString md5Hex:password];
//    NSString *HA1 =  [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:%@",username,realm,md5pwd]];
//    NSString *HA2 =  [NSString md5Hex:@"GET:/survey/firstSurvey"];
//    NSString *response = [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:1:%i:%@:%@",HA1,nonce,cnonce,qop,HA2]];
//    NSString *auth =  [NSString stringWithFormat:@"%@,nc=1,cnonce=%i,response=%@,uri=/survey/firstSurvey,username=%@",authStr,cnonce,response,username];
//
//    return @{
//             @"authorization":auth
//             };
//
//}

//- (NSString *)stringWithJsonString:(NSString *)jsonStr{
//    jsonStr = [jsonStr componentsSeparatedByString:@"="].lastObject;
//    NSString *string = [NSString stringWithFormat:@"{\"key\":%@}",jsonStr];
//    NSDictionary *dic = [GDHelper dictionaryWithJsonString:string];
//    return [dic objectForKey:@"key"];
//}

@end
