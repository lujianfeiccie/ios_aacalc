//
//  MyDBManager.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SqlHelper.h"
#import "Form.h"
#import "NameSheet.h"
#import "DataItem.h"
#define TABLE_FORM (@"TB_FORM")  //Form
#define TABLE_NAME_SHEET (@"TB_NAME_SHEET")  //Name sheet
#define TABLE_DATA_ITEM (@"TB_DATA_ITEM")  //Data item

@interface MyDBManager : NSObject
{
    SqlHelper* sqlHelper;
}
+ (MyDBManager*) getInstance;
- (bool)createTables;

///////////////Form///////////////////////////////
- (bool) insertForm:(Form*) form;
- (bool) deleteForm:(Form*) form;
- (bool) deleteFormById:(NSInteger) form_id;
- (bool) updateForm:(Form*) form;
- (NSMutableArray*) getlistForm;
- (Form*) getFormById: (NSInteger) formId;
//////////////////////////////////////////////////

///////////////Name sheet///////////////////////////////
- (bool) insertNameSheet:(NameSheet*) nameSheet;
- (bool) deleteNameSheet:(NameSheet*) nameSheet;
- (bool) deleteNameSheetByForm:(Form*) form;
- (bool) deleteNameSheetByFormId:(NSInteger) form_id;
- (bool) deleteNameSheetById:(NSInteger) id;
- (bool) updateNameSheet:(NameSheet*) nameSheet;
- (NSMutableArray*) getlistNameSheetByForm:(Form*) form;
- (NSMutableArray*) getlistNameSheetByFormId:(NSInteger) form_id;
- (NameSheet*) getNameSheetById:(NSInteger) id;
- (NSMutableArray*) getlistNameSheet;
//////////////////////////////////////////////////

///////////////Data Item///////////////////////////////
- (bool) insertDataItem:(DataItem*) dataItem;
- (bool) deleteDataItem:(DataItem*) dataItem;
- (bool) deleteDataItemById:(NSInteger) id;
- (bool) deleteDataItemByNameSheet:(NameSheet*) nameSheet;
- (bool) deleteDataItemByNameSheetId:(NSInteger) nameSheet_id;
- (bool) updateDataItem:(DataItem*) dataItem;
- (DataItem*) getDataItemById:(NSInteger) id;
- (NSMutableArray*) getlistDataItemByNameSheet:(NameSheet*) nameSheet;
- (NSMutableArray*) getlistDataItemByNameSheetId:(NSInteger) nameSheet_id;
- (NSMutableArray*) getlistDataItem;
//////////////////////////////////////////////////
@end
