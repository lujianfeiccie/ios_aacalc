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
    NSString* _id;
    NSString* _name;
    NSString* _note;
    NSString* _name_sheet_id;
}
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSString *_note;
@property (nonatomic, retain) NSString *_name_sheet_id;
-(NSString*) toString;

@end
