//
//  GDBoundRangeViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"
@class GDBoundRangeItem;

@interface GDEditBoundRangeViewModel : GDEditBaseViewModel

@property (strong, nonatomic) NSArray <GDBoundRangeItem *>*rangeTips;

+ (GDEditBoundRangeViewModel *)boundRangeViewModel;

- (NSInteger)numberOfItems;
- (GDBoundRangeItem *)itemAtIndex:(NSInteger)index;
- (CGSize)cellSizeBySize:(CGSize)size;
- (CGFloat)cellSpaceBySize:(CGSize)size;

- (void)addOption;
- (void)removeOption:(GDBoundRangeItem *)option;


@end


@interface GDBoundRangeItem : NSObject

@property (copy, nonatomic) NSString *rangeText;
@property (nonatomic) BOOL deleteEnabel;

- (instancetype)initWithDeleteEnable:(BOOL)deleteEnabel;

@end
