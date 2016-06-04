//
//  LMS_Mine.h
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *serveIP;

@interface LMS_Mine : UITableViewController

@property (nonatomic,strong) NSMutableArray* mineObject;
@property (strong,nonatomic) NSMutableDictionary* mineDatas;

@property (copy ,nonatomic) NSString *ip;

- (IBAction)bactToLogin:(id)sender;


-(void)startRequest;
-(void)reloadView:(NSDictionary *)res;

@end
