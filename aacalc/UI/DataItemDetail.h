//
//  DataItemDetail.h
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DataItemDetail : UIViewController<UITextViewDelegate>
{
    AppDelegate *app;
    __weak IBOutlet UITextField *_txtCost;
    __weak IBOutlet UITextField *_txtNote;
   
    NSInteger _dataItemId;
    NSInteger _nameSheetId;
    JumpType _jumpType;
    __weak IBOutlet UIButton *_btnDelete;
}
-(void) setModel: (NSInteger) dataItemId nameSheetId :(NSInteger) nameSheetId JumpToDo :(JumpType) jumpType;
-(void) toolBarBack;
-(void) toolBarFinish;
- (IBAction)ActionDelete:(id)sender;
-(IBAction)textfieldTouchUpOutside:(id)sender;
@end
