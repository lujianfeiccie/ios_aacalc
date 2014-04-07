//
//  FormTableViewCell.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "FormTableViewCell.h"

@implementation FormTableViewCell
@synthesize _lblFormName;
@synthesize formName;
@synthesize _lblFormTotal;
@synthesize formTotal;
@synthesize _lblFormAve;
@synthesize formAve;
@synthesize _lblFormNumOfPerson;
@synthesize formNumOfPerson;
@synthesize _btnEdit;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setFormName:(NSString*) c{
    if(![c isEqualToString:formName]){
        formName = [c copy];
        _lblFormName.text = formName;
    }
}

-(void)setFormTotal:(double)f{
    //if (f!= formTotal) {
        formTotal = f;
        _lblFormTotal.text = [NSString stringWithFormat:@"总消费 %.1lf元",f];
   // }
}
-(void)setFormAve:(double)f{
    formAve = f;
    _lblFormAve.text = [NSString stringWithFormat:@"平均消费 %.1lf元",f];
}
-(void)setFormNumOfPerson:(NSInteger)f{
    formNumOfPerson = f;
    _lblFormNumOfPerson.text = [NSString stringWithFormat:@"%i人行",f];
}
@end
