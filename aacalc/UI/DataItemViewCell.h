//
//  DataItemViewCell.h
//  aacalc
//
//  Created by Apple on 14-4-7.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataItemViewCell : UITableViewCell
@property (retain,nonatomic) IBOutlet UILabel* _txtCost;
@property (retain,nonatomic) IBOutlet UILabel* _txtNote;
@property (nonatomic) double cost;
@property (copy,nonatomic) NSString* note;
@end
