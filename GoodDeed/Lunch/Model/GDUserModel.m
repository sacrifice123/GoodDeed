//
//  GDUserModel.m
//  GoodDeed
//
//  Created by 张涛 on 2018/9/18.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDUserModel.h"

@implementation GDUserModel

- (NSString *)token{
    
    return [[[NSUserDefaults standardUserDefaults] objectForKey:tokenCache] objectForKey:@"token"];
}

- (NSString *)uid{
    return [[NSUserDefaults standardUserDefaults] objectForKey:uidCache];
}

- (NSString *)headPortrait{
    
    if (_headPortrait&&[_headPortrait isKindOfClass:[NSString class]]) {
        return _headPortrait;
    }else{
        return nil;
    }
}

- (NSString *)imgUrl{
    
    if (_imgUrl&&[_imgUrl isKindOfClass:[NSString class]]) {
        return _imgUrl;
    }else{
        return nil;
    }
}

- (NSString *)name{
    
    if (_name&&[_name isKindOfClass:[NSString class]]) {
        return _name;
    }else{
        return nil;
    }
}

- (NSString *)organId{
    
    if (_organId&&[_organId isKindOfClass:[NSString class]]) {
        return _organId;
    }else{
        return nil;
    }
}

@end
