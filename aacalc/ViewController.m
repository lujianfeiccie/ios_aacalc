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
@interface ViewController ()

@end

@implementation ViewController

- (void)timego{
    [self MyLog:@"timego"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
        [self MyLog:@"viewDidLoad"];
	// Do any additional setup after loading the view, typically from a nib.
//   SqlHelper *sql = [SqlHelper getInstance];
//    [sql createTables];
//    [sql showAllTables];
    
  
  
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) MyLog: (NSString*) msg{
#if defined(LOG_DEBUG)
    NSLog(@"%@ %@",NSStringFromClass([self class]),msg);
#endif
}
@end