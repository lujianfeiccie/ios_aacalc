//
//  NameSheetViewCell.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameSheetViewCell : UITableViewCell
@property(retain,nonatomic) IBOutlet UILabel* _lblSheetName;
@property(retain,nonatomic) IBOutlet UILabel* _lblSheetTotal;
@property(retain,nonatomic) IBOutlet UIButton* _btnEdit;
@property(retain,nonatomic) IBOutlet UILabel* _lblSheetResult;
@property(copy,nonatomic) NSString* sheetName;
@property(nonatomic) CGFloat sheetTotal;
@property(nonatomic) CGFloat sheetResult;
@end
