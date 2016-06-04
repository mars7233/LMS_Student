//
//  MineCell.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ExperimentName;//experimentName
@property (copy ,nonatomic) NSString *myEpxerimentName;
@property (weak, nonatomic) IBOutlet UILabel *ExperimentContent;//content
@property (copy ,nonatomic) NSString *myExperimentContent;
@property (weak, nonatomic) IBOutlet UILabel *Deadline;//date
@property (copy ,nonatomic) NSString *myDeadline;

@end
