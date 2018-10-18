//
//  GDBaseCell.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/8.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDOperationDelegate.h"
#import "GDHomeModel.h"

@interface GDBaseCell : UICollectionViewCell

@property (nonatomic, weak) id<GDOperationDelegate>delegate;
@property (nonatomic, strong) GDHomeModel *cardModel;

@end
