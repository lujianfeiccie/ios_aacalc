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
@synthesize _total;
@synthesize _ave;
@synthesize _numOfPerson;
-(id) init{
    _name = @"";
    _total = 0;
    _id = 0;
    _ave = 0;
    _numOfPerson = 0;
    return  self;
}
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%li name=%@ total=%.1lf ave=%.1lf num Of person=%li",(long)_id,_name,_total,_ave,(long)_numOfPerson];
}
@end
