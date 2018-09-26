//
//  GDGuideTestView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/25.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGuideTestView.h"
#import "SCAdView.h"

@interface GDGuideTestView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *BGView;

@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (strong, nonatomic) NSMutableArray *imgArray;
@property (weak, nonatomic) IBOutlet UIImageView *animationImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animationTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewLeftConstraint;

@end
@implementation GDGuideTestView

- (void)dealloc{
    NSLog(@"GDGuideTestView_delloc");
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addShadowToView:self.animationImgView withColor:[UIColor colorWithRed:10.0/255 green:0 blue:0 alpha:0.14]];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH *4, SCREEN_HEIGHT*0.7-95);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = NO;
    [self createUI];
    
}

- (NSMutableArray *)imgArray{
    if (_imgArray == nil) {
        _imgArray = [[NSMutableArray alloc] init];
    }
    return _imgArray;
    
}

- (void)animationStart{
    for (UIImageView *obj in self.imgArray) {
        obj.hidden = NO;
    }
    __block int i = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        i++;
        if (i>=4) {
            [timer invalidate];
            timer = nil;
            return;
        }else if (i>0&&i<4){
            if (i==1) {
                UIImageView *imgView = self.imgArray.firstObject;
                [UIView animateWithDuration:0.6 animations:^{
                    imgView.alpha = 0;
                    self.animationImgView.alpha = 0;
                    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+218, self.scrollView.contentOffset.y) animated:NO];

                }];

            }else{
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+218, self.scrollView.contentOffset.y) animated:YES];

            }
        }
        
    }];
    [timer fire];
}

- (void)createUI{
    
    [self layoutSubviews];
    [self layoutIfNeeded];
    for (int i=0; i<4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(78+i*(SCREEN_WIDTH-156), ((i==0)?0: 22),SCREEN_WIDTH-156, self.scrollView.height)];
        [self.scrollView addSubview:view];
        CGFloat x = (i==0)?0:5;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, SCREEN_WIDTH-156-3*x, self.scrollView.height-((i==0)?0:25))];
        imgView.hidden = (i!=0);
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch_test%i",i+1]];
        [view addSubview:imgView];
        [self.imgArray addObject:imgView];
    }
    
    [self performSelector:@selector(updateAnimationTopConstraint) withObject:nil afterDelay:0.5];
    
    
}

- (void)updateAnimationTopConstraint{
    
    [UIView animateWithDuration:0.8 animations:^{
        self.animationTopConstraint.constant = 40;
        [self layoutIfNeeded];
    }];

}

- (IBAction)back:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)next:(UIButton *)sender {
    
    if (sender.tag == 0) {
        
        [self animationStart];
        self.topView.backgroundColor = [UIColor colorWithHexString:@"#3BA2CD"];


    }else if (sender.tag == 1) {
        self.topView.backgroundColor = [UIColor colorWithHexString:@"#FDCF44"];

    }else if (sender.tag == 2){//GO
        

    }
    self.maskView.backgroundColor = self.topView.backgroundColor;

    [UIView animateWithDuration:0.5 animations:^{

        self.bottomViewLeftConstraint.constant = -SCREEN_WIDTH*(sender.tag+1);
        [self layoutIfNeeded];
    }];

}

- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
    // 阴影颜色
    theView.layer.shadowColor = theColor.CGColor;
    // 阴影偏移，默认(0, -3)
    theView.layer.shadowOffset = CGSizeMake(0,0);    // 阴影透明度，默认0
    theView.layer.shadowOpacity = 0.01;    // 阴影半径，默认3
    theView.layer.shadowRadius = 2;
    
}
    

@end
