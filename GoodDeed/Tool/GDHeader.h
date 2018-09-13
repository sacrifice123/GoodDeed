//
//  GDHeader.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#ifndef GDHeader_h
#define GDHeader_h

#define GDWindow        [UIApplication sharedApplication].keyWindow
#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)
#define Item_Space      15 //行间距
#define animationStatus @"animationStatus"
#define organModelCache @"organModelCache"
#import <UIKit/UIKit.h>
static NSString *const GDBaseUrl = @"http://47.97.102.73/giraffe";//api基地址
static NSString *const GDBaseImgUrl = @"http://47.97.102.73/giraffe";//图片基地址(后面可能会变)


#endif /* GDHeader_h */
