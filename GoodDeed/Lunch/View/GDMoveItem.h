//
//  GDMoveItem.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/4.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#define item_height 34

typedef void(^observeBlock)(CGRect);

@interface GDMoveItem : UILabel

@property (nonatomic) CGRect originFrame;
@property (copy, nonatomic) observeBlock block;
@property (strong, nonatomic) NSMutableArray *targetArray;

- (void)pause;

@end
