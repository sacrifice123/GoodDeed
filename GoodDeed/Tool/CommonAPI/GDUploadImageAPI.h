//
//  GDUploadImageAPI.h
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDBaseApi.h"

typedef void (^GDUploadImageSuccessBlock) (NSString *imageURL);
typedef void (^GDUploadImageFailureBlock) (NSString *errMsg, NSInteger errCode);

@interface GDUploadImageAPI : GDBaseApi

- (instancetype)initWithImage:(UIImage *)image;

+ (void)uploadImage:(UIImage *)image
            success:(GDUploadImageSuccessBlock)success
            failure:(GDUploadImageFailureBlock)failure;


@end
