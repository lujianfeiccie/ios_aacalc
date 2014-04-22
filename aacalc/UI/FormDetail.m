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
#import "DialogUtil.h"
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
        [DialogUtil createAlertDialog:@"提示" message:@"名称不能为空!" delegate:nil];
        return;
    }
    
    
    MyDBManager *dbmanager = [MyDBManager getInstance];
    Form *form = [[Form alloc] init];
    form._id = _form_id;
    form._name = formName;
    
    switch (_jumpType) {
        case Add:
        {
            if([dbmanager insertForm:form]){
                [DialogUtil createAlertDialog:@"提示" message:@"添加成功" delegate:nil];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"添加失败" delegate:nil];
            }

        }
            break;
        case Edit:
        {
            if([dbmanager updateForm:form]){
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
    
    [DialogUtil createDeleteAlertDialog:@"警告" message:@"确定要删除此项?" delegate:self];
}
#pragma marks -- UIAlertViewDelegate --
//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:{
            MyDBManager *dbmanager = [MyDBManager getInstance];
            if ([dbmanager deleteFormById:_form_id]) {
                [DialogUtil createAlertDialog:@"提示" message:@"删除成功" delegate:nil];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"删除失败" delegate:nil];
            }
            [[app navController] popViewControllerAnimated:YES];
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
    NSLogExt(@"viewDidLoad");
	// Do any additional setup after loading the view.
    //Add the tool bar button
    app = [[UIApplication sharedApplication] delegate];
    
    
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
    
    [PlatformUtil ResizeUIToBottom:_btnDelete parentView:self.view]; 
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
