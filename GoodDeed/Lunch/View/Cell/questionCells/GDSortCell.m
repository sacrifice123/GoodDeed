//
//  GDSortCell.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/28.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDSortCell.h"
#import "GDMoveItem.h"
#import "GDSortModel.h"

@interface GDSortCell()

@property (nonatomic, strong) UIView *bgView;
@end

@implementation GDSortCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]){
        
        
    }
    
    return self;
}

- (UIView *)bgView{
    
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}

- (void)setModel:(GDFirstQuestionListModel *)model{
    
    if ([self.contentView.subviews containsObject:self.bgView]) {
        return;
    }
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.contentView layoutIfNeeded];
    CGFloat space = model.firstOptionList.count*(item_height+10)+25;
    NSMutableArray *targetArray = [[NSMutableArray alloc] init];
    for (int i=0; i<model.firstOptionList.count; i++) {
        CGRect frame = CGRectMake(25, i*(item_height+10), SCREEN_WIDTH-50, item_height);
        
        UIButton *button = [[UIButton alloc] initWithFrame:frame];
        button.tag = i;
        [button setAdjustsImageWhenHighlighted:NO];
        [button setBackgroundImage:[UIImage imageNamed:@"sort_unSelected"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"sort_selected"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@"%i",i+1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Thin" size:20];
        [self.bgView addSubview:button];
        GDMoveItem *item = [[GDMoveItem alloc] initWithFrame:CGRectMake(25, i*(item_height+10)+space, SCREEN_WIDTH-50, item_height)];
        item.targetArray = targetArray;
        item.tag = i;
        item.text = model.firstOptionList[i];
        [self.bgView addSubview:item];
        GDSortModel *model = [[GDSortModel alloc] init];
        model.button = button;
        //model.item = item;
        [targetArray addObject:model];


    }
}

- (UIView *)drawDotLineWithLineColor:(UIColor *)lineColor withFillColor:(UIColor *)fillColor withCornerRadius:(CGFloat)radius withLineWidth:(CGFloat)lineWidth AndLineType:(NSString *)type {
    
    
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    
    
    shapeLayer.strokeColor = lineColor.CGColor;
    
    
    
    shapeLayer.fillColor = fillColor.CGColor;
    
    
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    
    
    
    shapeLayer.path = path.CGPath;
    
    
    
    shapeLayer.frame = self.bounds;
    
    
    
    shapeLayer.lineWidth = lineWidth;
    
    
    
    if (type) {
        
        shapeLayer.lineCap = type;
        
    }else{
        
        shapeLayer.lineCap = @"square";
        
    }
    
    //虚线每段长度和间隔
    
    shapeLayer.lineDashPattern = @[@(2), @(2)];
    
    [self.layer addSublayer:shapeLayer];
    
    return self;
    
}


@end
