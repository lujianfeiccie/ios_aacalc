//
//  SqlHelper.m
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "SqlHelper.h"


@implementation SqlHelper

static SqlHelper *instance;


- (id) init{
    [self MyLog:@"init"];
    isOpen = NO;
    return self;
}
- (BOOL) open{
    if (isOpen) {
        return YES;
    }
     [self MyLog:@"open"];
    if (![db open]) {
        [self MyLog:@"Could not open db."];
        return NO;
    }
    isOpen = YES;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(close) userInfo:nil repeats:NO];
    return YES;
}
- (BOOL) close
{
    if(isOpen){
     if (![db close]) {
        [self MyLog:@"Could not close db."];
        return  NO;
     }
    [self MyLog:@"Close"];
    }
    isOpen = NO;
    return YES;
}
//获得存放数据库文件的沙盒地址
- (FMDatabase*)getDatabase
{
   
    if (db==nil) {
         [self MyLog:@"getDatabase"];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:DB_NAME];
        
        db = [FMDatabase databaseWithPath:dbPath];
    }
    [self open];
    return db;
}

+ (SqlHelper*) getInstance
{
    @synchronized(self){
        if (instance == nil) {
             instance = [[SqlHelper alloc] init];
        }
    }
    return instance;
}

-(void) showAllTables{
    [self MyLog:@"showAllTables"];
    FMDatabase *db = [self getDatabase];
   FMResultSet *rs = [db executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"];
    
    while ([rs next]) {
       [self MyLog:[rs stringForColumn:@"name"]];
    }

    [rs close];
}

-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end