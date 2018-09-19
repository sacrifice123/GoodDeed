//
//  GDBoundRangeViewModel.m
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBoundRangeViewModel.h"

@interface GDEditBoundRangeViewModel ()

@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation GDEditBoundRangeViewModel

+ (GDEditBoundRangeViewModel *)boundRangeViewModel
{
    return [[GDEditBoundRangeViewModel alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 270.f;
        self.kCellReuseId = kBoundedRangeAnswerCell;
        [self initializeDataSource];
    }
    
    return self;
}

- (void)initializeDataSource
{
    GDBoundRangeItem *item_0 = [[GDBoundRangeItem alloc] initWithDeleteEnable:NO];
    GDBoundRangeItem *item_1 = [[GDBoundRangeItem alloc] initWithDeleteEnable:NO];
    GDBoundRangeItem *item_2 = [[GDBoundRangeItem alloc] initWithDeleteEnable:NO];
    
    [self.dataSource addObject:item_0];
    [self.dataSource addObject:item_1];
    [self.dataSource addObject:item_2];
}


- (NSInteger)numberOfItems
{
    return self.dataSource.count;
}


- (GDBoundRangeItem *)itemAtIndex:(NSInteger)index
{
    if (index < self.dataSource.count) {
        return [self.dataSource objectAtIndex:index];
    }
    
    return nil;
}

static CGFloat MaxCellWidth = 56.f;
- (CGSize)cellSizeBySize:(CGSize)size
{
   
    if ([self spaceIsZeroWithSize:size]) {
        return CGSizeMake(MaxCellWidth, size.height);
    } else {
        return CGSizeMake(size.width/self.dataSource.count, size.height);
    }
}

- (CGFloat)cellSpaceBySize:(CGSize)size
{
    if ([self spaceIsZeroWithSize:size]) {
        CGSize cellSize = [self cellSizeBySize:size];
        return (size.width - cellSize.width * self.dataSource.count) / (self.dataSource.count - 1);
    } else {
        return 0;
    }
}

- (BOOL)spaceIsZeroWithSize:(CGSize)size
{
    NSInteger count = self.dataSource.count;
    if (count * MaxCellWidth < size.width) {
        return YES;
    } else {
        return NO;
    }
}

- (void)addOption
{
    GDBoundRangeItem *item = [[GDBoundRangeItem alloc] initWithDeleteEnable:YES];
    [self.dataSource addObject:item];
}

- (void)removeOption:(GDBoundRangeItem *)option
{
    [self.dataSource removeObject:option];
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

@end



@implementation GDBoundRangeItem

- (instancetype)initWithDeleteEnable:(BOOL)deleteEnabel
{
    self = [super init];
    if (self) {
        _deleteEnabel = deleteEnabel;
    }
    
    return self;
}

@end
