//
//  GDFirstQuestionListModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDFirstQuestionListModel : GDBaseModel

@property (nonatomic,strong) NSArray *firstOptionList;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *isSkip;
@property (nonatomic,copy) NSString *questionName;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,copy) NSString *type;


@end
