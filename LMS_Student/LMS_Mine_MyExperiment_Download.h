//
//  LMS_Mine_MyExperiment_Download.h
//  LMS_Student
//
//  Created by Mars on 16/1/2.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

extern NSString *serveIP;

@interface LMS_Mine_MyExperiment_Download : UITableViewController<QLPreviewControllerDataSource,QLPreviewControllerDelegate>

@property (nonatomic ,strong) NSMutableDictionary *listData;
@property (nonatomic ,strong) NSMutableArray *downloadObject;
@property (copy ,nonatomic) NSString *ip;
@property (nonatomic ,strong) NSString *filePath;

@end
