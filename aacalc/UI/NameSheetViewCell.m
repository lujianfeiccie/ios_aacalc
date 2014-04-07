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
@synthesize _lblSheetTotal;
@synthesize sheetTotal;
@synthesize _btnEdit;
@synthesize _lblSheetResult;
@synthesize sheetResult;
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
-(void) setSheetTotal:(double)s{
    sheetTotal = s;
    _lblSheetTotal.text = [NSString stringWithFormat:@"出了%.1lf元",s];
}
-(void) setSheetResult:(double)s{
    sheetResult = s;
    NSString *result = @"";
    
    if (s>0) {
        result = [NSString stringWithFormat:@"给%.1lf元",fabs(s)];
    }else{
        result = [NSString stringWithFormat:@"收%.1lf元",fabs(s)];
    }
    _lblSheetResult.text = result;
}
@end
