//
//  GDLoginApi.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLoginApi.h"

@implementation GDLoginApi
{
    NSString *_password;
    NSString *_username;
    
}

/*登录
 type: 1邮箱 2手机号 3微信 4新浪 5用户名
 */
- (instancetype)initWith:(NSString *)username
                password:(NSString *)password{

    username = @"totti@qq.com";
    password = @"totti";
    if (self = [super init]) {
        _username = username;
        _password = password;
    }
    return self;
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (NSString *)requestUrl{
    
    return  @"/login";
}

- (id)requestArgument{
    return @{
             @"organizationId":@"",
             @"password":_password,
             @"username":_username
             
             };
    
}

- (NSDictionary *)requestHeaderFieldValueDictionary{
    NSString *authStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"WWW-Authenticate"];
    NSArray *array = [authStr componentsSeparatedByString:@","];
    NSString *realm = [self stringWithJsonString:[array objectAtIndex:0]];
    NSString *qop = [self stringWithJsonString:[array objectAtIndex:1]];
    NSString *nonce = [self stringWithJsonString:[array objectAtIndex:2]];
   // NSString *opaque = [self stringWithJsonString:[array objectAtIndex:3]];
    
    int cnonce = arc4random() % 100000;
    NSString *md5pwd = [NSString md5Hex:_password];
    NSString *HA1 =  [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:%@",_username,realm,md5pwd]];
    NSString *HA2 =  [NSString md5Hex:@"POST:/login"];
    NSString *response = [NSString md5Hex:[NSString stringWithFormat:@"%@:%@:1:%i:%@:%@",HA1,nonce,cnonce,qop,HA2]];
    NSString *auth =  [NSString stringWithFormat:@"%@,nc=1,cnonce=%i,response=%@,uri=/login,username=%@",authStr,cnonce,response,_username];
 //   [[NSUserDefaults standardUserDefaults] setObject:auth forKey:@"authorizationtest"];
    return @{
             @"authorization":auth
            };
    
}

- (NSString *)stringWithJsonString:(NSString *)jsonStr{
    jsonStr = [jsonStr componentsSeparatedByString:@"="].lastObject;
    NSString *string = [NSString stringWithFormat:@"{\"key\":%@}",jsonStr];
    NSDictionary *dic = [GDHelper dictionaryWithJsonString:string];
    return [dic objectForKey:@"key"];
}

@end
