//
//  GradeCell.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Grade;
@property (copy ,nonatomic) NSString *myGrade;

@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;
@property (copy ,nonatomic) NSString *myExperimentName;

@property (weak, nonatomic) IBOutlet UILabel *NotificationData;
@property (copy ,nonatomic) NSString *myNotificationData;
@end
