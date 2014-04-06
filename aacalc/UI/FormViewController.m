//
//  FormViewController.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "FormViewController.h"
#import "ButtonUtil.h"
@interface FormViewController ()

@end

@implementation FormViewController

-(void) back{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) finish{
    [[app navController] popViewControllerAnimated:YES];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //Add the tool bar button
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确定" target:self action:@selector(finish)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
