//
//  GDPGSearchViewController.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDPGSearchViewController.h"

@interface GDPGSearchViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GDPGSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:self completion:nil];
}


@end
