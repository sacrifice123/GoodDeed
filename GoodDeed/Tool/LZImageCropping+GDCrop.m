//
//  LZImageCropping+GDCrop.m
//  GoodDeed
//
//  Created by HK on 2018/8/16.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "LZImageCropping+GDCrop.h"

@implementation LZImageCropping (GDCrop)

// 问卷封面裁剪
+ (LZImageCropping *)surveyCoverCropImage:(UIImage *)image
                                 delegate:(id <LZImageCroppingDelegate>)delegate
{
    LZImageCropping *imageBrowser = [[LZImageCropping alloc]init];
    //设置代理
    imageBrowser.delegate = delegate;
    //设置自定义裁剪区域大小
    imageBrowser.cropSize = CGSizeMake(GDScaleValue(280.f), GDScaleValue(531.5));
    //设置图片
    [imageBrowser setImage:image];
    //是否需要圆形
    imageBrowser.isRound = NO;
    return imageBrowser;
}

// 问题图片封面裁剪
+ (LZImageCropping *)surveyQuestionImageCropImage:(UIImage *)image
                                         delegate:(id <LZImageCroppingDelegate>)delegate
{
    LZImageCropping *imageBrowser = [[LZImageCropping alloc]init];
    //设置代理
    imageBrowser.delegate = delegate;
    //设置自定义裁剪区域大小
    imageBrowser.cropSize = CGSizeMake(GDScaleValue(280.f), GDScaleValue(280.0));
    //设置图片
    [imageBrowser setImage:image];
    //是否需要圆形
    imageBrowser.isRound = NO;
    return imageBrowser;
}

// 图片问题裁剪
+ (LZImageCropping *)surveyImageVoteCropImage:(UIImage *)image
                                     delegate:(id <LZImageCroppingDelegate>)delegate
{
    LZImageCropping *imageBrowser = [[LZImageCropping alloc]init];
    //设置代理
    imageBrowser.delegate = delegate;
    //设置自定义裁剪区域大小
    imageBrowser.cropSize = CGSizeMake(GDScaleValue(280.f), GDScaleValue(280.0));
    //设置图片
    [imageBrowser setImage:image];
    //是否需要圆形
    imageBrowser.isRound = NO;
    return imageBrowser;
}

@end
