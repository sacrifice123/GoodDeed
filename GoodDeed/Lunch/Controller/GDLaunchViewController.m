//
//  GDLaunchViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDLaunchViewController.h"

@interface GDLaunchViewController ()
@property (strong, nonatomic) IBOutlet UIView *startView;

@end

@implementation GDLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];

}


- (IBAction)startHere:(id)sender {

    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.startView];
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (IBAction)Go:(id)sender {
    
    
}


- (IBAction)login:(id)sender {
    
    
}

@end
