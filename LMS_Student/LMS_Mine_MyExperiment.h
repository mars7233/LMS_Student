//
//  LMS_Mine_MyExperiment.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>
//static NSString *docPath;

extern NSString *serveIP;

@interface LMS_Mine_MyExperiment : UIViewController <QLPreviewControllerDataSource,QLPreviewControllerDelegate>


//@property (copy, nonatomic) NSString *docPath;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentData;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentPlace;
@property (weak, nonatomic) IBOutlet UILabel *TeacherName;
@property (weak, nonatomic) IBOutlet UITextView *ExperimentContent;
@property (nonatomic,strong) NSMutableDictionary *listData;
@property (copy ,nonatomic) NSString *ip;
- (IBAction)downLoad:(id)sender;
- (IBAction)Upload:(id)sender;
@end
