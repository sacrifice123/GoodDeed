//
//  GDLeftHeaderView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/7.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^imageChooseBlock)(void);
typedef void(^setImageBlock)(UIImage *image);
@interface GDLeftHeaderView : UIView

@property (nonatomic, copy) imageChooseBlock chooseBlock;
@property (nonatomic, copy) setImageBlock imageBlock;

@end
