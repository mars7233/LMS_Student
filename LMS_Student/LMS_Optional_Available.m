//
//  LMS_Optional_Available.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Optional_Available.h"

@interface LMS_Optional_Available ()

@end

@implementation LMS_Optional_Available

- (void)viewDidLoad {
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],UITextAttributeTextColor,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[self startRequest];
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.ExperimentName.text = [self.listData objectForKey:@"experimentName"];
    self.ExperimentContent.text = [self.listData objectForKey:@"content"];
    self.ExperimentPlace.text = [self.listData objectForKey:@"labRoom"];
    self.ExperimentData.text = [self.listData objectForKey:@"date"];
    self.TeacherName.text = [self.listData objectForKey:@"teacher"];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *path = [[NSString alloc] initWithFormat:@"/lms/lession/bookTheExperiment"];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        
        NSString *planID = [self.listData objectForKey:@"id"];
        [param setValue:planID forKey:@"experimentPlanId"];
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serveIP customHeaderFields:nil];
        MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
        
        [op addCompletionHandler:^(MKNetworkOperation *operation){
        }errorHandler:^(MKNetworkOperation *errorOp, NSError* err){
            NSLog(@"MKNetwork请求错误:%@",[err localizedDescription]);
        }];
        
        [engine enqueueOperation:op];
        
        [self dismissViewControllerAnimated:YES completion:^(){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"预约成功!"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
        [alertView show];
    

        

        }];
    }
}



- (IBAction)bespoke:(id)sender{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确定预约此实验嘛？"
                                                        message:@"确定预约此实验嘛？"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    [alertView show];
}
    
@end
