//
//  DataItemList.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DataItemList : UIViewController<UITableViewDelegate,
UITableViewDataSource>
{
    AppDelegate* app;
    __weak IBOutlet UITableView *_tableview;
    NSInteger _nameSheetId;
    NSMutableArray* _datalist;
}
-(void) setModel: (NSInteger) nameSheetId;
-(void) toolBarBack;
-(void) toolBarAdd;
@end
