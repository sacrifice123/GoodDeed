//
//  GDEditButton.m
//  GoodDeed
//
//  Created by 张涛 on 2018/6/13.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDEditButton.h"
#define IMAGE_PERCENT 0.5

@interface GDEditButton()
@property (nonatomic, assign) CGSize imgSize;
@end
@implementation GDEditButton

-(id)initWithFrame:(CGRect)frame
{
    if (self) {
        self=[super initWithFrame:frame];
    }
    self.titleLabel.font=[UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self sizeToFit];
    return self;
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect//文字
{
    //CGFloat x=self.frame.size.width*0.25;
    CGFloat x=10;
    CGFloat y=self.frame.size.height*IMAGE_PERCENT;//文字在3/4处显示
    CGFloat w=self.frame.size.width;
    CGFloat h=17;
    
    return CGRectMake(x, y, w, h);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect//图片
{
    CGFloat x=(self.frame.size.width-self.imgSize.width)*0.5;
    CGFloat y=5;
    return CGRectMake(x, y,self.imgSize.width, self.imgSize.height);
}

- (CGSize)imgSize{
    return self.currentImage.size;
}
@end
