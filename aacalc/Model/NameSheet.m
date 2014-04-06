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
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%i name=%@ formid=%i",_id,_name,_form_id];
}
@end
