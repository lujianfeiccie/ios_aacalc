//
//  Form.h
//  aacalc
//
//  Created by Apple on 14-4-5.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Form : NSObject
{
    NSString* _id;
    NSString* _name;
}
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *_name;
-(NSString*) toString;
@end
