//
//  NameSheet.m
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NameSheet.h"

@implementation NameSheet
@synthesize _id;
@synthesize _name;
@synthesize _form_id;
@synthesize _total;
@synthesize _result;
-(id)init{
    _name = @"";
    _total = 0;
    _form_id = 0;
    _id = 0;
    _result = 0;
    return  self;
}
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%i name=%@ total=%.1lf formid=%i result=%.1lf",_id,_name,_total,_form_id,_result];
}
@end
