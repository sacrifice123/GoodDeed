//
//  UIImageView+URL.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/10.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (URL)

- (void)gd_setImageWithUrlStr:(nullable NSString *)url;
- (void)gd_setImageWithUrlStr:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder;

@end
