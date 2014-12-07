//
//  ViewControllerFactory.h
//  Multi_Choice
//
//  Created by mac on 14/12/7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractViewController.h"
@interface ViewControllerFactory : NSObject
+(AbstractViewController*) getMultiChoice : (AbstractViewController*) context;


+(AbstractViewController*) getShortAnswerOrCalc : (AbstractViewController*) context;

+(AbstractViewController*) getAboutDlg : (AbstractViewController*) context;

+(AbstractViewController*) getFeedbackDlg : (AbstractViewController*) context;
@end
