//
//  SqlHelper.h
//  light_controller
//
//  Created by Apple on 13-11-28.
//  Copyright (c) 2013年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#define DB_NAME (@"user_info.db")
#define DB_OEPN_INTERVAL 10
@interface SqlHelper : NSObject
{
    FMDatabase *db;
    BOOL isOpen;
}
- (BOOL) open;
- (BOOL) close;
- (FMDatabase*)getDatabase;
+ (FMDatabase*) getInstance;
- (void) showAllTables;
@end
