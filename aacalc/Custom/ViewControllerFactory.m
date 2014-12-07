//
//  ViewControllerFactory.m
//  Multi_Choice
//
//  Created by mac on 14/12/7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "ViewControllerFactory.h"

@implementation ViewControllerFactory
+(AbstractViewController*) getMultiChoice : (AbstractViewController*) context
{
 return [[context storyboard] instantiateViewControllerWithIdentifier:@"question_view"];
}

+(AbstractViewController*) getShortAnswerOrCalc : (AbstractViewController*) context
{
 return [[context storyboard] instantiateViewControllerWithIdentifier:@"calc_view"];
}

+(AbstractViewController*) getAboutDlg : (AbstractViewController*) context
{
 return [[context storyboard] instantiateViewControllerWithIdentifier:@"about_view"];
}
+(AbstractViewController*) getFeedbackDlg : (AbstractViewController*) context
{
 return [[context storyboard] instantiateViewControllerWithIdentifier:@"feedback_view"];
}
@end