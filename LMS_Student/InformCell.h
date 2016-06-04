//
//  InformCell.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InformCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;
@property (copy, nonatomic) NSString *myExperimentName;

@property (weak, nonatomic) IBOutlet UILabel *ExperimentContent;
@property (copy, nonatomic) NSString *myExperimentContent;

@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (copy, nonatomic) NSString *myTeacherName;

@property (weak, nonatomic) IBOutlet UILabel *NotificationData;
@property (copy, nonatomic) NSString *myNotificationData;

//- (IBAction)Notification_Inform:(id)sender;
@end
