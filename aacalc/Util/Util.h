//
//  Util.h
//  aacalc
//
//  Created by Apple on 14-8-23.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject
{
    
}
+(void) showKeyboard:(UIView*) view;
+(void) hideKeyboard:(UIView*) view;
+(void) editingKeyboard:(UIView*) view :(UITextField*) text;
@end
