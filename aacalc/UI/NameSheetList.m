//
//  NameSheetViewController.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NameSheetList.h"
#import "NSLogExt.h"
#import "ButtonUtil.h"
#import "NameSheetViewCell.h"
#import "NameSheetDetail.h"
#import "DataItemList.h"
#import "Form.h"
@interface NameSheetList ()

@end

@implementation NameSheetList

-(void) setModel:(NSInteger) formid{
    _formid = formid;
}
-(void) toolBarAdd{
    NSLogExt(@"toolBarAdd");
    
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"namesheet_detail"];
    [((NameSheetDetail*)next) setModel:0 formId:_formid JumpToDo:Add];
    [[app navController] pushViewController:next animated:YES];
}
-(void) toolBarBack{
    NSLogExt(@"toolBarBack");
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
    app = [[UIApplication sharedApplication]delegate];
    
    MyDBManager *dbmanager = [MyDBManager getInstance];
    Form* form = [dbmanager getFormById:_formid];
    NSString* title = [NSString stringWithFormat:@"%@名单",form._name];
    
    self.navigationItem.title =title;
    
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"添加" target:self action:@selector(toolBarAdd)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
   
    
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLogExt(@"viewDidAppear")
    MyDBManager *dbmanager = [MyDBManager getInstance];
    _datalist = [dbmanager getlistNameSheetByFormId:_formid];
   
    [_tableview reloadData];
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [_tableview setFrame:CGRectMake(0, 0,
                                    self.view.frame.size.width,
                                    self.view.frame.size.height)];
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
    static NSString *CustomCellIdentifier = @"NameSheetViewCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"NameSheetViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    NameSheetViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    
    NameSheet* nameSheet = [_datalist objectAtIndex:row];
    
    if (cell==nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"NameSheetViewCell" owner:self options:nil] ;
        cell = [nib objectAtIndex:0];
    }
    cell.sheetName = nameSheet._name;
    cell.sheetTotal = nameSheet._total;
    [cell._btnEdit addTarget:self action:@selector(ActionEdit:event:) forControlEvents:UIControlEventTouchUpInside];
    cell.sheetResult = nameSheet._result;
    return cell;
}
-(IBAction)ActionEdit:(UIControl *)sender event:(id)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchPos = [touch locationInView:_tableview];
    NSIndexPath *indexPath = [_tableview indexPathForRowAtPoint:touchPos];
    if(indexPath != nil){
        //Todo: get model at indexPath, update cell or something other
        NSUInteger row =[indexPath row];
        NameSheet* nameSheet = [_datalist objectAtIndex:row];
        
        UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"namesheet_detail"];
        [((NameSheetDetail*)next) setModel:nameSheet._id formId:_formid JumpToDo:Edit];
        [[app navController] pushViewController:next animated:YES];
    }
}
-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NameSheet* nameSheet =  [_datalist objectAtIndex:row];
    
    
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"dataitem_list"];
    [((DataItemList*)next) setModel:[nameSheet _id]];
     [[app navController] pushViewController:next animated:YES];
    NSLogExt(@"didSelectRowAtIndexPath row=%i",row);
}


@end
