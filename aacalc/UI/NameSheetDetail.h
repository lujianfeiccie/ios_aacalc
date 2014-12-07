//
//  NameSheetDetail.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DialogUtil.h"
@interface NameSheetDetail : UIViewController<DialogUtilDelegate>
{
    AppDelegate *app;
  
    NSInteger _nameSheetId;
    NSInteger _formId;
    JumpType _jumpType;
    __weak IBOutlet UITextField *_txtName;
    __weak IBOutlet UIButton *_btnDelete;
    
    DialogUtil *m_dialog_add;
    DialogUtil *m_dialog_del_or_modified;
}
-(void) setModel: (NSInteger) nameSheetId formId :(NSInteger) formId JumpToDo :(JumpType) jumpType;
-(void) toolBarBack;
-(void) toolBarFinish;
- (IBAction)ActionDelete:(id)sender;
@end
