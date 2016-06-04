//
//  LMS_Mine_MyExperiment_Upload.h
//  LMS_Student
//
//  Created by Mars on 16/1/2.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *serveIP;

@interface LMS_Mine_MyExperiment_Upload : UITableViewController<UIAlertViewDelegate>

@property (nonatomic ,strong) NSMutableDictionary *listData;
@property (nonatomic, strong) NSMutableArray* uploadObject;
@property (copy ,nonatomic) NSString *ip;
@property (nonatomic, strong) NSString *filePath;

@end
