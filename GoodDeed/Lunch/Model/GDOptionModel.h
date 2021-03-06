//
//  GDOptionModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/12.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDOptionModel : NSObject

@property (copy, nonatomic) NSString *questionId;//本地多表查询使用
@property (copy, nonatomic) NSString *optionId;
@property (copy, nonatomic) NSString *optionName;
@property (copy, nonatomic) NSString *position;
@property (copy, nonatomic) NSString *cardId;//首页回答问卷使用
@property (copy, nonatomic) NSString *order;//排序
@property (copy, nonatomic) NSString *count;
@property (copy, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSDictionary *orderAndCount;
@end
