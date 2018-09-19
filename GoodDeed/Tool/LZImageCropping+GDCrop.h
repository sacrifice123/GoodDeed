//
//  LZImageCropping+GDCrop.h
//  GoodDeed
//
//  Created by HK on 2018/8/16.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "LZImageCropping.h"

@interface LZImageCropping (GDCrop)

// 问卷封面裁剪
+ (LZImageCropping *)surveyCoverCropImage:(UIImage *)image
                                 delegate:(id <LZImageCroppingDelegate>)delegate;


// 问题图片封面裁剪
+ (LZImageCropping *)surveyQuestionImageCropImage:(UIImage *)image
                                         delegate:(id <LZImageCroppingDelegate>)delegate;

// 图片问题裁剪
+ (LZImageCropping *)surveyImageVoteCropImage:(UIImage *)image
                                     delegate:(id <LZImageCroppingDelegate>)delegate;

@end
