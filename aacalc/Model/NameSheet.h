//
//  NameSheet.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameSheet : NSObject
{
    NSString* _id;
    NSString* _name;
    NSString* _form_id;
}
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *_name;
@property (nonatomic, retain) NSString *_form_id;
-(NSString*) toString;
@end
