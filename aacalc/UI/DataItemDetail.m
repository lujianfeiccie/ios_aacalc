//
//  DataItemDetail.m
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DataItemDetail.h"
#import "ButtonUtil.h"
#import "DialogUtil.h"
#import "DataItem.h"
@interface DataItemDetail ()

@end

@implementation DataItemDetail

-(void) setModel: (NSInteger) dataItemId nameSheetId :(NSInteger) nameSheetId JumpToDo :(JumpType) jumpType
{
    _dataItemId = dataItemId;
    _nameSheetId = nameSheetId;
    _jumpType = jumpType;
}
-(void) toolBarBack
{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarFinish
{
    MyDBManager *dbmanager = [MyDBManager getInstance];
    DataItem *dataItem = [[DataItem alloc] init];
    dataItem._id = _dataItemId;
    dataItem._note = _txtNote.text;
    dataItem._cost =     [[_txtCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] doubleValue];
    dataItem._name_sheet_id = _nameSheetId;
    
    switch (_jumpType) {
        case Add:
        {
            if([dbmanager insertDataItem:dataItem]){
                [DialogUtil createAlertDialog:@"提示" message:@"添加成功" delegate:nil];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"添加失败" delegate:nil];
            }
            
        }
            break;
        case Edit:
        {
            if([dbmanager updateDataItem:dataItem]){
                [DialogUtil createAlertDialog:@"提示" message:@"修改成功" delegate:nil];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"修改失败" delegate:nil];
            }
        }
            break;
        default:
            break;
    }
    [[app navController] popViewControllerAnimated:YES];

}

- (IBAction)ActionDelete:(id)sender {
    [DialogUtil createDeleteAlertDialog:@"警告" message:@"确定要删除?" delegate:self];
}
#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            MyDBManager *dbmanager = [MyDBManager getInstance];
            
            if([dbmanager deleteDataItemById:_dataItemId]){
                [DialogUtil createAlertDialog:@"提示" message:@"删除成功" delegate:nil];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"删除失败" delegate:nil];
            }
            [[app navController] popViewControllerAnimated:YES];
        }
            break;
        case 1:{
           // [[app navController] popViewControllerAnimated:YES];
        }
            break;
        default:
            break;
    }
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
    app = [[UIApplication sharedApplication] delegate];
    
    
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确定" target:self action:@selector(toolBarFinish)];
    
    switch (_jumpType) {
        case Add:
        {
            self.navigationItem.title=@"新增消费项";
            [_btnDelete setHidden:YES];
        }
            break;
        case Edit:
        {
            self.navigationItem.title=@"编辑消费项";
            MyDBManager *dbmanager = [MyDBManager getInstance];
            DataItem* dataItem = [dbmanager getDataItemById:_dataItemId];
            _txtCost.text = [NSString stringWithFormat:@"%.1lf",[dataItem _cost]];
            _txtNote.text = [dataItem _note];
        }
            break;
        default:
            break;
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
