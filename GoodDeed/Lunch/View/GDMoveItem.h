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
@property (nonatomic) NSInteger position;//当前选项挪动后的位置
@property (copy, nonatomic) observeBlock block;
@property (copy, nonatomic) NSString *optionId;
@property (strong, nonatomic) NSMutableArray *targetArray;

- (void)pause;

@end
