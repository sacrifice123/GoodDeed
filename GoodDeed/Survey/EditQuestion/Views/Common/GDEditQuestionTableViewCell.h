//
//  GDEditQuestionTableViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/8/26.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDEditQuestionViewModel.h"
#import "GDTextView.h"
#import "GDEditTextTypeCellProtocol.h"
@class GDEditQuestionTableViewCell;



@interface GDEditQuestionTableViewCell : UITableViewCell <GDEditTextTypeCellProtocol>


+ (GDEditQuestionTableViewCell *)questionTableViewCell;

@end
