//
//  GDGetCardByIdApi.m
//  GoodDeed
//
//  Created by 张涛 on 2018/10/16.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGetCardByIdApi.h"

@implementation GDGetCardByIdApi
{
    NSString *_cardId;
}

- (instancetype)initWithCardId:(NSString *)cardId{
    
    if (self = [super init]) {
        _cardId = cardId;
    }
    return self;
}

- (NSString *)requestUrl{
    
    return @"/getCardById";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument{
    
    GDUserModel *model = [[GDDataBaseManager sharedManager] queryUserData];
    return @{
             @"data":@{
                     @"id":_cardId?:@"",
                     @"uid":model.uid?:@""
                     },
             @"token":model.token?:@""
             };
    
}

@end
