//
//  DialogUtil.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DialogUtil : NSObject
+(void) createAlertDialog: (NSString *)title message:(NSString *)message delegate:(id /*<UIAlertViewDelegate>*/)delegate;
@end
