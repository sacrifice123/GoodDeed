//
//  GDOpenNotiViewController.m
//  GoodDeed
//
//  Created by 张涛 on 2018/8/23.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDOpenNotiViewController.h"

@interface GDOpenNotiViewController ()


@end

@implementation GDOpenNotiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

//启用通知
- (IBAction)openNoti:(id)sender {
    
    [GDWindow showWithString:@"启用成功"];
    GDWindow.rootViewController = [GDHomeManager getRootController:YES];

}


//以后再说
- (IBAction)skip:(id)sender {
    
    GDWindow.rootViewController = [GDHomeManager getRootController:YES];
}

@end
