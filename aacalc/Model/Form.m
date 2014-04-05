//
//  Form.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "Form.h"

@implementation Form
@synthesize _id;
@synthesize _name;
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%@ name=%@",_id,_name];
}
@end
