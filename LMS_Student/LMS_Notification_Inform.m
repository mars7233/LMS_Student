//
//  LMS_Notification_Inform.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Notification_Inform.h"

@interface LMS_Notification_Inform ()

@end

@implementation LMS_Notification_Inform

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ExperimentName.text = [self.listData objectForKey:@"title"];
    self.TeacherName.text = [self.listData objectForKey:@"teacher"];
    self.NotificationTime.text = [self.listData objectForKey:@"date"];
    self.NotificationContent.text = [self.listData objectForKey:@"content"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    //[self dismissViewControllerAnimated:NO completion:nil];
}
@end
