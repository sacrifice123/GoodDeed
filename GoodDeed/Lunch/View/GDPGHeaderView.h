//
//  GDPGHeaderView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(void);
@interface GDPGHeaderView : UICollectionReusableView

@property (nonatomic, strong) clickBlock block;;
@end
