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
@property (weak, nonatomic) IBOutlet UIView *transitionView;

@end

@implementation GDPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1];
}

- (void)remove{
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (UIView *)hh_transitionAnimationView{
    
    return self.view;
}
@end
