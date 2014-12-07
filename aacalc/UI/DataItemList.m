//
//  DataItemList.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DataItemList.h"
#import "ButtonUtil.h"
#import "DataItemViewCell.h"
#import "DataItemDetail.h"
#import "NSLogExt.h"
@interface DataItemList ()

@end

@implementation DataItemList
-(void) setModel: (NSInteger) nameSheetId{
    _nameSheetId = nameSheetId;
}

-(void) toolBarBack{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarAdd{
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"dataitem_detail"];
    [((DataItemDetail*)next) setModel:0 nameSheetId:_nameSheetId JumpToDo:Add];
    [[app navController] pushViewController:next animated:YES];
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
    MyDBManager* dbmanager = [MyDBManager getInstance];
    NameSheet* nameSheet = [dbmanager getNameSheetById:_nameSheetId];

    NSString* title = [NSString stringWithFormat:@"%@的消费",nameSheet._name];
    self.navigationItem.title = title;
    
    
    app = [[UIApplication sharedApplication]delegate];
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
 
     self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"添加" target:self action:@selector(toolBarAdd)];
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
   }
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    MyDBManager *dbmanager = [MyDBManager getInstance];
    _datalist = [dbmanager getlistDataItemByNameSheetId:_nameSheetId];

    [_tableview reloadData];
}
-(void)viewDidLayoutSubviews{
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
    static NSString *CustomCellIdentifier = @"DataItemViewCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"DataItemViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    DataItemViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    
    DataItem* dataItem = [_datalist objectAtIndex:row];
    
    if (cell==nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"DataItemViewCell" owner:self options:nil] ;
        cell = [nib objectAtIndex:0];
    }
   /* [PlatformUtil ResizeUILeftHalf:cell._txtCost parentView:self.view offsetLeft:0 offsetRight:0];
    [PlatformUtil ResizeUIRightHalf:cell._txtNote parentView:self.view offsetLeft:0 offsetRight:0];
    */
    cell.note = dataItem._note;
    cell.cost = dataItem._cost;
    //NSLogExt(@"%@",dataItem.toString);
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    DataItem* dataItem =  [_datalist objectAtIndex:row];
    
    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"dataitem_detail"];
    [((DataItemDetail*)next) setModel:[dataItem _id] nameSheetId:_nameSheetId JumpToDo:Edit];
    [[app navController] pushViewController:next animated:YES];

    NSLogExt(@"didSelectRowAtIndexPath row=%i",row);
}
- (void)dealloc{
    [_tableview release];
    [_datalist release];
    [super dealloc];
}
@end
