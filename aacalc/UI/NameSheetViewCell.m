//
//  NameSheetViewCell.m
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import "NameSheetViewCell.h"

@implementation NameSheetViewCell
@synthesize _lblSheetName;
@synthesize sheetName;
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
-(void) setSheetName:(NSString*) s{
    if (![s isEqualToString:sheetName]) {
        sheetName = [s copy];
        _lblSheetName.text = s;
    }
}
@end
