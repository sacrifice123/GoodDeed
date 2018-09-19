//
//  GDEditToolViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

typedef NS_ENUM(NSInteger, GDEditToolsStyle) {
    GDEditToolsStyleAddOption,  // 添加Cell
    GDEditToolsStyleRankItem,   // 排序Cell
};

@interface GDEditToolViewModel : GDEditBaseViewModel 


+ (GDEditToolViewModel *)chooseOneViewModel;
+ (GDEditToolViewModel *)chooseMultipViewModel;

+ (GDEditToolViewModel *)stackRankViewModel;
+ (GDEditToolViewModel *)imageVoteViewModel;

@end
