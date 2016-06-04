//
//  LMS_Mine_MyExperiment_Download.m
//  LMS_Student
//
//  Created by Mars on 16/1/2.
//  Copyright © 2016年 Mingjun Ma. All rights reserved.
//

#import "LMS_Mine_MyExperiment_Download.h"

@interface LMS_Mine_MyExperiment_Download ()

@end

@implementation LMS_Mine_MyExperiment_Download

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self startRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//开始请求
-(void)startRequest
{
    //请求数据
    NSString *netPath = [[NSString alloc]initWithFormat:@"/lms/experiment/getExperimentFiles?experimentId=%@",[self.listData objectForKey:@"experimentId"]];
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
        
        NSMutableDictionary *data = [[NSMutableDictionary alloc]initWithDictionary:[res objectForKey:@"data"]];
        //data = [res objectForKey:@"data"];
        //NSLog(@"%@",data);
        self.downloadObject = [data objectForKey:@"array"];
        
        //NSLog(@"%@",self.downloadObject);
        NSString *message = [res objectForKey:@"message"];
        NSLog(@"%@",message);
        
        [self.tableView reloadData];
    }else {
        NSString *errorStr = [res objectForKey:@"message"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"内容获取失败"
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

    return [self.downloadObject count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"download_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"download_Cell"];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary* dict = [self.downloadObject objectAtIndex:row];
    //NSLog(@"hehehe");
    
    cell.textLabel.text = [dict objectForKey:@"name"];
    cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"文件大小:%@",[dict objectForKey:@"size"]];
    return cell;
}


//点击单元格事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary* dict = [self.downloadObject objectAtIndex:row];
    
//建文件夹
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    //查找Cache路径
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/%@", cachePath,[dict objectForKey:@"experimentId"]];
    
    
    // 判断文件夹是否存在，如果不存在，则创建
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    } else {
        NSLog(@"FileDir is exists.");
    }
    
//设置请求前准备
    
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = paths[0];
    NSString *downloadPath = [cachesDirectory stringByAppendingString:[[NSString alloc]initWithFormat:@"/%@/%@",[dict objectForKey:@"experimentId"],[dict objectForKey:@"name"]]];
    NSLog(@"下载地址为：%@",downloadPath);
    NSString *path = [[NSString alloc]initWithFormat:@"/lms/file/downloadResource/%@",[dict objectForKey:@"id"]];
    NSLog(@"请求地址为:%@",path);
    
//设置请求引擎
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:serveIP customHeaderFields:nil];
    //MKNetworkOperation *op = [engine operationWithPath:path params:param httpMethod:@"POST"];
    MKNetworkOperation *downloadOperation = [engine operationWithPath:path params:nil httpMethod:@"GET"];
    [downloadOperation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:downloadPath append:NO]];
    
//下载进度
    [downloadOperation onDownloadProgressChanged:^(double progress){
        NSLog(@"download progress:%.2f%%",progress*100.0);
    }];
//下载结束返回结果（成功或失败）
    [downloadOperation addCompletionHandler:^(MKNetworkOperation *operation){
        NSLog(@"download file finished!");
        NSData *data = [operation responseData];
        
        if (data) {
            //返回数据失败
            NSError *error;
            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data
                                                                    options:NSJSONReadingAllowFragments
                                                                      error:&error];
        }else{
            //返回数据成功
            NSLog(@"返回数据成功!");
            [self quicklookMethod:downloadPath];
        }
    }errorHandler:^(MKNetworkOperation *errorOp,NSError *err){
        NSLog(@"MKNetwork请求错误:%@",[err localizedDescription]);
    }];
    [engine enqueueOperation:downloadOperation];
    
    self.filePath =downloadPath;
    
    
    
}

-(void)quicklookMethod:(NSString *)filePath
{
    QLPreviewController *myQlPreViewController = [[QLPreviewController alloc]init];
    myQlPreViewController.delegate =self;
    myQlPreViewController.dataSource =self;
    [myQlPreViewController.navigationItem setRightBarButtonItem:nil];
    
    //[[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [self.navigationController presentViewController:myQlPreViewController animated:YES completion:nil];
    
}

#pragma mark - quicklook DataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}
- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSLog(@"%@",self.filePath);
    return [NSURL fileURLWithPath:self.filePath];
}

#pragma mark- quicklook Delegate
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
{
    return YES;
}



@end
