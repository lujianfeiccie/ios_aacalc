//
//  DataItem.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataItem : NSObject
{
    NSInteger _id;
    NSString* _name;
    NSString* _note;
    NSInteger _name_sheet_id;
}
@property NSInteger _id;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSString *_note;
@property NSInteger _name_sheet_id;
-(NSString*) toString;

@end
