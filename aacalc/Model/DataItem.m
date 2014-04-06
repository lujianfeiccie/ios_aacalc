//
//  DataItem.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DataItem.h"

@implementation DataItem
@synthesize _id;
@synthesize _name;
@synthesize _note;
@synthesize _name_sheet_id;
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%i name=%@ _note=%@ _name_sheet_id=%i",_id,_name,_note,_name_sheet_id];
}
@end
