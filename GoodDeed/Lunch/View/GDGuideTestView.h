//
//  GDGuideTestView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/25.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^finishBlcok)(BOOL);
@interface GDGuideTestView : UIView

@property (nonatomic, copy) finishBlcok block;

@end
