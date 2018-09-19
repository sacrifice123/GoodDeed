//
//  GDBoundRangeCollectionViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/9/5.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDEditBoundRangeViewModel.h"
@class GDBoundRangeCollectionViewCell;


typedef void (^BoundRangeCellUpdateHeightBlock) (GDBoundRangeCollectionViewCell *cell);

typedef void (^BoundRangeCellDeleteEventBlock) (GDBoundRangeCollectionViewCell *cell, GDBoundRangeItem *viewModel);


@interface GDBoundRangeCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) GDBoundRangeItem *viewModel;
@property (copy, nonatomic) BoundRangeCellDeleteEventBlock deleteEvent;
@property (copy, nonatomic) BoundRangeCellUpdateHeightBlock updateHeight;


@end
