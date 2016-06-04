//
//  mainController.m
//  LMS_Student
//
//  Created by Mars on 16/1/3.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "mainController.h"
#import "LMS_Mine.h"
#import "LMS_Notification.h"
#import "LMS_Optional.h"

@interface mainController ()

@end

@implementation mainController

- (void)viewDidLoad {
    
    self.selectedIndex =1;
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:nil];
    [super viewDidLoad];
    
  
   // NSLog(@"%@",self.ip);

    
    
    // Do any additional setup after loading the view.
}

-(void)registercCompletion:(NSNotification *)notification {
    
    NSDictionary *theData = [notification userInfo];
    NSString *ip = [theData objectForKey:@"ip"];
    self.ip = ip;
    NSLog(@"username = %@",ip);
    
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

@end
