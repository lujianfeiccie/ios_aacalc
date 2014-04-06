//
//  AppDelegate.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyDBManager.h"

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
