//
//  LMS_Mine_MyExperiment.m
//  LMS_Student
//
//  Created by Mars on 15/12/26.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "LMS_Mine_MyExperiment.h"
#import "LMS_Mine_MyExperiment_Download.h"
#import "LMS_Mine_MyExperiment_Upload.h"

@interface LMS_Mine_MyExperiment ()

@end

@implementation LMS_Mine_MyExperiment

- (void)viewDidLoad {
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    //[self startRequest];
    [super viewDidLoad];
    
    self.ExperimentName.text = [self.listData objectForKey:@"experimentName"];
    self.ExperimentContent.text = [self.listData objectForKey:@"content"];
    self.ExperimentPlace.text = [self.listData objectForKey:@"labRoom"];
    self.TeacherName.text = [self.listData objectForKey:@"teacher"];
    self.ExperimentData.text = [self.listData objectForKey:@"date"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
-(void)startRequest
{
    //请求数据
    NSString *netPath = [[NSString alloc]initWithFormat:@"/lms/experiment/getExperimentById?experimentId=%@",[self.listData objectForKey:@"experimentId"]];
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"192.168.1.3:8080" customHeaderFields:nil];
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
        NSLog(@"%@",data);
        
        NSString *objName = [data objectForKey:@"baseInfo"];
        [self.listData setObject:objName forKey:@"content"];
        self.ExperimentContent.text = [self.listData objectForKey:@"content"];

        
        NSString *message = [res objectForKey:@"message"];
        NSLog(@"%@",message);
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
*/


#pragma mark - quicklook DataSource
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller
{
    return 1;
}
- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    /*
     NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
     NSString *documentsPath = [docPath objectAtIndex:0];
     NSLog(@"Documents目录：%@/hehe.doc",documentsPath);
     */
     
     //NSURL *local_file_URL = [NSURL fileURLWithPath:@"/var/mobile/Containers/Data/Application/8DF8D5D0-423C-41BD-8FC1-4C041AF2024B/Documents/Documents/hehe.docx"];
     
     NSString* path = [NSHomeDirectory()stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/hehe.doc"]];
    
     NSLog(@"%@",path);
     return [NSURL fileURLWithPath:path];
     //return local_file_URL;
}

#pragma mark- quicklook Delegate
- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
{
    return YES;
}


- (IBAction)downLoad:(id)sender {
    /*
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"KingsoftOfficeAppToday://"]]) {
        NSLog(@"This url can be opened");
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"com.kingsoft.www.office.wpsoffice://var/mobile/Containers/Data/Application/DD70B45B-F01C-4F66-8C3C-3582139B88DB/Documents/hehe.docx"]];
        NSLog(@"this url is activity");
    }
    else
    {
        NSLog(@"本地没有该软件");
    }
    */
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LMS_Mine_MyExperiment_Download *downLoad = [storyboard instantiateViewControllerWithIdentifier:@"download_File"];
    downLoad.listData = [[NSMutableDictionary alloc]initWithDictionary:self.listData];
    [self.navigationController pushViewController:downLoad animated:YES];
    
    
    QLPreviewController *myQlPreViewController = [[QLPreviewController alloc]init];
    myQlPreViewController.delegate =self;
    myQlPreViewController.dataSource =self;
    [myQlPreViewController.navigationItem setRightBarButtonItem:nil];
    //[[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
   // [self presentModalViewController:myQlPreViewController animated:YES];
    
    
    
    
}

- (IBAction)Upload:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    LMS_Mine_MyExperiment_Upload *upLoad = [storyboard instantiateViewControllerWithIdentifier:@"upload_File"];
    upLoad.listData = [[NSMutableDictionary alloc]initWithDictionary:self.listData];
    [self.navigationController pushViewController:upLoad animated:YES];

}
@end
