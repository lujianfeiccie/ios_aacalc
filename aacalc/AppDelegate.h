//
//  AppDelegate.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDBManager.h"
#import "ViewControllerFactory.h"
#import "DialogUtil.h"
#import "HttpRequestTool.h"
#import "ButtonUtil.h"
#import "PlatformUtil.h"
#import "SVProgressHUD.h"
#import "NSLogExt.h"
#import "VersionCheckTool.h"
typedef enum{
    Add,
    Edit
}JumpType;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MyDBManager *dbmanager ;
    UIStoryboard *storyBoard;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@end
