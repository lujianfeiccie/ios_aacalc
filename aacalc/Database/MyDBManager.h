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
#define TABLE_FORM (@"TB_FORM")  //Form

@interface MyDBManager : NSObject
{
    SqlHelper* sqlHelper;
}
+ (MyDBManager*) getInstance;
- (bool)createTables;

///////////////
- (bool) insertForm:(Form*) form;
- (bool) deleteForm:(Form*) form;
- (bool) updateForm:(Form*) form;
- (NSMutableArray*) getlist;
@end
