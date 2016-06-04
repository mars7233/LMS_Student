//
//  LMS_Optional.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Optional.h"
#import "LMS_Optional_Available.h"
#import "OptionalCell.h"

@interface LMS_Optional ()

@end

@implementation LMS_Optional

- (void)viewDidLoad {
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    [super viewDidLoad];
    
   // NSLog(@"ip =%@",self.ip);
    
    //初始化cell
    
    static NSString *mineCellIdentifier = @"Optional";
    
    UINib *nib = [UINib nibWithNibName:@"OptionalCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:mineCellIdentifier];
    NSLog(@"Init OptionalCell");
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self startRequest];
    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;

}
-(void) refreshTableView
{
    if(self.refreshControl.refreshing){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self startRequest];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)startRequest
{
    //请求数据
    NSString *netPath = [[NSString alloc]initWithFormat:@"/lms/lession/checkValidLession?studentId=1"];
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
        NSMutableArray *temObject = [NSMutableArray alloc];
        temObject = [data objectForKey:@"array"];
        self.optionalObject = [[NSMutableArray alloc]init];
        
        for (NSMutableDictionary *temDict in temObject) {
            if (![[temDict objectForKey:@"isBooked"] boolValue]) {
                [self.optionalObject addObject:temDict];//[self.mineObject count]];
            }
        }
        self.optionalObject = [[self.optionalObject reverseObjectEnumerator] allObjects];
        NSLog(@"我的实验有%lu个",(unsigned long)[self.optionalObject count]);
        NSString *message = [res objectForKey:@"message"];
        NSLog(@"%@",message);
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

    return [self.optionalObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSDictionary* dict = [self.optionalObject objectAtIndex:row];
    
    static NSString *optionalCellIdentifier = @"Optional";
    
    OptionalCell *optionalCell = [tableView dequeueReusableCellWithIdentifier:optionalCellIdentifier];
    self.tableView.rowHeight = 65;
    
    
    optionalCell.ExperimentName.text = [dict objectForKey:@"experimentName"];
    optionalCell.Deadline.text = [dict objectForKey:@"date"];
    
    return optionalCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSMutableDictionary*  dict = [self.optionalObject objectAtIndex:row];
    
    NSLog(@"anleyixia");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LMS_Optional_Available *optionalAvailable = [storyboard instantiateViewControllerWithIdentifier:@"Optional_Available"];
    optionalAvailable.listData = [[NSMutableDictionary alloc]initWithDictionary:dict];
    optionalAvailable.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.navigationController presentViewController:optionalAvailable animated:YES completion:^(){
        optionalAvailable.ExperimentName.text = [optionalAvailable.listData objectForKey:@"experimentName"];
        optionalAvailable.ExperimentContent.text = [optionalAvailable.listData objectForKey:@"content"];
        optionalAvailable.ExperimentPlace.text = [optionalAvailable.listData objectForKey:@"labRoom"];
        optionalAvailable.ExperimentData.text = [optionalAvailable.listData objectForKey:@"date"];
        optionalAvailable.TeacherName.text = [optionalAvailable.listData objectForKey:@"teacher"];
        
    }];
    
    [self.tableView reloadData];
    
    
    
    
}


- (IBAction)bactToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
