//
//  GradeCell.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "GradeCell.h"

@implementation GradeCell
@synthesize Grade;
@synthesize myGrade;
@synthesize ExperimentName;
@synthesize myExperimentName;
@synthesize NotificationData;
@synthesize myNotificationData;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
