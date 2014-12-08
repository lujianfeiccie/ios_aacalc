//
//  NameSheetDetail.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NameSheetDetail.h"
#import "ButtonUtil.h"
#import "PlatformUtil.h"
#import "MyDBManager.h"
@interface NameSheetDetail ()

@end

@implementation NameSheetDetail

-(void) toolBarBack{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarFinish{
    NSString* name = [_txtName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([name isEqualToString:@""] ||
        name == nil) {
      //  [DialogUtil createAlertDialog:@"提示" message:@"姓名不能为空!" delegate:nil];
        m_dialog_add.delegate = nil;
        [m_dialog_add showDialogTitle:@"提示" message:@"姓名不能为空!" confirm:@"知道了"];
        return;
    }
    MyDBManager *dbmanager = [MyDBManager getInstance];
    
    NameSheet* namesheet = [[NameSheet alloc] init];
    namesheet = [dbmanager getNameSheetById:_nameSheetId];
    namesheet._form_id = _formId;
    namesheet._name = name;
    switch (_jumpType) {
        case Add:
        {
            m_dialog_add.delegate = self;
            if([dbmanager insertNameSheet:namesheet]){
                [m_dialog_add showDialogTitle:@"提示" message:@"添加成功" confirm:@"知道了"];
            }else{
                [m_dialog_add showDialogTitle:@"提示" message:@"添加失败" confirm:@"知道了"];
            }
            
        }
            break;
        case Edit:
        {
            m_dialog_add.delegate = self;
            if([dbmanager updateNameSheet:namesheet]){
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

- (IBAction)ActionDelete:(id)sender {
    //[DialogUtil createDeleteAlertDialog:@"警告" message:@"确定要删除?" delegate:self];
    [m_dialog_del_or_modified showDialogTitle:@"警告" message:@"确定要删除?" confirm:@"确定" cancel:@"取消"];
    m_dialog_del_or_modified.delegate = self;
}

#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    dialog.delegate = nil;
    if (dialog == m_dialog_del_or_modified) {
        MyDBManager *dbmanager = [MyDBManager getInstance];
        
        DialogUtil *tmp_dialog = [[DialogUtil alloc]init];
        if([dbmanager deleteNameSheetById:_nameSheetId]){
            [tmp_dialog showDialogTitle:@"提示" message:@"删除成功" confirm:@"知道了"];
        }else{
             [tmp_dialog showDialogTitle:@"提示" message:@"删除失败" confirm:@"知道了"];
        }
        tmp_dialog = nil;
        [[app navController] popViewControllerAnimated:YES];
    }
    else if (dialog == m_dialog_add)
    {
        [[app navController] popViewControllerAnimated:YES];
    }
    
}
-(void) onDialogCancelClick : (DialogUtil*) dialog
{
    
}
-(void) setModel: (NSInteger) nameSheetId formId :(NSInteger) formId JumpToDo :(JumpType) jumpType{
    _formId = formId;
    _nameSheetId = nameSheetId;
    _jumpType = jumpType;
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
    m_dialog_add = [[DialogUtil alloc]init];
    m_dialog_del_or_modified = [[DialogUtil alloc]init];
    switch (_jumpType) {
        case Add:
        {
            self.navigationItem.title = @"新增名单";
            [_btnDelete setHidden:YES];
        }
            break;
        case Edit:
        {
            self.navigationItem.title = @"编辑名单";
            
            MyDBManager *dbmanager = [MyDBManager getInstance];
            NameSheet* obj = [dbmanager getNameSheetById:_nameSheetId];
            _txtName.text = obj._name;
        }
            break;
        default:
            break;
    }
    
   // self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确定" target:self action:@selector(toolBarFinish)];
}
-(void) viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [PlatformUtil ResizeUIAll:self.view];
    [PlatformUtil ResizeUIToFullWidth:_txtName parentView:self.view];
    [PlatformUtil ResizeUIToBottom:_btnDelete parentView:self.view];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [_txtName release];
    [_btnDelete release];
    [m_dialog_add release];
    [m_dialog_del_or_modified release];
    [super dealloc];
}
@end
