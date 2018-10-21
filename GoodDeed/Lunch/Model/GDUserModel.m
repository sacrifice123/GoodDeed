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

    if (_token&&![_token isKindOfClass:[NSNull class]]) {
        return _token;
    }else{
        return @"";
    }
}

- (NSString *)uid{
    if (_uid&&![_uid isKindOfClass:[NSNull class]]) {
        return _uid;
    }else{
        return @"";
    }
}

- (NSString *)headPortrait{
    
    if (_headPortrait&&![_headPortrait isKindOfClass:[NSNull class]]) {
        return _headPortrait;
    }else{
        return @"";
    }
}

- (NSString *)imgUrl{
    
    if (_imgUrl&&![_imgUrl isKindOfClass:[NSNull class]]) {
        return _imgUrl;
    }else{
        return @"";
    }
}

- (NSString *)money{
    
    if (_money&&![_money isKindOfClass:[NSNull class]]) {
        _money = [NSString stringWithFormat:@"%@",_money];
        return (_money.length>0?_money:@"0");
    }else{
        return @"0";
    }
}
- (NSString *)mySurveyNum{
    
    if (_mySurveyNum&&![_mySurveyNum isKindOfClass:[NSNull class]]) {
        return _mySurveyNum;
    }else{
        return @"";
    }
}

- (NSString *)nowTime{
    
    if (_nowTime&&![_nowTime isKindOfClass:[NSNull class]]) {
        return _nowTime;
    }else{
        return @"";
    }
}

- (NSString *)name{
    
    if (_name&&![_name isKindOfClass:[NSNull class]]) {
        return _name;
    }else{
        return @"";
    }
}

- (NSString *)organId{
    
    if (_organId&&![_organId isKindOfClass:[NSNull class]]) {
        return _organId;
    }else{
        return @"";
    }
}

- (NSMutableArray *)groupArray{
    
    if (_groupArray == nil) {
        _groupArray = [[NSMutableArray alloc] init];
    }
    return _groupArray;
}

@end
