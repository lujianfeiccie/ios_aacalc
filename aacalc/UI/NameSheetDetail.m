//
//  NameSheetDetail.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NameSheetDetail.h"
#import "ButtonUtil.h"
#import "DialogUtil.h"
#import "MyDBManager.h"
@interface NameSheetDetail ()

@end

@implementation NameSheetDetail

-(void) toolBarBack{
    [[app navController] popViewControllerAnimated:YES];
}
-(void) toolBarFinish{
    MyDBManager *dbmanager = [MyDBManager getInstance];
    
    NameSheet* namesheet = [[NameSheet alloc] init];
    namesheet._form_id = _formId;
    namesheet._name = _txtName.text;
    namesheet._id = _nameSheetId;
    switch (_jumpType) {
        case Add:
        {
            if([dbmanager insertNameSheet:namesheet]){
                [DialogUtil createAlertDialog:@"提示" message:@"添加成功" delegate:self];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"添加失败" delegate:self];
            }
            
        }
            break;
        case Edit:
        {
            if([dbmanager updateNameSheet:namesheet]){
                [DialogUtil createAlertDialog:@"提示" message:@"修改成功" delegate:self];
            }else{
                [DialogUtil createAlertDialog:@"提示" message:@"修改失败" delegate:self];
            }
        }
            break;
        default:
            break;
    }

    [[app navController] popViewControllerAnimated:YES];
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
    switch (_jumpType) {
        case Add:
        {
            self.navigationItem.title = @"新增名单";
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
    
    self.navigationItem.leftBarButtonItem = [ButtonUtil createToolBarButton:@"返回" target:self action:@selector(toolBarBack)];
    
    self.navigationItem.rightBarButtonItem = [ButtonUtil createToolBarButton:@"确定" target:self action:@selector(toolBarFinish)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
