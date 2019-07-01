//
//  GDOrganModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/8/9.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDOrganModel : GDBaseModel

@property (nonatomic,copy) NSString *organId;//公益组织ID
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,assign) BOOL isSelected;
@property (nonatomic,copy) NSString *sort;
@property (nonatomic,copy) NSString *donation;
@property (nonatomic,copy) NSString *createTime;
@end
