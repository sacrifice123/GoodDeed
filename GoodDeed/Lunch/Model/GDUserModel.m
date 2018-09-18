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
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:tokenCache];
}

@end
