//
//  MyDBManager.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "MyDBManager.h"

@implementation MyDBManager
static MyDBManager *instance;

-(id) init{
    sqlHelper = [SqlHelper getInstance];
    return self;
}

+ (MyDBManager*) getInstance{
    @synchronized(self){
        if (instance==Nil) {
            instance = [[MyDBManager alloc]init];
        }
    }
    return instance;
}
- (bool)createTables
{
    bool result;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR)",TABLE_FORM];
    result= [[sqlHelper getDatabase] executeUpdate:sql];
    
    [self MyLog:[NSString stringWithFormat:@"createTables result=%d",result]];
    return result;
}
- (bool) insertForm:(Form*) form{
    bool result = NO;

    result = [[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(_name) VALUES(?)",TABLE_FORM],[form _name]];
    
    [self MyLog:[NSString stringWithFormat:@"insertForm %@ result=%d",form.toString,result]];
    return result;
}
- (bool) deleteForm:(Form*) form{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_FORM],[form _id]];
    [self MyLog:[NSString stringWithFormat:@"deleteForm %@ result=%d",form.toString,result]];
    return result;
}
- (bool) updateForm:(Form*) form{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET _name=? WHERE _id=?",TABLE_FORM],[form _name],[form _id]];
    [self MyLog:[NSString stringWithFormat:@"updateForm %@ result=%d",form.toString,result]];
    return  result;
}
- (NSMutableArray*) getlist{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_FORM]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        Form *obj = [[Form alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
        [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;
}
-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}

@end
