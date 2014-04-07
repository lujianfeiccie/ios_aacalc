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
    NSInteger _id;
    NSString* _name;
    NSInteger _form_id;
    double _total;
    double _result;
}
@property NSInteger _id;
@property NSString *_name;
@property NSInteger _form_id;
@property double _total;
@property double _result;
-(NSString*) toString;
@end
