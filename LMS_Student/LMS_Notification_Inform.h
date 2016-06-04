//
//  LMS_Notification_Inform.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

extern NSString *serveIP;

@interface LMS_Notification_Inform : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;
@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (weak, nonatomic) IBOutlet UILabel *NotificationTime;
@property (weak, nonatomic) IBOutlet UITextView *NotificationContent;
@property (copy ,nonatomic) NSString *ip;

@property (nonatomic,strong) NSDictionary *listData;

@end
