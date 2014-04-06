//
//  ViewController.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "SqlHelper.h"
#import "MyDBManager.h"
#import "ButtonUtil.h"
#import "NSLogExt.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)toolBarAdd{
    NSLogExt(@"toolBarAdd");
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"form_add_edit"];
    [[app navController] pushViewController:next animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLogExt(@"viewDidLoad");
    
    
	// Do any additional setup after loading the view, typically from a nib.
    app = [[UIApplication sharedApplication] delegate];
    //Add the tool bar button
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"添加" target:self action:@selector(toolBarAdd)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
