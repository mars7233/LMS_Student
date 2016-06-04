//
//  ViewController.m
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_login.h"
#import "mainController.h"


@interface LMS_Login ()

@end

@implementation LMS_Login

- (void)viewDidLoad {
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [super viewDidLoad];
    
    self.ipLabel.text = @"192.168.1.3:8080";
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender {
    
    
    
    if ([self.userName.text isEqualToString:@""]&&![self.userKey.text isEqualToString:@""]&&![self.ipLabel.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没填用户名啊魂淡"
                                                        message:@"快填！"
                                                       delegate:self
                                              cancelButtonTitle:@"是的大王！"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else if([self.userKey.text isEqualToString:@""]&&![self.userName.text isEqualToString:@""]&&![self.ipLabel.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没填密码啊魂淡"
                                                        message:@"快填！"
                                                       delegate:self
                                              cancelButtonTitle:@"是的大王！"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else if([self.ipLabel.text isEqualToString:@""]&&![self.userName.text isEqualToString:@""]&&![self.userKey.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没填ip啊魂淡"
                                                        message:@"快填！"
                                                       delegate:self
                                              cancelButtonTitle:@"是的大王！"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }else if([self.userName.text isEqualToString:@""]&&[self.userKey.text isEqualToString:@""]&&[self.ipLabel.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你什么都没填啊魂淡"
                                                            message:@"快填！"
                                                            delegate:self
                                                cancelButtonTitle:@"是的大王！"
                                                otherButtonTitles:nil, nil];
            [alert show];
 
    }else if(![self.userName.text isEqualToString:@""]&&![self.userKey.text isEqualToString:@""]&&![self.ipLabel.text isEqualToString:@""]){
        
        //注册通知者
        NSDictionary *dataDict = [NSDictionary dictionaryWithObject:self.ipLabel.text forKey:@"ip"];
        NSLog(@"%@",dataDict);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RegisterCompletionNotification"
                                                            object:nil
                                                        userInfo:dataDict];
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        mainController *myExperiment = [storyboard instantiateViewControllerWithIdentifier:@"main_Controller"];
        
        serveIP = [[NSString alloc] initWithFormat:@"%@",self.ipLabel.text];
        
        
        [self presentViewController:myExperiment animated:YES completion:nil];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"你肯定有东西没填啊魂淡"
                                                        message:@"快填！"
                                                       delegate:self
                                              cancelButtonTitle:@"是的大王！"
                                              otherButtonTitles:nil, nil];
        [alert show];

        
    }
        


 
 
 
}

@end
