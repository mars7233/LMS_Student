//
//  LMS_Notification.h
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "mainController.h"

extern NSString *serveIP;

@interface LMS_Notification : UITableViewController<UITableViewDataSource,UITableViewDelegate>
- (IBAction)backToLogin:(id)sender;

@property (nonatomic,strong) NSMutableArray* notificationObject;
@property (strong,nonatomic) NSMutableDictionary* notificationDatas;
@property (copy ,nonatomic) NSString *ip;

-(void)startRequest;
-(void)reloadView:(NSDictionary *)res;




@end
