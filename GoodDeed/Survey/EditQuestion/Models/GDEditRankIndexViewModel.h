//
//  GDStackRangeIndexViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

@interface GDEditRankIndexViewModel : GDEditBaseViewModel

@property (nonatomic) NSInteger index;

- (instancetype)initWithIndex:(NSInteger)index;

@end
