//
//  ViewController.h
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ipip.h"

extern NSString *serveIP;

@interface LMS_Login : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipLabel;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userKey;

- (IBAction)logIn:(id)sender;


@end

