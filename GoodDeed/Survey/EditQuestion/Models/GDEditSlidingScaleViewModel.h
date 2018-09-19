//
//  GDEditSlidingScaleViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

@interface GDEditSlidingScaleViewModel : GDEditBaseViewModel

@property (copy, nonatomic) NSString *leftText;
@property (copy, nonatomic) NSString *rightText;

+ (GDEditSlidingScaleViewModel *)slidingScaleViewModel;

@end
