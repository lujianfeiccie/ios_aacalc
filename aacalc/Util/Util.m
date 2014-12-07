//
//  Util.m
//  Multi_Choice
//
//  Created by Apple on 14-8-25.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Util.h"
#import "NSLogExt.h"
@implementation Util
+(void) setLabelToAutoSize:(UILabel*) label{
    [label setNumberOfLines:0];
  //  label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = NSTextAlignmentLeft;
    
    CGSize maximumSize = CGSizeMake(300, CGFLOAT_MAX); // 第一个参数是label的宽度，第二个参数是固定的宏定义，CGFLOAT_MAX
    /*CGSize expectedLabelSize = [label.text sizeWithFont:label.font
                                 constrainedToSize:maximumSize
                                     lineBreakMode:NSLineBreakByWordWrapping];*/
    //UILineBreakModeWordWrap
    
    CGSize expectedLabelSize = [label.text
        boundingRectWithSize:maximumSize
        options:NSStringDrawingUsesLineFragmentOrigin
        attributes:@{NSFontAttributeName:label.font
                    }
        context:nil].size;
    
    CGRect newFrame = label.frame;
    newFrame.size.width = 320;
    newFrame.size.height = expectedLabelSize.height;
    label.frame = newFrame;
    [label sizeToFit];
}

+(NSUInteger*) getRandomNumOfOut:(NSUInteger) numOfOut NumOfIn : (NSUInteger) numOfIn
{
    //NSLogExt(@"getRandom %i %i",numOfOut,numOfIn);
    NSUInteger* randnum = (NSUInteger*)malloc(sizeof(NSUInteger)*numOfOut);
    memset(randnum, -1, sizeof(NSUInteger)*numOfOut);
    /*for (NSUInteger i=0; i<numOfOut; i++) {
        NSLogExt(@"%i %i",i,randnum[i]);
    }*/
    bool repeat;
    for (int i=0; i<numOfOut; i++)
    {
        repeat = NO;
        NSUInteger num = arc4random() % (numOfIn);
       // NSLogExt(@"num=%i",num);

        for (int j=0; j<numOfOut; j++)
        {
            //NSLogExt(@"num=%i random[%i]=%i",num,j,randnum[j]);
            if (randnum[j]==num)
            {
                repeat = YES;
                
                break;
            }
        }
        if (repeat==NO)
        {
            randnum[i]=num;
       //    NSLogExt(@"num[%i]=%i",i,num);
        }
        else
        {
            --i;
        }
    }

    return randnum;
}

+(NSString*) getDate
{
    //获得系统日期
    NSDate *  senddate=[NSDate date];
    
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year=[conponent year];
    NSInteger month=[conponent month];
    NSInteger day=[conponent day];
    
    NSString *  nsDateString= [NSString  stringWithFormat:@"%4ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    
    return  nsDateString;
}

+(BOOL) isTimeToCheckVersion
{
    //获得系统时间
    //获得系统日期
    NSDate *  senddate=[NSDate date];
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger hour=[conponent hour];
    
    if (hour > 9 && hour < 18)//working hour
    {
        return YES;
    }
    else if(hour > 21 && hour < 24)//home hour
    {
        return  YES;
    }
    return  NO;
}

+(BOOL) containString : (NSString*) str1 :(NSString*) str2
{
    NSRange range = [str1 rangeOfString:str2];
    return range.length;
}

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
