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
        [manager createDatabase];

    });
    return manager;
}

- (void)createDatabase{

    NSString *lidDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *databasePath = [lidDirPath stringByAppendingPathComponent:@"GDUser.db"];
    NSLog(@"databasePath:%@",databasePath);
    self.database = [FMDatabase databaseWithPath:databasePath];
    if (self.database != nil) {
        NSLog(@"数据库创建成功!");
    } else {
        NSLog(@"数据库创建失败!");
    }
    // 创建user表
    if ([self.database open]) {
        NSString *createTableSql = @"create table if not exists t_user(uid text not null primary key,token text not null,name text not null,headPortrait text not null, money text not null, mySurveyNum text not null,nowTime text not null,imgUrl text not null,organId text not null)";
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

- (void)insert:(GDUserModel *)model{

    if ([self.database open]) {
        NSString *sql = @"insert into t_user(token, headPortrait, money,mySurveyNum,uid,nowTime,imgUrl,name,organId) values(?,?,?,?,?,?,?,?,?)";
        BOOL result = [self.database executeUpdate:sql withArgumentsInArray:@[ model.token, model.headPortrait, model.money,model.mySurveyNum,model.uid,model.nowTime,model.imgUrl,model.name,model.organId]];
        if (result) {
            NSLog(@"插入数据成功");
        } else {
            NSLog(@"插入数据失败");
        }
        [self.database close];
    }
}

- (void)update:(GDUserModel *)model{

    NSDictionary *dic = [GDHelper dictionaryFromModel:model];
    if ([self.database open]) {
        [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
            if (obj&&[obj isKindOfClass:[NSString class]]&&obj.length>0) {
                NSString *sql = [NSString stringWithFormat:@"update t_user set '%@' = '%@' where uid = '%@'",key,obj,model.uid];
                BOOL result = [self.database executeUpdate:sql];
                if (result) {
                    NSLog(@"更新数据成功");
                } else {
                    NSLog(@"更新数据失败");
                }

            }

        }];
        [self.database close];

    }
}

//查询登录用户
- (GDUserModel *)queryUserData{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if ([self.database open]) {
        NSString *sql = @"select *from t_user where uid != '820380768'";
        FMResultSet *result = [self.database executeQuery:sql];
        while ([result next]) {
            GDUserModel *model = [[GDUserModel alloc] init];
            model.token = [result stringForColumn:@"token"];
            model.headPortrait = [result stringForColumn:@"headPortrait"];
            model.uid = [result stringForColumn:@"uid"];
            model.money = [result stringForColumn:@"money"];
            model.mySurveyNum = [result stringForColumn:@"mySurveyNum"];
            model.nowTime = [result stringForColumn:@"nowTime"];
            model.imgUrl = [result stringForColumn:@"imgUrl"];
            model.name = [result stringForColumn:@"name"];
            model.organId = [result stringForColumn:@"organId"];
            [array addObject:model];
        }
        [self.database close];
        
    }
    return array.firstObject;
}

- (GDUserModel *)query:(NSString *)uid{
    GDUserModel *model = [[GDUserModel alloc] init];
    if ([self.database open]) {
        NSString *sql = @"select *from t_user where uid = ?";
        FMResultSet *result = [self.database executeQuery:sql withArgumentsInArray:@[uid]];
        while ([result next]) {
            model.token = [result stringForColumn:@"token"];
            model.headPortrait = [result stringForColumn:@"headPortrait"];
            model.uid = [result stringForColumn:@"uid"];
            model.money = [result stringForColumn:@"money"];
            model.mySurveyNum = [result stringForColumn:@"mySurveyNum"];
            model.nowTime = [result stringForColumn:@"nowTime"];
            model.imgUrl = [result stringForColumn:@"imgUrl"];
            model.name = [result stringForColumn:@"name"];
            model.organId = [result stringForColumn:@"organId"];

        }
        [self.database close];

    }
    return model;
}

- (void)deleteData{
    
    if ([self.database open]) {
         BOOL result = [self.database executeUpdate:@"delete from t_user"];
        if (result) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }

        [self.database close];
        
    }

}
@end

