//
//  MineCell.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

@synthesize ExperimentName;
@synthesize myEpxerimentName;
@synthesize ExperimentContent;
@synthesize myExperimentContent;
@synthesize Deadline;
@synthesize myDeadline;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
