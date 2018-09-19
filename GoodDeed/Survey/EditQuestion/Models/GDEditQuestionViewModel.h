//
//  GDEditQuestionViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/26.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

@interface GDEditQuestionViewModel : GDEditBaseViewModel


@property (copy, nonatomic) NSString *text;

- (instancetype)initWithPlaceholer:(NSString *)placeholder;


@end
