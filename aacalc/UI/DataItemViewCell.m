//
//  DataItemViewCell.m
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "DataItemViewCell.h"
#import "PlatformUtil.h"
@implementation DataItemViewCell
@synthesize _txtCost;
@synthesize _txtNote;
@synthesize cost;
@synthesize note;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
   /* [PlatformUtil ResizeUILeftHalf:_txtCost parentView:self offsetLeft:0 offsetRight:0];
    [PlatformUtil ResizeUIRightHalf:_txtNote parentView:self offsetLeft:0 offsetRight:0];*/
    //self.backgroundView.frame = CGRectMake(0, 0, 640, 44);
   // self.selectedBackgroundView.frame = CGRectMake(9, 0, 302, 44);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) setCost:(double)c{
    cost = c;
    _txtCost.text = [NSString stringWithFormat:@"%.1lf元",c];
}
-(void) setNote:(NSString *)n{
    if (![n isEqualToString:note]) {
        note = [n copy];
        _txtNote.text = n;
    }
}
@end
