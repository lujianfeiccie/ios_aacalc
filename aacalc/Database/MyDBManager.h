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
- (bool) updateForm:(Form*) form;
- (NSMutableArray*) getlistForm;
//////////////////////////////////////////////////

///////////////Name sheet///////////////////////////////
- (bool) insertNameSheet:(NameSheet*) nameSheet;
- (bool) deleteNameSheet:(NameSheet*) nameSheet;
- (bool) deleteNameSheetByForm:(Form*) form;
- (bool) updateNameSheet:(NameSheet*) nameSheet;
- (NSMutableArray*) getlistNameSheetByForm:(Form*) form;
- (NSMutableArray*) getlistNameSheetByFormId:(NSInteger) form_id;
//////////////////////////////////////////////////

///////////////Data Item///////////////////////////////
- (bool) insertDataItem:(NameSheet*) nameSheet;
- (bool) deleteDataItem:(NameSheet*) nameSheet;
- (bool) deleteDataItemByNameSheet:(Form*) form;
- (bool) updateDataItem:(NameSheet*) nameSheet;
- (NSMutableArray*) getlistDataItemByNameSheet:(Form*) form;
- (NSMutableArray*) getlistDataItemByNameSheetId:(NSInteger) form_id;
//////////////////////////////////////////////////
@end
