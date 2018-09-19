//
//  GDStackRangeEditTableViewCell.h
//  GoodDeed
//
//  Created by HK on 2018/9/6.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDEditTextTypeCellProtocol.h"

@interface GDStackRankEditTableViewCell : UITableViewCell <GDEditTextTypeCellProtocol>
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
