//
//  GDKnowViewController.m
//  GoodDeed
//
//  Created by 张涛 on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDKnowViewController.h"
#import "GDLaunchQuestionController.h"

@interface GDKnowViewController ()
@property (nonatomic, strong) UIView *transitionView;

@end

@implementation GDKnowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


//准备答题
- (IBAction)goReady:(id)sender {
    
    self.transitionView = sender;
    [self.navigationController hh_pushScaleViewController:[GDLaunchQuestionController new]];
    
}

- (UIView *)hh_transitionAnimationView{
    
    return self.transitionView;
}

@end
