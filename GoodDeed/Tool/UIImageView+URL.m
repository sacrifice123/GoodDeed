//
//  UIImageView+URL.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/10.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "UIImageView+URL.h"

@implementation UIImageView (URL)

- (void)gd_setImageWithUrlStr:(nullable NSString *)url {
    if (url&&[url isKindOfClass:[NSString class]]) {
        NSString *baseUrl = [url hasPrefix:@"http"]?@"":GDBaseImgUrl;
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,url]] placeholderImage:nil options:0 progress:nil completed:nil];

    }
}

- (void)gd_setImageWithUrlStr:(nullable NSString *)url placeholderImage:(nullable UIImage *)placeholder {
    if (url&&[url isKindOfClass:[NSString class]]) {
        NSString *baseUrl = [url hasPrefix:@"http"]?@"":GDBaseImgUrl;
        [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseUrl,url]] placeholderImage:placeholder options:0 progress:nil completed:nil];

    }
}

@end
