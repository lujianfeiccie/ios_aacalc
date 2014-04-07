//
//  FormTableViewCell.h
//  aacalc
//
//  Created by Apple on 14-4-6.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormTableViewCell : UITableViewCell
{
    
}
@property(retain,nonatomic) IBOutlet UILabel* _lblFormName;
@property(retain,nonatomic) IBOutlet UILabel* _lblFormTotal;
@property(retain,nonatomic) IBOutlet UILabel* _lblFormAve;
@property(retain,nonatomic) IBOutlet UILabel* _lblFormNumOfPerson;
@property(retain,nonatomic) IBOutlet UIButton* _btnEdit;
@property(copy,nonatomic) NSString* formName;

@property (nonatomic) double formTotal;
@property (nonatomic) double formAve;
@property (nonatomic) NSInteger formNumOfPerson;
@end
