//
//  GDSortModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/6.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GDMoveItem;
@interface GDSortModel : NSObject

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, weak) GDMoveItem *item;
@property (nonatomic, assign) BOOL selected;//是否选中排序

@end
