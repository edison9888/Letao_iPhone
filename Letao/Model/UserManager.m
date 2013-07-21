//
//  UserManager.m
//  Letao
//
//  Created by Kaibin on 13-6-11.
//  Copyright (c) 2013年 Kaibin. All rights reserved.
//

#import "UserManager.h"
#import "FMDatabase.h"

@implementation UserManager

+ (NSString*) getDBPath
{
    NSString *dbPath  = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                         stringByAppendingPathComponent:@"letao.db"];
    NSLog(@"path=%@",dbPath);
    return dbPath;
}

+ (void)initDatebase
{
    NSString *dbPath = [self getDBPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db");
        return ;
    }
    [db executeUpdate:@"CREATE TABLE IF NOT EXISTS User ();"];
   
    [db close];
}

+ (BOOL)createUserWithUserId:(NSString *)userId
                     loginId:(NSString *)loginId
                 loginIdType:(int)loginIdType
                    nickName:(NSString *)nickName
                      avatar:(NSString *)avatar
                 accessToken:(NSString *)accessToken
           accessTokenSecret:(NSString *)accessTokenSecret
{
    NSString *dbPath = [self getDBPath];
    FMDatabase *db= [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"Could not open db");
        return NO;
    }
    NSString *sql = @"insert into User (userId, loginId, loginIdType, nickName, avatar, accessToken, accessTokenSecret) values (?, ?, ?, ?, ?, ?, ?)";
    BOOL flag = [db executeUpdate:sql, userId, loginId, loginIdType, nickName, accessToken, accessTokenSecret];
    [db close];
    return flag;
}



@end
