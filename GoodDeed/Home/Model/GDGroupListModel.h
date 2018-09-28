//
//  GDGroupListModel.h
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/20.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDBaseModel.h"

@interface GDGroupListModel : GDBaseModel

@property (nonatomic, copy) NSString *groupId;//团队id
@property (nonatomic, copy) NSString *name;//团队名称
//成员
@property (nonatomic, copy) NSString *imgUrl;//成员头像url
@property (nonatomic, copy) NSString *money;//筹集到的善款
@property (nonatomic, copy) NSString *uid;//成员uid
@property (nonatomic, copy) NSString *uidName;//成员的名称
@property (nonatomic, assign) NSIndexPath *index;//定位

@end
