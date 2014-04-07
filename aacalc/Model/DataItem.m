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
@synthesize _cost;
@synthesize _note;
@synthesize _name_sheet_id;

-(id)init{
    _id = 0;
    _cost = 0;
    _note = @"";
    _name_sheet_id = 0;
    return  self;
}
-(NSString*) toString{
    return [NSString stringWithFormat:@"id=%i cost=%.1lf _note=%@ _name_sheet_id=%i",_id,_cost,_note,_name_sheet_id];
}
@end
