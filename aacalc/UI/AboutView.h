//
//  AboutView.h
//  aacalc
//
//  Created by Apple on 14-4-22.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AboutView : UIViewController
{
    AppDelegate *app;
    __weak IBOutlet UILabel *m_lbl_version;
}
-(void) toolBarBack;
@end
