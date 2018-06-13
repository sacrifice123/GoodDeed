//
//  GDPreviewViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPreviewViewController.h"

@interface GDPreviewViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation GDPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)hh_transitionAnimationView{
    
    return self.button;
}
@end
