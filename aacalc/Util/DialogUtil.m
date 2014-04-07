//
//  DialogUtil.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DialogUtil.h"

@implementation DialogUtil
+(void) createAlertDialog: (NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    alert = nil;
}
+(void) createDeleteAlertDialog: (NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
    alert = nil;
}
@end
