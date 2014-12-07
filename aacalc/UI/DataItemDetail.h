//
//  DataItemDetail.h
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DialogUtil.h"
@interface DataItemDetail : UIViewController<UITextFieldDelegate,DialogUtilDelegate>
{
    AppDelegate *app;
    NSInteger _dataItemId;
    NSInteger _nameSheetId;
    
    JumpType _jumpType;
    
    __weak IBOutlet UITextField *_txtCost;
    __weak IBOutlet UITextField *_txtNote;
    __weak IBOutlet UIButton *_btnDelete;
    
    IBOutlet UILabel *_lblYuan;
    DialogUtil *m_dialog_add;
    DialogUtil *m_dialog_del_or_modified;
}
-(void) setModel: (NSInteger) dataItemId nameSheetId :(NSInteger) nameSheetId JumpToDo :(JumpType) jumpType;
-(void) toolBarBack;
-(void) toolBarFinish;
- (IBAction)ActionDelete:(id)sender;
-(IBAction)textfieldTouchUpOutside:(id)sender;
@end
