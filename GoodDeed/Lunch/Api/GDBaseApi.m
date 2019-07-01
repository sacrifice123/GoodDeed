//
//  GDBaseApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

@implementation GDBaseApi

- (NSString *)baseUrl{
    
    return GDBaseUrl;
}


- (YTKRequestSerializerType)requestSerializerType{
    
    return YTKRequestSerializerTypeJSON;
}

- (NSString *)stringWithJsonString:(NSString *)jsonStr{
    jsonStr = [jsonStr componentsSeparatedByString:@"="].lastObject;
    NSString *string = [NSString stringWithFormat:@"{\"key\":%@}",jsonStr];
    NSDictionary *dic = [GDHelper dictionaryWithJsonString:string];
    return [dic objectForKey:@"key"];
}

- (NSDictionary *)authorizationInfoWithMethod:(NSString *)method urlPath:(NSString *)path{
    NSString *authStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"WWW-Authenticate"];
    NSArray *array = [authStr componentsSeparatedByString:@","];
    NSString *realm = [self stringWithJsonString:[array objectAtIndex:0]];
    NSString *qop = [self stringWithJsonString:[array objectAtIndex:1]];
    NSString *nonce = [self stringWithJsonString:[array objectAtIndex:2]];
    
    int cnonce = arc4random() % 100000;
    NSString *username = @"totti@qq.com";
    NSString *password = @"totti";
    
    NSString *md5pwd = [NSString md5Hex:password];
    NSString *HA1 =  [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:%@",username,realm,md5pwd]];
    NSString *HA2 =  [NSString md5Hex:[NSString stringWithFormat:@"%@:%@",method,path]];
    NSString *response = [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:1:%i:%@:%@",HA1,nonce,cnonce,qop,HA2]];
    NSString *auth =  [NSString stringWithFormat:@"%@,nc=1,cnonce=%i,response=%@,uri=%@,username=%@",authStr,cnonce,response,path,username];
    return @{
             @"authorization":auth
             };


}
@end
