//
//  DataItemDetail.m
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DataItemDetail.h"
#import "ButtonUtil.h"

#import "PlatformUtil.h"
#import "DataItem.h"
#import "NSLogExt.h"
#import "Util.h"
#define NUMBERS @"0123456789."
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
    
    NSString* cost =  [_txtCost.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([cost isEqualToString:@""] ||
       cost == nil){
        [m_dialog_add showDialogTitle:@"提示" message:@"消费金额不能为空!" confirm:@"知道了"];
        return;
    }
    MyDBManager *dbmanager = [MyDBManager getInstance];
    DataItem *dataItem = [[DataItem alloc] init];
    dataItem._id = _dataItemId;
    dataItem._note = _txtNote.text;
    dataItem._cost = [cost doubleValue];
    dataItem._name_sheet_id = _nameSheetId;
    
    switch (_jumpType) {
        case Add:
        {
            m_dialog_add.delegate = self;
            if([dbmanager insertDataItem:dataItem])
            {
                [m_dialog_add showDialogTitle:@"提示" message:@"添加成功" confirm:@"知道了"];
            }else{
                [m_dialog_add showDialogTitle:@"提示" message:@"添加失败" confirm:@"知道了"];
            }
            
        }
            break;
        case Edit:
        {
            m_dialog_add.delegate = self;
            if([dbmanager updateDataItem:dataItem]){
                [m_dialog_add showDialogTitle:@"提示" message:@"修改成功" confirm:@"知道了"];
            }else{
                [m_dialog_add showDialogTitle:@"提示" message:@"修改失败" confirm:@"知道了"];
            }
        }
            break;
        default:
            break;
    }
   

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSCharacterSet *cs;
    if(textField == _txtCost)
    {
        cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERS] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if(!basicTest)
        {
            [m_dialog_add showDialogTitle:@"提示" message:@"请输入数字!" confirm:@"知道了"];
            return NO;
        }
        
        NSString* tmp=[NSString stringWithFormat:@"%@%@",_txtCost.text,string];
        NSArray *split = [tmp componentsSeparatedByString:@"."];
        NSInteger numOfDot = [split count]-1;
        if(numOfDot>1){
            [m_dialog_add showDialogTitle:@"提示" message:@"超过一个小数点可不行哦!" confirm:@"知道了"];
            return NO;
        }
//        NSLogExt(@"dot length=%i str=%@",[firstSplit count],tmp);
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
}
- (IBAction)ActionDelete:(id)sender {
    [m_dialog_del_or_modified showDialogTitle:@"警告" message:@"确定要删除?" confirm:@"知道了" cancel:@"取消"];
    m_dialog_del_or_modified.delegate = self;
}
#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    dialog.delegate = nil;
    if (dialog == m_dialog_del_or_modified) {
        
        MyDBManager *dbmanager = [MyDBManager getInstance];
          DialogUtil *tmp_dialog = [[DialogUtil alloc]init];
        if([dbmanager deleteDataItemById:_dataItemId]){
            [tmp_dialog showDialogTitle:@"提示" message:@"删除成功" confirm:@"知道了"];
        }else{
            [tmp_dialog showDialogTitle:@"提示" message:@"删除失败" confirm:@"知道了"];
        }
        tmp_dialog = nil;
        [[app navController] popViewControllerAnimated:YES];
    }
    else if (dialog == m_dialog_add){
         [[app navController] popViewControllerAnimated:YES];
    }
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    
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
    m_dialog_add = [[DialogUtil alloc] init];
    m_dialog_del_or_modified = [[DialogUtil alloc] init];
    //触摸其它地方让键盘隐藏
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textfieldTouchUpOutside:)];
    [self.view addGestureRecognizer:singleTap];
    
    _txtCost.delegate = self;
    _txtNote.delegate = self;
    
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
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [PlatformUtil ResizeUIAll:self.view];
    [PlatformUtil ResizeUIToFullWidth:_txtNote parentView:self.view];
    [PlatformUtil ResizeUIToFullWidth:_txtCost parentView:self.view];
    [PlatformUtil ResizeUIToRight:_lblYuan parentView:self.view
                          offsetX:self.view.frame.size.width - _txtCost.frame.size.width - _txtCost.frame.origin.x * 2];
    [PlatformUtil ResizeUIToBottom:_btnDelete parentView:self.view];
}

-(IBAction)textfieldTouchUpOutside:(id)sender
{
    [Util hideKeyboard:self.view];
    
    [_txtCost resignFirstResponder];
    [_txtNote resignFirstResponder];
}

// 当点击键盘的返回键（右下角）时，执行该方法。
// 一般用来隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    [Util hideKeyboard:self.view];
    
    [textField resignFirstResponder];
    return YES;
}
- (void)keyboardWillShow:(NSNotification *)noti
{
    [Util showKeyboard:self.view];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [Util editingKeyboard:self.view :textField];
}
#pragma mark -
- (void)dealloc{
    [_lblYuan release];
    [_txtCost release];
    [_txtNote release];
    [_btnDelete release];
    [m_dialog_del_or_modified release];
    [m_dialog_add release];
    [super dealloc];
}
@end
