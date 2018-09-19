//
//  GDEditTextViewModel.h
//  GoodDeed
//
//  Created by HK on 2018/8/21.
//  Copyright © 2018 GoodDeed. All rights reserved.
//

#import "GDEditBaseViewModel.h"

@interface GDEditTextViewModel : GDEditBaseViewModel

@property (copy, nonatomic) NSString *text;


// Choose One
+ (GDEditTextViewModel *)chooseOneViewModelWithSortIndex:(NSInteger)index
                                            deleteEnabel:(BOOL)deleteEnabel;

// Choose Multip
+ (GDEditTextViewModel *)chooseMultipViewModelWithSortIndex:(NSInteger)index
                                               deleteEnabel:(BOOL)deleteEnabel;

// Stack Range
+ (GDEditTextViewModel *)stackRangeViewModel:(NSInteger)index
                                deleteEnabel:(BOOL)deleteEnabel;

// Text
+ (GDEditTextViewModel *)textViewModel;

@end
