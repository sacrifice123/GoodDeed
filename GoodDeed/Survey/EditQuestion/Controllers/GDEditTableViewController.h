//
//  GDEditTableViewController.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditListViewController.h"
#import "GDEditPageModel.h"

// 单选
// 多选
// 滑动
// 范围
// 排序
@interface GDEditTableViewController : GDEditListViewController

- (instancetype)initWithPageModel:(GDEditPageModel *)pageModel;

@end
