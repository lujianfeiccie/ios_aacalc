//
//  FormViewController.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "FormDetail.h"
#import "ButtonUtil.h"
#import "MyDBManager.h"
#import "PlatformUtil.h"
#import "NSLogExt.h"
@interface FormDetail ()

@end

@implementation FormDetail

-(void) setModel: (NSInteger) form_id JumpToDo :(JumpType) jumpType{
    _form_id = form_id;
    _jumpType = jumpType;
}
-(void) toolBarBack{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarFinish{
    NSString* formName = [_txtFormName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([formName isEqualToString:@""] ||
        formName == nil) {
        m_dialog_add.delegate = nil;
        [m_dialog_add showDialogTitle:@"提示" message:@"名称不能为空" confirm:@"知道了"];
        return;
    }
    
    
    MyDBManager *dbmanager = [MyDBManager getInstance];
    Form *form = [[Form alloc] init];
    form = [dbmanager getFormById:_form_id];
    form._name = formName;
    
    switch (_jumpType) {
        case Add:
        {
            m_dialog_add.delegate = self;
            if([dbmanager insertForm:form]){

                 [m_dialog_add showDialogTitle:@"提示" message:@"添加成功" confirm:@"知道了"];
            }else{
                 [m_dialog_add showDialogTitle:@"提示" message:@"添加失败" confirm:@"知道了"];
            }

        }
            break;
        case Edit:
        {
            m_dialog_add.delegate = self;
            if([dbmanager updateForm:form]){
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
    [m_dialog_del_or_modified showDialogTitle:@"警告" message:@"确定要删除此项?" confirm:@"确定"  cancel:@"取消"];
    m_dialog_del_or_modified.delegate = self;
}

#pragma marks -- DialogUtilDelegate --
-(void) onDialogConfirmClick : (DialogUtil*) dialog
{
    dialog.delegate = nil;
    if (dialog == m_dialog_del_or_modified)
    {
        MyDBManager *dbmanager = [MyDBManager getInstance];
        
        DialogUtil *tmp_dialog = [[DialogUtil alloc]init];
        if ([dbmanager deleteFormById:_form_id])
        {
            [tmp_dialog showDialogTitle:@"提示" message:@"删除成功" confirm:@"知道了"];
        }else
        {
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
-(void) onDialogTextReceive : (DialogUtil*) dialog Text :(NSString*) text
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
    NSLogExt(@"viewDidLoad");
	// Do any additional setup after loading the view.
    //Add the tool bar button
    app = [[UIApplication sharedApplication] delegate];
    m_dialog_add = [[DialogUtil alloc]init];
    m_dialog_del_or_modified = [[DialogUtil alloc] init];
    
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确定" target:self action:@selector(toolBarFinish)];

    switch (_jumpType) {
        case Add:
        {
            self.navigationItem.title=@"新增游记";
            [_btnDelete setHidden:YES];
        }
            break;
        case Edit:
        {
            self.navigationItem.title=@"编辑游记";
            MyDBManager *dbmanager = [MyDBManager getInstance];
            Form* form = [dbmanager getFormById:_form_id];
            _txtFormName.text = [form _name];
        }
            break;
        default:
            break;
    }

}
-(void)viewDidLayoutSubviews{
    [PlatformUtil ResizeUIAll:self.view];
    [PlatformUtil ResizeUIToFullWidth:_txtFormName parentView:self.view];
    [PlatformUtil ResizeUIToBottom:_btnDelete parentView:self.view]; 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc{
    [_txtFormName release];
    [_btnDelete release];
    [m_dialog_add release];
    [m_dialog_del_or_modified release];
    [super dealloc];
}
@end
