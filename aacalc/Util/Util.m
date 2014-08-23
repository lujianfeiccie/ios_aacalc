//
//  Util.m
//  aacalc
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Util.h"

@implementation Util
+(void) showKeyboard:(UIView*) view{
    //键盘输入的界面调整
    //键盘的高度
    float height = 216.0;
    CGRect frame = view.frame;
    frame.size = CGSizeMake(frame.size.width, frame.size.height - height);
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [view setFrame:frame];
    [UIView commitAnimations];
}
+(void) hideKeyboard:(UIView*) view{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 20.0f, view.frame.size.width, view.frame.size.height);
    view.frame = rect;
    [UIView commitAnimations];
}
+(void) editingKeyboard:(UIView*) view :(UITextField*) text
{
    CGRect frame = text.frame;
    int offset = frame.origin.y + 32 - (view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = view.frame.size.width;
    float height = view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        view.frame = rect;
    }
    [UIView commitAnimations];
}
@end
