//
//  LMS_Mine.m
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Mine.h"
#import "LMS_Mine_MyExperiment.h"
#import "MineCell.h"

@interface LMS_Mine ()

@end

@implementation LMS_Mine

- (void)viewDidLoad {
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //左右滑动
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
    [super viewDidLoad];
    
    //NSLog(@"ip =%@",self.ip);
    
    //初始化cell
    static NSString *mineCellIdentifier = @"MyExperiment";
    UINib *nib = [UINib nibWithNibName:@"MineCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:mineCellIdentifier];
    NSLog(@"Init MineCell");
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    [self startRequest];
    [self showActivityIndicatorViewInNavigationItem];

    //[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //初始化UIRefreshControl
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;
    
}

-(void)showActivityIndicatorViewInNavigationItem
{
    UIActivityIndicatorView *aiview = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.navigationItem.titleView =aiview;
    [aiview startAnimating];
    self.navigationItem.prompt =@"数据加载中";
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


- (IBAction)bactToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)startRequest
{
        //请求da数据
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
        
        self.navigationItem.titleView = nil;
        self.navigationItem.prompt = nil;

        NSMutableDictionary *data = [res objectForKey:@"data"];
        NSMutableArray *temObject = [NSMutableArray alloc];
        temObject = [data objectForKey:@"array"];
        self.mineObject = [[NSMutableArray alloc]init];
        
        for (NSMutableDictionary *temDict in temObject) {
            if ([[temDict objectForKey:@"isBooked"] boolValue]) {
            [self.mineObject addObject:temDict];//[self.mineObject count]];
            }
        }
        self.mineObject = [[self.mineObject reverseObjectEnumerator] allObjects];
        NSLog(@"我的实验有%lu个",(unsigned long)[self.mineObject count]);
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
    
    return [self.mineObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSDictionary* dict = [self.mineObject objectAtIndex:row];
    
    static NSString *mineCellIdentifier = @"MyExperiment";
    
    //BOOL isBook = [dict objectForKey:@"isBooked"];
    
    
    //if (!isBook) {
        MineCell *mineCell = [tableView dequeueReusableCellWithIdentifier:mineCellIdentifier];
        self.tableView.rowHeight = 104;
        
        mineCell.ExperimentName.text = [dict objectForKey:@"experimentName"];
        mineCell.ExperimentContent.text = [dict objectForKey:@"content"];
        mineCell.Deadline.text = [dict objectForKey:@"date"];

        return mineCell;
    //}else{
      //  UITableViewCell *nouseCell = [tableView dequeueReusableCellWithIdentifier:@"noUseCell"];
        //self.tableView.rowHeight = 0;
        //return nouseCell;
        
    //}
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary*  dict = [self.mineObject objectAtIndex:row];
    
    NSLog(@"anleyixia");
    
           UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LMS_Mine_MyExperiment *myExperiment = [storyboard instantiateViewControllerWithIdentifier:@"My_Experiment"];
        
        
        [self.navigationController pushViewController:myExperiment animated:YES];
        myExperiment.listData = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
        
    
    
}


@end
