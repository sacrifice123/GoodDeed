//
//  GDEditTextTypeCellProtocol.h
//  GoodDeed
//
//  Created by HK on 2018/9/4.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GDTextView.h"
#import "GDEditBaseViewModel.h"
@protocol GDEditTextTypeCellProtocol;


typedef void (^EditTextCellUpdateHeightBlock) (UITableViewCell <GDEditTextTypeCellProtocol>*cell);
typedef void (^EditTextCellDeleteEventBlock) (UITableViewCell <GDEditTextTypeCellProtocol>*cell, GDEditBaseViewModel *deleteModel);

@protocol GDEditTextTypeCellProtocol <NSObject>

@property (strong, nonatomic) GDEditBaseViewModel *viewModel;

@property (copy, nonatomic) EditTextCellUpdateHeightBlock updateHeight;
@property (copy, nonatomic) EditTextCellDeleteEventBlock deleteEvent;

@end
