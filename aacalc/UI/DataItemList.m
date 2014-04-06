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
@interface DataItemList ()

@end

@implementation DataItemList
-(void) toolBarBack{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarFinish{
    
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
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.title = @"消费列表";
     self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"添加" target:self action:@selector(toolBarFinish)];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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
    static NSString *CustomCellIdentifier = @"NameSheetViewCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"NameSheetViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    DataItemViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    
    NameSheet* nameSheet = [_datalist objectAtIndex:row];
    
    if (cell==nil) {
        NSArray * nib = [[NSBundle mainBundle] loadNibNamed:@"DataItemViewCell" owner:self options:nil] ;
        cell = [nib objectAtIndex:0];
    }
   // cell.sheetName = nameSheet._name;
    
    return cell;
}

-(GLfloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
//    NameSheet* nameSheet =  [_datalist objectAtIndex:row];
//    
//    
//    UIViewController *next = [[self storyboard] instantiateViewControllerWithIdentifier:@"dataitem_list"];
//    //    [((NameSheetDetail*)next) setModel:nameSheet._id formId:_formid JumpToDo:Edit];
//    [[app navController] pushViewController:next animated:YES];
//    NSLogExt(@"didSelectRowAtIndexPath row=%i",row);
}

@end
