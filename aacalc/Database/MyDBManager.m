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
    if (self = [super init])
    {
        
    }
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
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR,_total REAL,_ave REAL,_numOfPerson INTEGER)",TABLE_FORM];
    result= [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",
                 TABLE_FORM,result);
    
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _name VARCHAR, _form_id INTEGER,_total REAL,_result REAL)",TABLE_NAME_SHEET];
    result= [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",TABLE_NAME_SHEET,result);
    
    sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS  %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT, _cost REAL, _note VARCHAR,_name_sheet_id INTEGER)",TABLE_DATA_ITEM];
    result= [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d",TABLE_DATA_ITEM,result);

    
    return result;
}

////////////////////////Form/////////////////////////////
- (bool) insertForm:(Form*) form{
    bool result = NO;

    NSString *sql =[NSString stringWithFormat:@"INSERT INTO %@(_name,_total,_ave,_numOfPerson) VALUES('%@',%.1lf,%.1lf,%li)",TABLE_FORM,
                    [form _name],[form _total],[form _ave],(long)[form _numOfPerson]];
    
    result = [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    
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
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=%li",TABLE_FORM,(long)form_id]];
    NSLogExt(@"id=%@ result=%d",form_id,result);
    [self deleteNameSheetByFormId:form_id];
    return result;

}
- (bool) updateForm:(Form*) form{
    bool result ;
    NSString* sql = [NSString stringWithFormat:@"UPDATE %@ SET _name='%@',_total=%.1lf,_ave=%.1lf,_numOfPerson=%li WHERE _id=%li",TABLE_FORM,[form _name],[form _total],[form _ave],(long)[form _numOfPerson],(long)[form _id]];
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",form.toString,result,sql);
    
    
    NSMutableArray* nameSheets = [self getlistNameSheetByForm:form];
    for (NameSheet *obj in nameSheets) {
        double result = form._ave - obj._total;
        obj._result = result;
        [self updateNameSheetFinal:obj];
    }
    return  result;
}
- (NSMutableArray*) getlistForm{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_FORM]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        Form *obj = [[Form alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        obj._total = [rs doubleForColumn:@"_total"];
        obj._ave = [rs doubleForColumn:@"_ave"];
        obj._numOfPerson = [rs intForColumn:@"_numOfPerson"];
        NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;
}

- (Form*) getFormById: (NSInteger) formId{
     FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ WHERE _id=%li",TABLE_FORM,(long)formId]];
    
    Form* form = [[Form alloc]init];
    if ([rs next]) {
        form._id = [rs intForColumn:@"_id"];
        form._name = [rs stringForColumn:@"_name"];
        form._total = [rs doubleForColumn:@"_total"];
        form._numOfPerson = [rs intForColumn:@"_numOfPerson"];
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
    
    NSString* sql =[NSString stringWithFormat:@"INSERT INTO %@(_name,_total,_form_id,_result) VALUES('%@',%.1lf,%li,%.1lf)",TABLE_NAME_SHEET,[nameSheet _name],[nameSheet _total],(long)[nameSheet _form_id],[nameSheet _result]];
    
    result = [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    
    NSLogExt(@"%@ result=%d sql=%@",nameSheet.toString,result,sql);
    
    /////////////////////Calculate for the result/////////////////
    Form* form = [self getFormById:nameSheet._form_id];
    form._numOfPerson += 1;
    form._ave = form._total / (float)form._numOfPerson;
    [self updateForm:form];
    //////////////////////////////////////////////////////
    return  result;
}
- (bool) deleteNameSheet:(NameSheet*) nameSheet
{
    bool result ;
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=?",TABLE_NAME_SHEET],[nameSheet _id]];
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
        
        result =[[[SqlHelper getInstance] getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _form_id=%li",TABLE_NAME_SHEET,(long)form_id]];
        
        //Delete the data item binding to this namesheet
        [self deleteDataItemByNameSheetId:[obj _id]];
    }

    NSLogExt(@"formid=%@ result=%d",form_id,result);
    
    return result;
}
- (bool) deleteNameSheetById:(NSInteger) id{
    
    ////////////Update the form total/////////////
    NameSheet* nameSheet = [self getNameSheetById:id];
    Form* form = [self getFormById:[nameSheet _form_id]];
    form._total-=nameSheet._total;
    form._numOfPerson -=1;
    if(form._numOfPerson>0){
        form._ave = form._total / form._numOfPerson;
    }else{
        form._ave = 0;
    }
    [self updateForm:form];
    /////////////////////////////////////////////////////
    
    bool result = NO;
 
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=%li",TABLE_NAME_SHEET,(long)id]];
        
    //Delete the data item binding to this namesheet
    [self deleteDataItemByNameSheetId:id];
    
    NSLogExt(@"id=%@ result=%d",id,result);
    
   
    return result;

}
- (bool) updateNameSheet:(NameSheet*) nameSheet
{
    bool result ;
    result = [self updateNameSheetFinal:nameSheet];
    
    ////////////Update the Form total/////////////
    double total = 0;
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _form_id = %li",TABLE_NAME_SHEET,(long)[nameSheet _form_id]]];
    
    int count=0;
    while ([rs next]) {
        total += [rs doubleForColumn:@"_total"];
        count++;
    }
    Form* form = [self getFormById:[nameSheet _form_id]];
    form._total = total;
    form._ave = form._total / (float)form._numOfPerson;
    [self updateForm:form];
    /////////////////////////////////////////////////////
    return  result;
}
- (bool) updateNameSheetFinal:(NameSheet*) nameSheet
{
    bool result ;
    NSString* sql =[NSString stringWithFormat:@"UPDATE %@ SET _name='%@',_total=%.1lf,_result=%.1lf WHERE _id=%li",TABLE_NAME_SHEET,[nameSheet _name],[nameSheet _total],[nameSheet _result],(long)[nameSheet _id]];
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",nameSheet.toString,result,sql);
    return  result;
}

- (NSMutableArray*) getlistNameSheetByForm:(Form*) form;
{
    NSMutableArray *list = [self getlistNameSheetByFormId:[form _id]];
    return list;
}
- (NSMutableArray*) getlistNameSheetByFormId:(NSInteger) form_id
{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _form_id = %li",
                                                             TABLE_NAME_SHEET,(long)form_id]];
    NSLogExt(@"formid = %i",form_id);
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        obj._total = [rs doubleForColumn:@"_total"];
        obj._form_id = [rs intForColumn:@"_form_id"];
        obj._result = [rs doubleForColumn:@"_result"];
        NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;
}

- (NameSheet*) getNameSheetById:(NSInteger) id{
    NameSheet* nameSheet = [[NameSheet alloc]init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _id = %li",
                                                             TABLE_NAME_SHEET,(long)id]];
    if([rs next]){
        nameSheet._id = id;
        nameSheet._name = [rs stringForColumn:@"_name"];
        nameSheet._total = [rs doubleForColumn:@"_total"];
        nameSheet._form_id = [rs intForColumn:@"_form_id"];
    }
    [rs close];
    NSLogExt(@"%@ id=%i",nameSheet.toString,id);
    return nameSheet;
}
- (NSMutableArray*) getlistNameSheet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_NAME_SHEET]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        NameSheet *obj = [[NameSheet alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._name = [rs stringForColumn:@"_name"];
        obj._total = [rs doubleForColumn:@"_total"];
        obj._form_id = [rs intForColumn:@"_form_id"];
        obj._result = [rs doubleForColumn:@"_result"];
        [list addObject:obj];
    }
    [rs close];
    return list;
}
/////////////////////////////////////////////////////////

///////////////Data Item///////////////////////////////
- (bool) insertDataItem:(DataItem*) dataItem{
    
    bool result = NO;
    NSString* sql =[NSString stringWithFormat:@"INSERT INTO %@(_cost,_note,_name_sheet_id) VALUES(%.1lf,'%@',%li)",TABLE_DATA_ITEM,[dataItem _cost],[dataItem _note],(long)[dataItem _name_sheet_id]];
    result = [[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    
    NSLogExt(@"%@ result=%d sql=%@",dataItem.toString,result,sql);
    
    ////////////Update the name sheet total/////////////
    NameSheet* nameSheet = [self getNameSheetById:[dataItem _name_sheet_id]];
    nameSheet._total += dataItem._cost;
    [self updateNameSheet:nameSheet];
    /////////////////////////////////////////////////////
    return  result;
}
- (bool) deleteDataItem:(DataItem*) dataItem{
    bool result = [self deleteDataItemById:dataItem._id];
    return result;
}
- (bool) deleteDataItemById:(NSInteger) id{
    bool result ;
    
    ////////////Update the name sheet total/////////////
    DataItem* dataItem = [self getDataItemById:id];
    NameSheet* nameSheet = [self getNameSheetById:dataItem._name_sheet_id];
    nameSheet._total -= dataItem._cost;
    [self updateNameSheet:nameSheet];
    /////////////////////////////////////////////////////
    
    NSString *sql =[NSString stringWithFormat:@"DELETE FROM  %@ WHERE _id=%li",TABLE_DATA_ITEM, (long)id];
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    
    NSLogExt(@"sql=%@ result=%d",sql,result);
    
    
    return result;
}
- (bool) deleteDataItemByNameSheet:(NameSheet*) nameSheet{
    bool result ;
    result =[self deleteDataItemByNameSheetId:[nameSheet _id]];
    return result;
}
- (bool) deleteDataItemByNameSheetId:(NSInteger) nameSheet_id{
  
    bool result ;
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE _name_sheet_id=%li",TABLE_DATA_ITEM,(long)nameSheet_id]];
    NSLogExt(@"id=%@ result=%d",nameSheet_id,result);
    
   
    return result;
}
- (bool) updateDataItem:(DataItem*) dataItem{
    bool result ;
    NSString* sql =[NSString stringWithFormat:@"UPDATE %@ SET _cost=%.1lf,_note='%@' WHERE _id=%li",TABLE_DATA_ITEM,[dataItem _cost],[dataItem _note],(long)[dataItem _id]];
    result =[[[SqlHelper getInstance] getDatabase] executeUpdate:sql];
    NSLogExt(@"%@ result=%d sql=%@",dataItem.toString,result,sql);
    
    ////////////Update the name sheet total/////////////
    double total = 0;
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %li",TABLE_DATA_ITEM,(long)[dataItem _name_sheet_id]]];
    
    while ([rs next]) {
        total += [rs doubleForColumn:@"_cost"];
    }
    NameSheet* nameSheet = [self getNameSheetById:[dataItem _name_sheet_id]];
    nameSheet._total = total;
    [self updateNameSheet:nameSheet];
    /////////////////////////////////////////////////////
    return  result;
}

- (DataItem*) getDataItemById:(NSInteger) id{
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _id = %li",TABLE_DATA_ITEM, (long)id]];
    DataItem* obj = [[DataItem alloc]init];
    if([rs next]){
        obj._name_sheet_id = [rs intForColumn:@"_name_sheet_id"];
        obj._cost = [rs doubleForColumn:@"_cost"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._id = [rs intForColumn:@"_id"];
    }
    return  obj;
}

- (NSMutableArray*) getlistDataItemByNameSheet:(NameSheet*) nameSheet{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %li",
                                                             TABLE_DATA_ITEM,(long)[nameSheet _id]]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._cost = [rs doubleForColumn:@"_cost"];
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
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@ where _name_sheet_id = %li",
                                                             TABLE_DATA_ITEM,(long)nameSheet_id]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._cost = [rs doubleForColumn:@"_cost"];
        obj._note = [rs stringForColumn:@"_note"];
        obj._name_sheet_id = [rs intForColumn:@"_name_sheet_id"];
        // [self MyLog:[NSString stringWithFormat:@"getlist=%@",obj.toString]];
        NSLogExt(@"%@",obj.toString);
        [list addObject:obj];
    }
    [rs close];
    return list;

}
- (NSMutableArray*) getlistDataItem{
    NSMutableArray *list = [[NSMutableArray alloc] init];
    FMResultSet *rs = [[[SqlHelper getInstance] getDatabase] executeQuery:[NSString stringWithFormat:@"SELECT * from %@",TABLE_DATA_ITEM]];
    while ([rs next]) {
        // just print out what we've got in a number of formats.
        DataItem *obj = [[DataItem alloc]init];
        obj._id = [rs intForColumn:@"_id"];
        obj._cost = [rs doubleForColumn:@"_cost"];
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
