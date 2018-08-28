//
//  GDRuler.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GDRuler : UIControl
@property (nonatomic, assign) IBInspectable CGFloat selectedValue;//选中的数值
@property (nonatomic, assign) IBInspectable NSInteger minValue;//最小值
@property (nonatomic, assign) IBInspectable NSInteger maxValue;//最大值
@property (nonatomic, assign) IBInspectable NSInteger valueStep;//步长
@property (nonatomic, assign) IBInspectable CGFloat minorScaleSpacing;//小刻度间距，默认值 `8.0`
@property (nonatomic, assign) IBInspectable CGFloat majorScaleLength;//主刻度长度，默认值 `40.0`
@property (nonatomic, assign) IBInspectable CGFloat middleScaleLength;//中间刻度长度，默认值 `25.0`
@property (nonatomic, assign) IBInspectable CGFloat minorScaleLength;//小刻度长度，默认值 `10.0`
@property (nonatomic, strong) IBInspectable UIColor *rulerBackgroundColor;//刻度尺背景颜色，默认为 `clearColor`
@property (nonatomic, strong) IBInspectable UIColor *scaleColor;//刻度颜色，默认为 `lightGrayColor`
@property (nonatomic, strong) IBInspectable UIColor *scaleFontColor;// 刻度字体颜色，默认为 `darkGrayColor`
@property (nonatomic, assign) IBInspectable CGFloat scaleFontSize;//刻度字体尺寸，默认为 `10.0`
@property (nonatomic, strong) IBInspectable UIColor *indicatorColor;//指示器颜色，默认 `redColor`
@property (nonatomic, assign) IBInspectable CGFloat indicatorLength;//指示器长度，默认值为 `40.0`
@property (nonatomic, assign) IBInspectable NSInteger midCount;//几个大格标记一个刻度
@property (nonatomic, assign) IBInspectable NSInteger smallCount;//一个大格里面几个小格

@end
