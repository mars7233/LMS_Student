//
//  LMS_Optional.h
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *serveIP;

@interface LMS_Optional : UITableViewController

@property (nonatomic,strong) NSMutableArray* optionalObject;
@property (strong,nonatomic) NSMutableDictionary* optionalDatas;

- (IBAction)bactToLogin:(id)sender;

@property (copy ,nonatomic) NSString *ip;

@end
