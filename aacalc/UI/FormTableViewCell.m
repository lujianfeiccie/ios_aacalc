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

@end
