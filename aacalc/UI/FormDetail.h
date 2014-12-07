//
//  FormViewController.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DialogUtil.h"
@interface FormDetail: UIViewController<DialogUtilDelegate>
{
    AppDelegate* app;
    __weak IBOutlet UITextField *_txtFormName;
    NSInteger _form_id;
    JumpType _jumpType;
    __weak IBOutlet UIButton *_btnDelete;
    DialogUtil *m_dialog_add;
    DialogUtil *m_dialog_del_or_modified;
}
-(void) setModel: (NSInteger) form_id JumpToDo :(JumpType) jumpType;
-(void) toolBarBack;
-(void) toolBarFinish;
- (IBAction)ActionDelete:(id)sender;
@end
