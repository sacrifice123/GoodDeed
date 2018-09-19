//
//  GDDataBaseManager.m
//  GoodDeed
//
//  Created by xiaozhan on 2018/9/19.
//  Copyright © 2018年 GoodDeed. All rights reserved.
//

#import "GDDataBaseManager.h"
#import "GDUserModel.h"

@interface GDDataBaseManager()
@property (nonatomic, strong) FMDatabase *database;
@end
@implementation GDDataBaseManager

static GDDataBaseManager *manager;
+ (GDDataBaseManager *)sharedManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[GDDataBaseManager alloc] init];
    });
    
    return manager;
}

- (void)createDatabase{
    
    NSString *lidDirPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [lidDirPath stringByAppendingPathComponent:@"GDUserInfo.sqlite"];
    self.database = [FMDatabase databaseWithPath:databasePath];
    if (self.database != nil) {
        NSLog(@"数据库创建成功!");
    } else {
        NSLog(@"数据库创建失败!");
    }
    // 所有的数据库SQL语句，都需要数据库打开之后才能操作
    if ([self.database open]) {
        NSString *createTableSql = @"create table if not exists User(id integer primary key autoincrement, username text not null, phone text not null, age integer)";
        BOOL result = [self.database executeUpdate:createTableSql];
        if (result) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
        // 每次执行完对应SQL之后，要关闭数据库
        [self.database close];
    }
    
}

/*
 @property (copy, nonatomic) NSString *token;
 @property (copy, nonatomic) NSString *headPortrait;//用户头像路径
 @property (copy, nonatomic) NSString *money;//用户筹集到的善款
 @property (copy, nonatomic) NSString *mySurveyNum;//我的调查问卷数量
 @property (copy, nonatomic) NSString *uid;//用户uid
 
 @property (copy, nonatomic) NSString *imgUrl;//公益组织图片路径
 @property (copy, nonatomic) NSString *name;//公益组织名称
 @property (copy, nonatomic) NSString *organId;//公益组织id

 */
- (void)insert:(GDUserModel *)model{
    
    if ([self.database open]) {
        NSString *insertSql = @"insert into User(token, headPortrait, money,mySurveyNum,uid,imgUrl,name,organId) values(?,?,?,?,?,?,?,?)";
        BOOL result = [self.database executeUpdate:insertSql, model.token, model.headPortrait, model.money,model.mySurveyNum,model.uid,model.imgUrl,model.name,model.organId];
        if (result) {
            NSLog(@"插入数据成功");
        } else {
            NSLog(@"插入数据失败");
        }
        [self.database close];
    }
}

@end
