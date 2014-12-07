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
    CGFloat _total;
    CGFloat _result;
}
@property(nonatomic) NSInteger _id;
@property(nonatomic,retain) NSString *_name;
@property NSInteger _form_id;
@property CGFloat _total;
@property CGFloat _result;
-(NSString*) toString;
@end
