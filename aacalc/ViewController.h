//
//  ViewController.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface ViewController : UIViewController<UITableViewDelegate,
UITableViewDataSource>
{
    AppDelegate *app;
    __weak IBOutlet UITableView *_tableview;
    NSMutableArray* _datalist;
}
-(IBAction)ActionEdit:(UIControl *)sender event:(id)event;
- (void)toolBarAdd;
@end
