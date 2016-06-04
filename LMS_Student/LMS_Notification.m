//
//  LMS_Notification.m
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Notification.h"
#import "InformCell.h"
#import "GradeCell.h"
#import "LMS_Notification_Inform.h"
//#import "ipip.h"



@interface LMS_Notification ()

@end

@implementation LMS_Notification


- (void)viewDidLoad {
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置滑动
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [super viewDidLoad];
    
    
    NSLog(@"ip =%@",serveIP);
    
    //初始化cell
    static NSString *informCellIdentifier = @"Notification_Inform";
    static NSString *gradeCellIdentifier = @"Notification_Grade";
    NSLog(@"Init InformCell");
    
    UINib *nib = [UINib nibWithNibName:@"InformCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:informCellIdentifier];
    nib = [UINib nibWithNibName:@"GradeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:gradeCellIdentifier];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
      //[self.navigationController pushViewController:notificationInform animated:YES ];
    [self startRequest];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
}

-(void)registercCompletion:(NSNotification *)notification {
    
    NSDictionary *theData = [notification userInfo];
    NSString *ip = [theData objectForKey:@"ip"];
    self.ip = ip;
    NSLog(@"username = %@",ip);
    
}

-(void) refreshTableView
{
    if(self.refreshControl.refreshing){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self startRequest];
    }
}

- (IBAction) tappedRightButton:(id)sender

{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    
    
    NSArray *aryViewController = self.tabBarController.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex + 1];
                
            }
            
        }];
        
    }
    
    
    
}



- (IBAction) tappedLeftButton:(id)sender

{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    
    
    if (selectedIndex > 0) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
                
            }
            
        }];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startRequest
{
    //请求数据
    NSString *netPath = [[NSString alloc]initWithFormat:@"/lms/announcement/teaching?studentId=1"];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serveIP customHeaderFields:nil];
    MKNetworkOperation *op = [engine operationWithPath:netPath];
    
    [op addCompletionHandler:^(MKNetworkOperation *operation){
        
       // NSLog(@"responseData:%@",[operation responseString]);
        NSData *data = [operation responseData];
        NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data
                                                                options:NSJSONReadingAllowFragments
                                                                  error:nil];
        [self reloadView:resDict];
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* err){
        NSLog(@"MKNetwork请求错误:%@",[err localizedDescription]);
    }];
    [engine enqueueOperation:op];
}


-(void)reloadView:(NSDictionary *)res
{
    
    NSNumber *resultCode = [res objectForKey:@"statusCode"];
    if([resultCode integerValue] == 200){
        //停止刷新
        [self.refreshControl endRefreshing];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];

        NSMutableDictionary *data = [res objectForKey:@"data"];
        self.notificationObject =[data objectForKey:@"array"];
        NSLog(@"Notification有%lu个",(unsigned long)[self.notificationObject count]);
        NSString *message = [res objectForKey:@"message"];
        NSLog(@"%@",message);
        self.notificationObject = [[self.notificationObject reverseObjectEnumerator] allObjects];
        [self.tableView reloadData];
        
    }else {
        [self.refreshControl endRefreshing];
        NSString *errorStr = [res objectForKey:@"message"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误信息"
                                                            message:errorStr
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.notificationObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSUInteger row = [indexPath row];
    NSDictionary*  dict = [self.notificationObject objectAtIndex:row];
    
    NSNumber *type = [dict objectForKey:@"type"];
 
    static NSString *informCellIdentifier = @"Notification_Inform";
    static NSString *gradeCellIdentifier = @"Notification_Grade";

    if ([type  integerValue] == 1) {
        InformCell *informCell = [tableView dequeueReusableCellWithIdentifier:informCellIdentifier];
        self.tableView.rowHeight = 113;
        
        informCell.ExperimentName.text = [dict objectForKey:@"title"];
        informCell.ExperimentContent.text = [dict objectForKey:@"content"];
        informCell.TeacherName.text = [dict objectForKey:@"teacyer"];
        informCell.NotificationData.text = [dict objectForKey:@"date"];
        
        return informCell;
        
    }else{
        GradeCell *gradeCell = [tableView dequeueReusableCellWithIdentifier:gradeCellIdentifier];
        self.tableView.rowHeight = 98;
        

        gradeCell.ExperimentName.text = [dict objectForKey:@"title"];
        gradeCell.Grade.text = [dict objectForKey:@"content"];
        gradeCell.NotificationData.text = [dict objectForKey:@"date"];
    
        return gradeCell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary*  dict = [self.notificationObject objectAtIndex:row];
    
    NSLog(@"anleyixia");
    
    NSNumber *type = [dict objectForKey:@"type"];
    if ([type integerValue]==1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LMS_Notification_Inform *notificationInform = [storyboard instantiateViewControllerWithIdentifier:@"Notification_Inform"];
        
        
        [self.navigationController pushViewController:notificationInform animated:YES];
        notificationInform.listData = dict;
        
}

    
}


- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

