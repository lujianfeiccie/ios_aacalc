//
//  NameSheetDetail.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NameSheetDetail : UIViewController
{
    AppDelegate *app;
    __weak IBOutlet UITextField *_txtName;
    NSInteger _nameSheetId;
    NSInteger _formId;
    JumpType _jumpType;
}
-(void) setModel: (NSInteger) nameSheetId formId :(NSInteger) formId JumpToDo :(JumpType) jumpType;
-(void) toolBarBack;
-(void) toolBarFinish;
@end
