//
//  GDGuideTestView.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/25.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDGuideTestView.h"
#import "SCAdView.h"
#import <POP.h>
#import "UIView+LXShadowPath.h"

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
@property (weak, nonatomic) IBOutlet UIImageView *popImgView;

@end
@implementation GDGuideTestView

- (void)dealloc{
    NSLog(@"GDGuideTestView_delloc");
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.animationImgView  LX_SetShadowPathWith:[UIColor colorWithHexString:@"#E6E6E6"] shadowOpacity:0.001 shadowRadius:0.01 shadowSide:LXShadowPathAllSide shadowPathWidth:0.01];
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

static int margin = 78;
- (void)createUI{
    
    [self layoutSubviews];
    [self layoutIfNeeded];
    for (int i=0; i<4; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(margin+i*(SCREEN_WIDTH-margin*2), ((i==0)?0: 22),SCREEN_WIDTH-margin*2, self.scrollView.height)];
        [self.scrollView addSubview:view];
        CGFloat x = (i==0)?0:5;
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, SCREEN_WIDTH-margin*2-3*x, self.scrollView.height-((i==0)?0:25))];
        imgView.hidden = (i!=0);
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch_test%i",i+1]];
        [view addSubview:imgView];
        [self.imgArray addObject:imgView];
    }
    
    [self performSelector:@selector(updateAnimationTopConstraint) withObject:nil afterDelay:0.5];
    
    
}

- (void)updateAnimationTopConstraint{
    
    [UIView animateWithDuration:0.8 animations:^{
        self.animationTopConstraint.constant = 41;
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
        self.BGView.hidden = NO;

        [UIView animateWithDuration:0.6 animations:^{
            
            [self.scrollView setContentOffset:CGPointMake(218*4+SCREEN_WIDTH, self.scrollView.contentOffset.y) animated:NO];

        } completion:^(BOOL finished) {
            
            self.popImgView.hidden = NO;
            POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
            springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
            springAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(12, 12)];
            springAnimation.springBounciness = 12.f;
            [self.popImgView pop_addAnimation:springAnimation forKey:@"springAnimation"];

        }];
        
    }else if (sender.tag == 2){//GO

        if (self.block) {
            self.block(YES);
        }
    }
    self.maskView.backgroundColor = self.topView.backgroundColor;

    [UIView animateWithDuration:0.5 animations:^{

        self.bottomViewLeftConstraint.constant = -SCREEN_WIDTH*(sender.tag+1);
        [self layoutIfNeeded];
    }];

}

    

@end
