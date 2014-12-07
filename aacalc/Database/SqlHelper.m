//
//  SqlHelper.m
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import "SqlHelper.h"
#import "NSLogExt.h"

@implementation SqlHelper
- (id) init
{
    if(self=[super init])
    {
        NSLogExt(@"init");
        isOpen = NO;
    }
    return self;
}
- (BOOL) open
{
    if (isOpen)
    {
        return YES;
    }
    NSLogExt(@"open");
    if (![m_db open])
    {
        NSLogExt(@"Could not open db.");
        return NO;
    }
    isOpen = YES;
    [NSTimer scheduledTimerWithTimeInterval:DB_OEPN_INTERVAL target:self selector:@selector(close) userInfo:nil repeats:NO];
    return YES;
}
- (BOOL) close
{
    if(isOpen)
    {
     if (![m_db close])
     {
         NSLogExt(@"Could not close db.");
        return  NO;
     }
        NSLogExt(@"Close");
    }
    isOpen = NO;
    return YES;
}
//获得存放数据库文件的沙盒地址
- (FMDatabase*)getDatabase
{
   
    if (m_db==nil) {
        NSLogExt(@"getDatabase");
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        //dbPath： 数据库路径，在Document中。
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:DB_NAME];
        
        m_db = [FMDatabase databaseWithPath:dbPath];
    }
    [self open];
    return m_db;
}

+ (SqlHelper*) getInstance
{
    static SqlHelper *instance = nil;
    @synchronized(self){
        if (instance == nil) {
             instance = [[SqlHelper alloc] init];
        }
    }
    return instance;
}

-(void) showAllTables{
    NSLogExt(@"showAllTables");
    FMDatabase *db = [self getDatabase];
    FMResultSet *rs = [db executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' ORDER BY name;"];
    
    while ([rs next]) {
        NSLogExt([rs stringForColumn:@"name"]);
    }

    [rs close];
}

@end