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
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _cost INTEGER, _note VARCHAR,_name_sheet_id INTEGER)",TABLE_DATA_ITEM];
    result= [[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",
                 TABLE_DATA_ITEM,result);

    
    return result;
}

////////////////////////Form/////////////////////////////
- (bool) insertForm:(Form*) form{
    bool result = NO;

    NSString *sql =[NSString stringWithFormat:@"INSERT INTO %@(_name) VALUES('%@')",TABLE_FORM,[form _name]];
    
    result = [[sqlHelper getDatabase] executeUpdate:sql];
    
    NSLogExt(@"%@ result=%d sql=%@",form.toString,result,sql);
    return result;
}
- (bool) deleteForm:(Form*) form{
    bool result ;
    result = [self deleteFormById:[form _id]];
    return result;
}
- (bool) deleteFormById:(NSInteger) form_id{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=%i",TABLE_FORM,form_id]];
    NSLogExt(@"id=%@ result=%d",form_id,result);
    [self deleteNameSheetByFormId:form_id];
    return result;

}
- (bool) updateForm:(Form*) form{
    bool result ;
    NSString* sql = [NSString stringWithFormat:@"UPDATE %@ SET _name='%@' WHERE _id=%i",TABLE_FORM,[form _name],[form _id]];
    result =[[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",form.toString,result,sql);
    return  result;
}
- (NSMutableArray*) getlistForm{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_FORM]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        Form *obj = [[Form alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        //NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;
}

- (Form*) getFormById: (NSInteger) formId{
     FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE _id=%i",TABLE_FORM,formId]];
    
    Form* form = [[Form alloc]init];
    if ([rs next]) {
        form._id = [rs intForColumn:@"_id"];
        form._name = [rs stringForColumn:@"_name"];
    }
    [rs close];
    NSLogExt(form.toString);
    return  form;
}
//////////////////////////////////////////////////////////

//////////////////////////Name sheet////////////////////
- (bool) insertNameSheet:(NameSheet*) nameSheet
{
    bool result = NO;
    
    NSString* sql =[NSString stringWithFormat:@"INSERT INTO %@(_name,_form_id) VALUES('%@',%i)",TABLE_NAME_SHEET,[nameSheet _name],[nameSheet _form_id]];
    
    result = [[sqlHelper getDatabase] executeUpdate:sql];
    
    NSLogExt(@"%@ result=%d sql=%@",nameSheet.toString,result,sql);
    
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
    result = [self deleteNameSheetByFormId:[form _id]];
    return result;
}
- (bool) deleteNameSheetByFormId:(NSInteger) form_id{
    bool result = NO;
    NSMutableArray* datas = [self getlistNameSheetByFormId:form_id];
    
    if([datas count]>0){
        NameSheet *obj = [datas objectAtIndex:0];
        
        result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _form_id=%i",TABLE_NAME_SHEET,form_id]];
        
        //Delete the data item binding to this namesheet
        [self deleteDataItemByNameSheetId:[obj _id]];
    }

    NSLogExt(@"formid=%@ result=%d",form_id,result);
    
    return result;
}
- (bool) updateNameSheet:(NameSheet*) nameSheet
{
    bool result ;
    NSString* sql =[NSString stringWithFormat:@"UPDATE %@ SET _name='%@' WHERE _id=%i",TABLE_NAME_SHEET,[nameSheet _name],[nameSheet _id]];
    result =[[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",nameSheet.toString,result,sql);
    
    return  result;
}

- (NSMutableArray*) getlistNameSheetByForm:(Form*) form;
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _form_id = %i",
                TABLE_NAME_SHEET,[form _id]]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        obj._form_id = [rs intForColumn:@"_form_id"];
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
    NSLogExt(@"formid = %i",form_id);
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        obj._form_id = [rs intForColumn:@"_form_id"];
        NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;
}

- (NameSheet*) getNameSheetById:(NSInteger) id{
    NameSheet* nameSheet = [[NameSheet alloc]init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _id = %i",
                                                             TABLE_NAME_SHEET,id]];
    if([rs next]){
        nameSheet._id = id;
        nameSheet._name = [rs stringForColumn:@"_name"];
        nameSheet._form_id = [rs intForColumn:@"_form_id"];
    }
    [rs close];
    NSLogExt(@"%@ id=%i",nameSheet.toString,id);
    return nameSheet;
}
/////////////////////////////////////////////////////////

///////////////Data Item///////////////////////////////
- (bool) insertDataItem:(DataItem*) dataItem{
    
    bool result = NO;
    NSString* sql =[NSString stringWithFormat:@"INSERT INTO %@(_cost,_note,_name_sheet_id) VALUES(%i,'%@',%i)",TABLE_DATA_ITEM,[dataItem _cost],[dataItem _note],[dataItem _name_sheet_id]];
    result = [[sqlHelper getDatabase] executeUpdate:sql];
    
    NSLogExt(@"%@ result=%d sql=%@",dataItem.toString,result,sql);
    
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
    result =[self deleteDataItemByNameSheetId:[nameSheet _id]];
    return result;
}
- (bool) deleteDataItemByNameSheetId:(NSInteger) nameSheet_id{
    bool result ;
    result =[[sqlHelper getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE _name_sheet_id=%i",TABLE_DATA_ITEM,nameSheet_id]];
    NSLogExt(@"id=%@ result=%d",nameSheet_id,result);
    return result;
}
- (bool) updateDataItem:(DataItem*) dataItem{
    bool result ;
    NSString* sql =[NSString stringWithFormat:@"UPDATE %@ SET _cost=%i,_note='%@' WHERE _id=%i",TABLE_DATA_ITEM,[dataItem _cost],[dataItem _note],[dataItem _id]];
    result =[[sqlHelper getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",dataItem.toString,result,sql);
    return  result;
}
- (NSMutableArray*) getlistDataItemByNameSheet:(NameSheet*) nameSheet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[sqlHelper getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %i",
                                                             TABLE_DATA_ITEM,[nameSheet _id]]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._cost = [rs intForColumn:@"_cost"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._name_sheet_id = [rs intForColumn:@"_name_sheet_id"];
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
        obj._id = [rs intForColumn:@"_id"];
        obj._cost = [rs intForColumn:@"_cost"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._name_sheet_id = [rs intForColumn:@"_name_sheet_id"];
        // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        [list addObject:obj];
    }
    [rs close];
    return list;

}
//////////////////////////////////////////////////

@end
