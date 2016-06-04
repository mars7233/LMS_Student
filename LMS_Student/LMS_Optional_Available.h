//
//  LMS_Optional_Available.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *serveIP;

@interface LMS_Optional_Available : UIViewController<UIAlertViewDelegate>

- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentData;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentPlace;
@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (weak, nonatomic) IBOutlet UITextView *ExperimentContent;
@property (nonatomic,strong) NSMutableDictionary *listData;

@property (copy ,nonatomic) NSString *ip;
- (IBAction)bespoke:(id)sender;

@end
