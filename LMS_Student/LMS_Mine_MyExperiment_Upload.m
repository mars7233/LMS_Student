//
//  LMS_Mine_MyExperiment_Upload.m
//  LMS_Student
//
//  Created by Mars on 16/1/2.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "LMS_Mine_MyExperiment_Upload.h"

@interface LMS_Mine_MyExperiment_Upload ()

@end

@implementation LMS_Mine_MyExperiment_Upload

- (void)viewDidLoad {
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [super viewDidLoad];
    [self reloadFile];
    
    self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [rc addTarget:self action:@selector(refreshTableView) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = rc;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) reloadFile
{
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    self.filePath = [docPath objectAtIndex:0];
    
    NSFileManager * fm = [NSFileManager defaultManager];
    
    self.uploadObject = [fm directoryContentsAtPath:[[NSString alloc]initWithFormat:@"%@",self.filePath]];
    [self.uploadObject removeObject:@"Inbox"];
    [self.uploadObject removeObject:@"LMS_Student.sqlite"];
    [self.uploadObject removeObject:@"LMS_Student.sqlite-shm"];
    [self.uploadObject removeObject:@"LMS_Student.sqlite-wal"];
    
    NSLog(@"%@",self.uploadObject);
    //停止刷新
    [self.refreshControl endRefreshing];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];

    
}

-(void) refreshTableView
{
    if(self.refreshControl.refreshing){
        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中"];
        [self reloadFile];
       
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.uploadObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UploadCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UploadCell"];
    }
    
    NSUInteger row = [indexPath row];
    NSData *dict = [self.uploadObject objectAtIndex:row];
    NSLog(@"%@",dict);
    cell.textLabel.text = [[NSString alloc]initWithFormat:@"%@",dict];
    return cell;
}

//点击单元格事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要上传该文件吗？"
                                                    message:@"确定要上传该文件吗？"
                                                   delegate:self
                                          cancelButtonTitle:@"NO"
                                          otherButtonTitles:@"YES", nil];
    [alert show];
    
    }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if(buttonIndex == 1){
        NSInteger row = [indexPath row];
        NSData *dict = [self.uploadObject objectAtIndex:row];
        
        
        
        NSString *filePath = [[NSString alloc]initWithFormat:@"%@/%@",self.filePath,dict];
        NSLog(@"文件路径为%@",filePath);
        
        NSFileManager * fm;
        fm = [NSFileManager defaultManager];
        
        NSString *path = [[NSString alloc] initWithFormat:@"lms/file/studentUpload"];
        
        NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
        
        [param setValue:[[NSString alloc]initWithFormat:@"%@",dict] forKey:@"fileName"];
        [param setValue:[self.listData objectForKey:@"parentPlanId"] forKey:@"lessionId"];
        [param setValue:@"1" forKey:@"userId"];
        [param setValue:@"1" forKey:@"fileType"];
        
        
        MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serveIP customHeaderFields:nil];
        MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
        
        [op addFile:filePath forKey:@"file"];
        [op setFreezable:YES];
        
        [op addCompletionHandler:^(MKNetworkOperation *operation) {
            
            NSLog(@"Upload file finished!");
            // NSData *data = [operation responseData];
            
        } errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
            NSLog(@"MKNetwork请求错误 : %@", [err localizedDescription]);
        }];
        [engine enqueueOperation:op];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"上传成功!"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"NO"
                                              otherButtonTitles:nil, nil];
        [alert show];

    }

}

+ (NSArray *) getAllFileNames:(NSString *)dirName
{
    // 获得此程序的沙盒路径
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // 获取Documents路径
    // [patchs objectAtIndex:0]
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    
    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:dirName];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}

@end
