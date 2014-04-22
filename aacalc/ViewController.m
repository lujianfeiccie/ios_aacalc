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
#import "FormTableViewCell.h"
#import "FormDetail.h"
#import "NameSheetList.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)toolBarAdd{
    NSLogExt(@"toolBarAdd");
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"form_add_edit"];
    [((FormDetail*)next) setModel:0 JumpToDo:Add];
    [[app navController] pushViewController:next animated:YES];
//    MyDBManager *dbmanager = [MyDBManager getInstance];
//    NSLogExt(@"form count=%i",[[dbmanager getlistForm] count]);
//    NSLogExt(@"namesheet count=%i",[[dbmanager getlistNameSheet] count]);
//    NSLogExt(@"dataitem count=%i",[[dbmanager getlistDataItem] count]);
}
-(void) toolBarAbout{
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"about_view"];
    [[app navController] pushViewController:next animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLogExt(@"viewDidLoad");
    
    
	// Do any additional setup after loading the view, typically from a nib.
    app = [[UIApplication sharedApplication] delegate];
    //Add the tool bar button
    self.navigationItem.title = @"游记";
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"添加" target:self action:@selector(toolBarAdd)];

    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"关于" target:self action:@selector(toolBarAbout)];
    MyDBManager *dbmanager = [MyDBManager getInstance];
    _datalist = [dbmanager getlistForm];
    
   
    _tableview.delegate = self;
    _tableview.dataSource = self;
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLogExt(@"viewDidAppear");
    MyDBManager *dbmanager = [MyDBManager getInstance];
    _datalist = [dbmanager getlistForm];
        [_tableview reloadData];
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLogExt(@"viewDidLayoutSubviews");
    [_tableview setFrame:CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height)];
  //  NSLogExt(@"width = %f height=%f nav height=%f",self.view.frame.size.width,self.view.frame.size.height,self.navigationController.navigationBar.bounds.size.height)

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //  [self MyLog:[NSString stringWithFormat:@"didReceiveMemoryWarning count=%d",[self.datalist count]]];
    return [_datalist count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CustomCellIdentifier = @"FormTableViewCellIdentifier";
    
    static BOOL nibsRegistered = NO;
     if (!nibsRegistered) {
         UINib *nib = [UINib nibWithNibName:@"FormTableViewCell" bundle:nil];
         [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
         nibsRegistered = YES;
     }
    FormTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    if (cell==nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"FormTableViewCell" owner:self options:nil] ;
        cell = [nib objectAtIndex:0];
    }
    
    NSUInteger row = [indexPath row];
    
    Form* form = [_datalist objectAtIndex:row];
    
    cell.formName = form._name;
    cell.formTotal = form._total;
    cell.formAve = form._ave;
    cell.formNumOfPerson = form._numOfPerson;
    [cell._btnEdit addTarget:self action:@selector(ActionEdit:event:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(IBAction)ActionEdit:(UIControl *)sender event:(id)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPos = [touch locationInView:_tableview];
    NSIndexPath *indexPath = [_tableview indexPathForRowAtPoint:touchPos];
    if(indexPath != nil){
        //Todo: get model at indexPath, update cell or something other
        NSUInteger row =[indexPath row];
        Form* form = [_datalist objectAtIndex:row];
        
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"form_add_edit"];
        [((FormDetail*)next) setModel:form._id JumpToDo:Edit];
        [[app navController] pushViewController:next animated:YES];
    }
}

-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
   Form* form =  [_datalist objectAtIndex:row];
    
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"namesheet_list"];
    [((NameSheetList*)next) setModel:form._id];
    [[app navController] pushViewController:next animated:YES];
    
        NSLogExt(@"didSelectRowAtIndexPath row=%i",row);
}
@end
