//
//  AppDelegate.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "NSLogExt.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{


    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    /*UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    UIImage *image_temp = [UIImage imageNamed:@"Default.png"];
    [image setImage:image_temp];
    [self.window addSubview:image];*/
    
    storyBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
   // [NSThread sleepForTimeInterval:2];

    //[self MyLog:[NSString stringWithFormat:@"%f",[[[UIDevice currentDevice] systemVersion] floatValue]]];
   
    ViewController *rootView =  [storyBoard instantiateViewControllerWithIdentifier:@"rootview"];
    self.navController = [[UINavigationController alloc] init];
    [self.navController pushViewController:rootView animated:YES];
    [self.navController setToolbarHidden:YES];//底部隐藏
    // [self.navController setNavigationBarHidden:NO];//顶部 隐藏
    // self.navController.navigationBar.backgroundColor = [OtherTool //hexStringToColor:@"#000000"];
    //[[self.navController.navigationBar] setBackgroundImage:[UIImage //imageNamed:@"small_circle.png"]];
    //[self.navController.navigationBar setBackgroundImage:[UIImage imageNamed:@"title_bar.png"] forBarMetrics:UIBarMetricsDefault];
    [self.window addSubview:self.navController.view];
    [self.window makeKeyAndVisible];
    
    ///Create database and create tables
     dbmanager = [MyDBManager getInstance];
    [dbmanager createTables];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
