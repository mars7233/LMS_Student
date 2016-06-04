//
//  InformCell.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "InformCell.h"
#import "LMS_Notification_Inform.h"

@implementation InformCell
@synthesize ExperimentName;
@synthesize myExperimentName;
@synthesize ExperimentContent;
@synthesize myExperimentContent;
@synthesize TeacherName;
@synthesize myTeacherName;
@synthesize NotificationData;
@synthesize myNotificationData;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


/*
- (IBAction)Notification_Inform:(id)sender {
    LMS_Notification_Inform *notificationInform = [[LMS_Notification_Inform alloc]init];
    [notificationInform viewDidLoad];
    [ pushViewController:notificationInform animated:NO];
}*/
@end
