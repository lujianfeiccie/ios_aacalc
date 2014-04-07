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
    NSInteger _id;
    NSString* _name;
    double _total;
    double _ave;
    NSInteger _numOfPerson;
}
@property NSInteger _id;
@property (nonatomic, retain) NSString *_name;
@property double _total;
@property double _ave;
@property NSInteger _numOfPerson;
-(NSString*) toString;
@end
