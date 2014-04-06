//
//  MyDBManager.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "MyDBManager.h"
#import "NSLogExt.h"
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
    NSLogExt(@"%@ result=%d",
                 TABLE_FORM,result);
    
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR, _form_id INTEGER)",TABLE_NAME_SHEET];
    result= [[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",
                 TABLE_NAME_SHEET,result);
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR, _note VARCHAR,_name_sheet_id INTEGER)",TABLE_DATA_ITEM];
    result= [[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",
                 TABLE_DATA_ITEM,result);

    
    return result;
}

////////////////////////Form/////////////////////////////
- (bool) insertForm:(Form*) form{
    bool result = NO;

    result = [[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(_name) VALUES(?)",TABLE_FORM],[form _name]];
    
    NSLogExt(@"%@ result=%d",form.toString,result);
    return result;
}
- (bool) deleteForm:(Form*) form{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_FORM],[form _id]];
    NSLogExt(@"%@ result=%d",form.toString,result);
    
    [self deleteNameSheetByForm:form];
    return result;
}
- (bool) updateForm:(Form*) form{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET _name=? WHERE _id=?",TABLE_FORM],[form _name],[form _id]];
    NSLogExt(@"%@ result=%d",form.toString,result);
    return  result;
}
- (NSMutableArray*) getlistForm{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_FORM]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        Form *obj = [[Form alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
       // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;
}

//////////////////////////////////////////////////////////

//////////////////////////Name sheet////////////////////
- (bool) insertNameSheet:(NameSheet*) nameSheet
{
    bool result = NO;
    
    result = [[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(_name,_form_id) VALUES(?,?)",TABLE_NAME_SHEET],[nameSheet _name],[nameSheet _form_id]];
    
    NSLogExt(@"%@ result=%d",nameSheet.toString,result);
    
    return  result;
}
- (bool) deleteNameSheet:(NameSheet*) nameSheet
{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_NAME_SHEET],[nameSheet _id]];
    NSLogExt(@"%@ result=%d",nameSheet.toString,result);
    return result;
}
- (bool) deleteNameSheetByForm:(Form*) form
{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _form_id=?",TABLE_NAME_SHEET],[form _id]];
    NSLogExt(@"%@ result=%d",form.toString,result);
    return result;
}
- (bool) updateNameSheet:(NameSheet*) nameSheet
{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET _name=? WHERE _id=?",TABLE_NAME_SHEET],[nameSheet _name],[nameSheet _id]];
    NSLogExt(@"%@ result=%d",nameSheet.toString,result);
    
    return  result;
}

- (NSMutableArray*) getlistNameSheetByForm:(Form*) form;
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _form_id = %@",
                TABLE_NAME_SHEET,[form _id]]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
        obj._form_id = [rs stringForColumn:@"_form_id"];
        // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;
}
- (NSMutableArray*) getlistNameSheetByFormId:(NSInteger) form_id
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _form_id = %i",
                                                             TABLE_NAME_SHEET,form_id]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
        obj._form_id = [rs stringForColumn:@"_form_id"];
        NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;
}
/////////////////////////////////////////////////////////

///////////////Data Item///////////////////////////////
- (bool) insertDataItem:(DataItem*) dataItem{
    
    bool result = NO;
    
    result = [[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(_name,_note,_name_sheet_id) VALUES(?,?,?)",TABLE_DATA_ITEM],[dataItem _name],[dataItem _note],[dataItem _name_sheet_id]];
    
    NSLogExt(@"%@ result=%d",dataItem.toString,result);
    
    return  result;
}
- (bool) deleteDataItem:(DataItem*) dataItem{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_DATA_ITEM],[dataItem _id]];
    NSLogExt(@"%@ result=%d",dataItem.toString,result);
    return result;
}
- (bool) deleteDataItemByNameSheet:(NameSheet*) nameSheet{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _name_sheet_id=?",TABLE_DATA_ITEM],[nameSheet _id]];
    NSLogExt(@"%@ result=%d",nameSheet.toString,result);
    return result;

}
- (bool) updateDataItem:(DataItem*) dataItem{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET _name=?,_note=? WHERE _id=?",TABLE_DATA_ITEM],[dataItem _name],[dataItem _note],[dataItem _id]];
    NSLogExt(@"%@ result=%d",dataItem.toString,result);
    return  result;
}
- (NSMutableArray*) getlistDataItemByNameSheet:(NameSheet*) nameSheet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %@",
                                                             TABLE_DATA_ITEM,[nameSheet _id]]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._name_sheet_id = [rs stringForColumn:@"_name_sheet_id"];
        // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;

}
- (NSMutableArray*) getlistDataItemByNameSheetId:(NSInteger) nameSheet_id{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %i",
                                                             TABLE_DATA_ITEM,nameSheet_id]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [NSString stringWithFormat:@"%d",[rs intForColumn:@"_id"]];
        obj._name = [rs stringForColumn:@"_name"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._name_sheet_id = [rs stringForColumn:@"_name_sheet_id"];
        // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;

}
//////////////////////////////////////////////////

@end
