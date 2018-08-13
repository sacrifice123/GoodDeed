//
//  GDPGChooseView.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/6/26.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDPGChooseView : UIView

@property (nonatomic,assign) BOOL isSearch;
- (void)reloadWithDatas:(NSArray *)datas;
@end
