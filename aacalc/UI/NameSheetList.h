//
//  NameSheetViewController.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "NameSheetList.h"

@interface NameSheetList : UIViewController<UITableViewDelegate,
UITableViewDataSource>
{
    AppDelegate* app;
    __weak IBOutlet UITableView *_tableview;
    NSMutableArray* _datalist;
    NSInteger _formid;
}
-(void) toolBarAdd;
-(void) toolBarBack;
-(void) setModel:(NSInteger) formid;
@end
