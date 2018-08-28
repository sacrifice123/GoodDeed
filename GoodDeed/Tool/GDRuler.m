//
//  GDRuler.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDRuler.h"

#define kMinorScaleDefaultSpacing   20    // 小刻度间距
#define kMajorScaleDefaultLength    25.0  //主刻度高度
#define kMiddleScaleDefaultLength   17.0  //中间刻度高度
#define kMinorScaleDefaultLength    10.0  //小刻度高度
#define kRulerDefaultBackgroundColor    ([UIColor clearColor])  //刻度尺背景颜色
#define kScaleDefaultColor          ([UIColor lightGrayColor])  //刻度颜色
#define kScaleDefaultFontColor      ([UIColor darkGrayColor])  //刻度字体颜色
#define kScaleDefaultFontSize       10.0  //刻度字体
#define kIndicatorDefaultColor      ([UIColor redColor])  //指示器默认颜色
#define kIndicatorDefaultLength     80  //指示器高度

@interface GDRuler()

@end
@implementation GDRuler
{
    UIScrollView *_scrollView;
    UIImageView *_rulerImageView;
    UIView *_indicatorView;
}

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (_rulerImageView.image == nil) {
        [self reloadRuler];
    }
    CGSize size = self.bounds.size;
    _indicatorView.frame = CGRectMake(size.width * 0.5, size.height - self.indicatorLength, 1, self.indicatorLength);
    // 设置滚动视图内容间距
    CGSize textSize = [self maxValueTextSize];
    CGFloat offset = size.width * 0.5 - textSize.width;
    _scrollView.contentInset = UIEdgeInsetsMake(0, offset, 0, offset);
}

#pragma mark - 设置属性
//指示器颜色
- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorView.backgroundColor = indicatorColor;
}
////选中的数值
- (void)setSelectedValue:(CGFloat)selectedValue {
    if (selectedValue <_minValue || selectedValue > _maxValue || _valueStep <= 0) {
        return;
    }
    _selectedValue = selectedValue;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    CGFloat spacing = self.minorScaleSpacing;
    CGSize size = self.bounds.size;
    CGSize textSize = [self maxValueTextSize];
    CGFloat offset = 0;
    // 计算偏移量
    CGFloat steps = [self stepsWithValue:selectedValue];
    offset = size.width * 0.5 - textSize.width - steps * spacing;
    _scrollView.contentOffset = CGPointMake(-offset, 0);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat spacing = self.minorScaleSpacing;
    CGSize size = self.bounds.size;
    CGSize textSize = [self maxValueTextSize];
    CGFloat offset = targetContentOffset->x + size.width * 0.5 - textSize.width;
    NSInteger steps = (NSInteger)(offset / spacing + 0.5);
    targetContentOffset->x = -(size.width * 0.5 - textSize.width - steps * spacing) - 0.5;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!(scrollView.isDragging || scrollView.isTracking || scrollView.isDecelerating)) {
        return;
    }
    CGFloat spacing = self.minorScaleSpacing;
    CGSize size = self.bounds.size;
    CGSize textSize = [self maxValueTextSize];
    CGFloat offset = 0;
    offset = scrollView.contentOffset.x + size.width * 0.5 - textSize.width;
    NSInteger steps = (NSInteger)(offset / spacing + 0.5);
    CGFloat value = _minValue + steps * _valueStep/(_midCount*_smallCount);
    if (value != _selectedValue && (value >= _minValue && value <= _maxValue)) {
        _selectedValue = value;
        
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

#pragma mark - 绘制标尺相关方法

- (void)reloadRuler {
    UIImage *image = [self rulerImage];
    
    if (image == nil) {
        return;
    }
    _rulerImageView.image = image;
    _rulerImageView.backgroundColor = self.rulerBackgroundColor;
    [_rulerImageView sizeToFit];
    _scrollView.contentSize = _rulerImageView.image.size;
    // 水平标尺靠下对齐
    CGRect rect = _rulerImageView.frame;
    rect.origin.y = _scrollView.bounds.size.height - _rulerImageView.image.size.height;
    _rulerImageView.frame = rect;
    // 更新初始值
    self.selectedValue = _selectedValue;
}


- (UIImage *)rulerImage {
    
    // 1. 常数计算
    CGFloat steps = [self stepsWithValue:_maxValue];
    if (steps == 0) {
        return nil;
    }
    // 水平方向绘制图像的大小
    CGSize textSize = [self maxValueTextSize];
    CGFloat height = _scrollView.frame.size.height-_rulerImageView.frame.size.height ;
    CGFloat startX = textSize.width;
    CGRect rect = CGRectMake(0, 0, steps * self.minorScaleSpacing + 2 * startX, height);
    // 2. 绘制图像
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    // 1> 绘制刻度线
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = _minValue; i <= _maxValue; i += _valueStep) {
        // 绘制主刻度下
        CGFloat x = (i - _minValue) / _valueStep * self.minorScaleSpacing * (_midCount*_smallCount) + startX;
        [path moveToPoint:CGPointMake(x, height)];
        [path addLineToPoint:CGPointMake(x, height - self.majorScaleLength)];
        // 绘制主刻度上
        [path moveToPoint:CGPointMake(x, 0)];
        [path addLineToPoint:CGPointMake(x,self.majorScaleLength)];
        if (i == _maxValue) {
            break;
        }
        // 绘制小刻度线下
        for (NSInteger j = 1; j < (_midCount*_smallCount); j++) {
            CGFloat scaleX = x + j * self.minorScaleSpacing;
            [path moveToPoint:CGPointMake(scaleX, height)];
            CGFloat scaleY = height - ((j%_smallCount == 0) ? self.middleScaleLength : self.minorScaleLength);
            [path addLineToPoint:CGPointMake(scaleX, scaleY)];
        }
        // 绘制小刻度线上
        for (NSInteger j = 1; j < (_midCount*_smallCount); j++) {
            CGFloat scaleX = x + j * self.minorScaleSpacing;
            //上
            [path moveToPoint:CGPointMake(scaleX, 0)];
            CGFloat scaleY =((j%_smallCount == 0) ? self.middleScaleLength : self.minorScaleLength);
            //上
            [path addLineToPoint:CGPointMake(scaleX, scaleY)];
        }
        
    }
    [self.scaleColor set];
    [path stroke];
    // 2> 绘制刻度值
    NSDictionary *strAttributes = [self scaleTextAttributes];
    for (NSInteger i = _minValue; i <= _maxValue; i += _valueStep) {
        NSString *str = @(i).description;
        
        CGRect strRect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:strAttributes
                                           context:nil];
        strRect.origin.x = (i - _minValue) / _valueStep * self.minorScaleSpacing *( _midCount*_smallCount) + startX - strRect.size.width * 0.5;
        strRect.origin.y =_scrollView.frame.size.height*0.5-textSize.height*0.5;
        [str drawInRect:strRect withAttributes:strAttributes];
    }
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}


- (CGFloat)stepsWithValue:(CGFloat)value {
    
    if (_minValue >= value || _valueStep <= 0) {
        return 0;
    }
    
    return (value - _minValue) / _valueStep *( _midCount*_smallCount);
}


- (CGSize)maxValueTextSize {
    
    NSString *scaleText = @(self.maxValue).description;
    
    CGSize size = [scaleText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:[self scaleTextAttributes]
                                          context:nil].size;
    
    return CGSizeMake(floor(size.width), floor(size.height));
}


- (NSDictionary *)scaleTextAttributes {
    
    CGFloat fontSize = self.scaleFontSize * [UIScreen mainScreen].scale * 0.6;
    
    return @{NSForegroundColorAttributeName: self.scaleFontColor,
             NSFontAttributeName: [UIFont boldSystemFontOfSize:fontSize]};
}

#pragma mark - 设置界面
- (void)setupUI {
    // 滚动视图
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.layer.borderWidth=0.5;
    _scrollView.layer.borderColor=kScaleDefaultColor.CGColor;
    [self addSubview:_scrollView];
    // 标尺图像
    _rulerImageView = [[UIImageView alloc] init];
    [_scrollView addSubview:_rulerImageView];
    // 指示器视图
    _indicatorView = [[UIView alloc] init];
    _indicatorView.backgroundColor = self.indicatorColor;
    [self addSubview:_indicatorView];
}

#pragma mark - 属性默认值
//小刻度间距
- (CGFloat)minorScaleSpacing {
    if (_minorScaleSpacing <= 0) {
        _minorScaleSpacing = kMinorScaleDefaultSpacing;
    }
    return _minorScaleSpacing;
}
//主刻度长度
- (CGFloat)majorScaleLength {
    if (_majorScaleLength <= 0) {
        _majorScaleLength = kMajorScaleDefaultLength;
    }
    return _majorScaleLength;
}
//中间刻度长度
- (CGFloat)middleScaleLength {
    if (_middleScaleLength <= 0) {
        _middleScaleLength = kMiddleScaleDefaultLength;
    }
    return _middleScaleLength;
}
//小刻度长度
- (CGFloat)minorScaleLength {
    if (_minorScaleLength <= 0) {
        _minorScaleLength = kMinorScaleDefaultLength;
    }
    return _minorScaleLength;
}
//刻度尺背景颜色
- (UIColor *)rulerBackgroundColor {
    if (_rulerBackgroundColor == nil) {
        _rulerBackgroundColor = kRulerDefaultBackgroundColor;
    }
    return _rulerBackgroundColor;
}
//刻度颜色
- (UIColor *)scaleColor {
    if (_scaleColor == nil) {
        _scaleColor = kScaleDefaultColor;
    }
    return _scaleColor;
}
// 刻度字体颜色
- (UIColor *)scaleFontColor {
    if (_scaleFontColor == nil) {
        _scaleFontColor = kScaleDefaultFontColor;
    }
    return _scaleFontColor;
}
//刻度字体尺寸
- (CGFloat)scaleFontSize {
    if (_scaleFontSize <= 0) {
        _scaleFontSize = kScaleDefaultFontSize;
    }
    return _scaleFontSize;
}
//指示器颜色
- (UIColor *)indicatorColor {
    if (_indicatorView.backgroundColor == nil) {
        _indicatorView.backgroundColor = kIndicatorDefaultColor;
    }
    return _indicatorView.backgroundColor;
}
//指示器长度
- (CGFloat)indicatorLength {
    if (_indicatorLength <= 0) {
        _indicatorLength = kIndicatorDefaultLength;
    }
    return _indicatorLength;
}

@end
