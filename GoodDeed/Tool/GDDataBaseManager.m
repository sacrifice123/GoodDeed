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
static FMDatabaseQueue *sharedQueue;
+ (GDDataBaseManager *)sharedManager {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        manager = [[GDDataBaseManager alloc] init];
        [manager createDatabase];

    });
    return manager;
}

+ (FMDatabaseQueue *)sharedQueue {
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        NSString *lidDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *databasePath = [lidDirPath stringByAppendingPathComponent:@"GDUser.db"];
        NSLog(@"databasePath:%@",databasePath);
        sharedQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
        
    });
    return sharedQueue;
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
    // 创建user表与问卷表
    if ([self.database open]) {
        NSString *createTableSql = @"create table if not exists t_user(uid text not null primary key,token text not null,name text not null,headPortrait text not null, money text not null, mySurveyNum text not null,mail text not null,imgUrl text not null,organId text not null)";
        BOOL result = [self.database executeUpdate:createTableSql];
        if (result) {
            NSLog(@"创建表成功");
        } else {
            NSLog(@"创建表失败");
        }
        [self createSuveryTable:self.database];
        // 每次执行完对应SQL之后，要关闭数据库
        [self.database close];
    }
    
}

- (void)insert:(GDUserModel *)model{

    if ([self.database open]) {
        NSString *sql = @"insert into t_user(token, headPortrait, money,mySurveyNum,uid,mail,imgUrl,name,organId) values(?,?,?,?,?,?,?,?,?)";
        BOOL result = [self.database executeUpdate:sql withArgumentsInArray:@[ model.token, model.headPortrait, model.money,model.mySurveyNum,model.uid,model.mail,model.imgUrl,model.name,model.organId]];
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
            model.mail = [result stringForColumn:@"mail"];
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
            model.mail = [result stringForColumn:@"mail"];
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


#pragma mark 创建草稿问卷本地缓存
- (void)createSuveryTable:(FMDatabase *)db{
    //对应GDSurveyModel表
    BOOL result1 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey (surveyId text PRIMARY KEY,uid text,name text,imgUrl text,type text,personTypeId text,personNum text)"];
    if (result1) {
        NSLog(@"问卷表创建成功");
    }else{
        NSLog(@"问卷表创建失败");
    }
    
    //对应GDQuestionModel表
    BOOL result2 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey_question (questionId text PRIMARY KEY,surveyId text,isSkip text,imgUrl text,questionName text,index_s integer,sort integer,type integer)"];
    if (result2) {
        NSLog(@"问题表创建成功");
    }else{
        NSLog(@"问题表创建失败");
    }
    
    //对应GDOptionModel表
    BOOL result3 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey_option (optionId text PRIMARY KEY,questionId text,optionName text,position text)"];
    if (result3) {
        NSLog(@"选项表创建成功");
    }else{
        NSLog(@"选项表创建失败");
    }

}

//+ (void)createSurveyTable{
//    
//    [[self sharedQueue] inDatabase:^(FMDatabase * _Nonnull db) {//多线程使用事务
//        
//        if ([db open]) {
//            //对应GDSurveyModel表
//            BOOL result1 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey (surveyId text PRIMARY KEY,uid text,name text,imgUrl text,type text,personTypeId text,personNum text)"];
//            if (result1) {
//                NSLog(@"问卷表创建成功");
//            }else{
//                NSLog(@"问卷表创建失败");
//            }
//
//            //对应GDQuestionModel表
//            BOOL result2 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey_question (questionId text PRIMARY KEY,surveyId text,isSkip text,imgUrl text,questionName text,index_s integer,sort integer,type integer)"];
//            if (result2) {
//                NSLog(@"问题表创建成功");
//            }else{
//                NSLog(@"问题表创建失败");
//            }
//
//            //对应GDOptionModel表
//            BOOL result3 = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS survey_option (optionId text PRIMARY KEY,questionId text,optionName text,position text)"];
//            if (result3) {
//                NSLog(@"选项表创建成功");
//            }else{
//                NSLog(@"选项表创建失败");
//            }
//
//            [db close];
//            
//        }
//    }];
//
//}

+ (void)saveSurvey:(GDSurveyModel *)model{
    
    [[self sharedQueue] inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            if (!model.surveyId||model.surveyId.length==0) return;
            [self survey_insertOrUpdate:model dataBase:db];
            for (GDQuestionModel *quesModel in model.questions) {
                if (!quesModel.questionId||quesModel.questionId.length==0) return;
                [self survey_insertOrUpdate:quesModel dataBase:db];
                for (GDOptionModel *optionModel in quesModel.options) {
                    if (!optionModel.optionId||optionModel.optionId.length==0) return;
                    [self survey_insertOrUpdate:optionModel dataBase:db];
                    
                }
            }
            [db close];
        }
    }];
}
//@property (nonatomic,assign) BOOL isHome;
//@property (nonatomic,copy) NSString *surveyId;//问卷ID
//@property (nonatomic,copy) NSString *uid;
//@property (nonatomic,copy) NSString *surveyName;//问卷名称
//@property (nonatomic,copy) NSString *backgroundImageUrl;// 图片路径
//@property (nonatomic,copy) NSString *personTypeId;//sys_condition_list对应表中id---
//@property (nonatomic,copy) NSString *personNum;//如果type为0则填写人数---
////@property (nonatomic,strong) NSMutableArray <GDQuestionModel *>*questionList;
//@property (nonatomic,strong) NSMutableArray <GDQuestionModel *>*questions;
//@property (nonatomic,copy) NSString *cardId;
//@property (nonatomic,copy) NSString *creatorId;
//@property (nonatomic,copy) NSString *surveyStatus;
//@property (nonatomic,copy) NSString *preAnswerTime;
//@property (nonatomic,copy) NSString *createTime;

//@property (copy, nonatomic) NSString *questionId;//本地多表查询使用
//@property (copy, nonatomic) NSString *optionId;
//@property (copy, nonatomic) NSString *optionName;
//@property (copy, nonatomic) NSString *position;
//@property (copy, nonatomic) NSString *cardId;//首页回答问卷使用
//@property (copy, nonatomic) NSString *order;//排序
//@property (copy, nonatomic) NSString *count;
//@property (copy, nonatomic) NSString *imageUrl;
//@property (strong, nonatomic) NSDictionary *orderAndCount;

+ (void)survey_insertOrUpdate:(id)model dataBase:(FMDatabase *)db{
    NSString *sql;
    NSArray *array;
    if ([model isKindOfClass:[GDSurveyModel class]]) {
        GDSurveyModel *surveyModel = (GDSurveyModel *)model;
        sql = @"INSERT OR replace into survey(surveyId, uid, name, imgUrl, personTypeId, personNum) VALUES (?,?,?,?,?,?)";
        array = @[surveyModel.surveyId?:@"",surveyModel.uid?:@"",surveyModel.surveyName?:@"",surveyModel.backgroundImageUrl?:@"",surveyModel.personTypeId?:@"",surveyModel.personNum?:@""];
    }
    else if ([model isKindOfClass:[GDQuestionModel class]]){
        GDQuestionModel *quesModel = (GDQuestionModel *)model;
        sql = @"INSERT OR replace into survey_question(questionId, surveyId, isSkip, imgUrl, questionName, index_s, sort, type) VALUES (?,?,?,?,?,?,?,?)";
        array = @[quesModel.questionId?:@"",quesModel.surveyId?:@"",@(quesModel.isSkip),quesModel.backgroundImageUrl?:@"",quesModel.questionName?:@"",@(quesModel.index),@(quesModel.sort),quesModel.type];

    }else if ([model isKindOfClass:[GDOptionModel class]]){
        GDOptionModel *optionModel = (GDOptionModel *)model;
        sql = @"INSERT OR replace into survey_option(optionId, questionId, optionName, position) VALUES (?,?,?,?)";
        array = @[optionModel.optionId?:@"",optionModel.questionId?:@"",optionModel.optionName?:@"",optionModel.position?:@""];

    }
    
    if (sql) {
        BOOL result = [db executeUpdate:sql withArgumentsInArray:array];
        if (result) {
            NSLog(@"%@+问卷插入数据成功",NSStringFromClass([model class]));
        }else{
            NSLog(@"%@+问卷插入数据失败",NSStringFromClass([model class]));
        }
    }
}

+ (GDSurveyModel *)survey_query:(NSString *)surveyId{
    
    GDSurveyModel *model = [[GDSurveyModel alloc] init];
    NSString *sql = @"select *from survey where surveyId = ?";
    [[self sharedQueue] inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        if ([db open]) {
            FMResultSet *result = [db executeQuery:sql withArgumentsInArray:@[surveyId]];
            while ([result next]) {
                model.surveyId = [result stringForColumn:@"surveyId"];
                model.backgroundImageUrl = [result stringForColumn:@"imgUrl"];
                model.uid = [result stringForColumn:@"uid"];
                model.surveyName = [result stringForColumn:@"name"];
                model.personTypeId = [result stringForColumn:@"personTypeId"];
                model.personNum = [result stringForColumn:@"personNum"];
                model.questions = [self survey_question_query:[result stringForColumn:@"surveyId"] dataBase:db];
            }
            
            [db close];
        }
    }];
    return model;
}

+ (NSMutableArray *)survey_queryAll{//inDatabase里面不能嵌套inDatabase
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *sql = @"select *from survey";
    [[self sharedQueue] inDatabase:^(FMDatabase * _Nonnull db) {
    
        if ([db open]) {
            FMResultSet *result = [db executeQuery:sql];
            while ([result next]) {
                GDSurveyModel *model = [[GDSurveyModel alloc] init];
                model.surveyId = [result stringForColumn:@"surveyId"];
                model.backgroundImageUrl = [result stringForColumn:@"imgUrl"];
                model.uid = [result stringForColumn:@"uid"];
                model.surveyName = [result stringForColumn:@"name"];
                model.personTypeId = [result stringForColumn:@"personTypeId"];
                model.personNum = [result stringForColumn:@"personNum"];
                model.questions = [GDDataBaseManager survey_question_query:model.surveyId dataBase:db];
                [array addObject:model];
            }

            [db close];
        }
    }];
    return array;
}

+ (NSMutableArray *)survey_question_query:(NSString *)surveyId  dataBase:(FMDatabase *)db{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *sql = @"select *from survey_question where surveyId = ?";
    if ([db open]) {
        FMResultSet *result = [db executeQuery:sql withArgumentsInArray:@[surveyId]];
        while ([result next]) {
            GDQuestionModel *model = [[GDQuestionModel alloc] init];
            model.surveyId = [result stringForColumn:@"surveyId"];
            model.backgroundImageUrl = [result stringForColumn:@"imgUrl"];
            model.isSkip = [result stringForColumn:@"isSkip"];
            model.questionName = [result stringForColumn:@"questionName"];
            model.type = [result stringForColumn:@"type"];
            model.index = [result intForColumn:@"index_s"];
            model.sort = [result intForColumn:@"sort"];
            model.questionId = [result stringForColumn:@"questionId"];
            model.options = [self survey_option_query:[result stringForColumn:@"questionId"] dataBase:db];
            [array addObject:model];
        }
        
      //  [db close];
    }

    return array;
    
}


+ (NSMutableArray *)survey_option_query:(NSString *)questionId dataBase:(FMDatabase *)db{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *sql = @"select *from survey_option where questionId = ?";
    if ([db open]) {
        FMResultSet *result = [db executeQuery:sql withArgumentsInArray:@[questionId]];
        while ([result next]) {
            GDOptionModel *model = [[GDOptionModel alloc] init];
            model.questionId = [result stringForColumn:@"questionId"];
            model.optionId = [result stringForColumn:@"optionId"];
            model.position = [result stringForColumn:@"position"];
            model.optionName = [result stringForColumn:@"optionName"];
            [array addObject:model];
        }
        
       // [db close];
    }
    return array;

}

//+ (void)survey_delete:(NSString *)surveyId :(NSString *)questionId{
//    
//    NSString *sql = @"select *from survey where surveyId = ?";
//    NSString *sql_question = @"select *from survey_question where surveyId = ?";
//    NSString *sql_option = @"select *from survey_option where questionId = ?";
//    
//    [[self sharedQueue] inDatabase:^(FMDatabase * _Nonnull db) {
//        if ([db open]) {
//            [db executeUpdate:sql withArgumentsInArray:@[surveyId]];
//            [db executeUpdate:sql_question withArgumentsInArray:@[surveyId]];
//            [db executeUpdate:sql_option withArgumentsInArray:@[questionId]];
//            [db close];
//        }
//    }];
//    
//}

+ (void)survey_delete:(NSString *)surveyId{
    
    NSString *sql = @"delete from survey where surveyId = ?";
    [[self sharedQueue] inDatabase:^(FMDatabase * _Nonnull db) {
        if ([db open]) {
            [db executeUpdate:sql withArgumentsInArray:@[surveyId]];
            [db close];
        }
    }];
    
}

@end

