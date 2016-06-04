//
//  AppDelegate.m
//  LMS_Student
//
//  Created by Mars on 15/12/25.
//  Copyright © 2015年 Mingjun Ma. All rights reserved.
//

#import "AppDelegate.h"
#import "LMS_Notification.h"
#import "LMS_Mine.h"
#import "LMS_Login.h"
#import "LMS_Optional.h"
#import "LMS_Notification_Inform.h"


@interface AppDelegate ()

@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //self.window=[[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    //LMS_Notification *lms_Notification = [[LMS_Notification alloc] init];
    
    //UINavigationController *navigationController = [[UINavigationController alloc]init];
    //navigationController=[[UINavigationController alloc] initWithRootViewController:lms_Notification];
    
    //self.window.rootViewController = navigationController;
    //[self.window makeKeyAndVisible];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LMS_Notification *controller=[storyboard instantiateInitialViewController];
   
    self.window.rootViewController=controller;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
        //接收文件
        NSLog(@"收到文件");
        if (url != nil) {
            //获取文件路径
            NSString *path = [url absoluteString];
            NSMutableString *string = [[NSMutableString alloc] initWithString:path];
        
            if ([path hasPrefix:@"file://"]) {
                [string replaceOccurrencesOfString:@"file://" withString:@"" options:NSCaseInsensitiveSearch  range:NSMakeRange(0, path.length)];
            }
            NSLog(@"%@",string);
        
            //获取文件名
            NSRange range = [string rangeOfString:@"/" options:NSBackwardsSearch];
            NSString *fileName = [string substringFromIndex:range.location];
            NSLog(@"%@",fileName);
            
            //读.doc转成NSData
            NSFileManager * fm;
            fm = [NSFileManager defaultManager];
        
            NSData *data = [NSData dataWithContentsOfFile:string];
            NSLog(@"NSData类方法读取的内容是：%@",data);//[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
            //把NSData写入Document文件夹中
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *docDir = [paths objectAtIndex:0];
            if (!docDir) {
                NSLog(@"Documents 目录未找到");
            }
            NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
            [data writeToFile:filePath atomically:YES];
        
        }
        return YES;
}

        /*
        if ([fm createFileAtPath:@"hehe.doc" contents:data attributes:nil] == NO)
        {
            NSLog(@"Couldn't create the copy!");
            return 2;
        }*/
        
       // NSLog(@"File copy was successful!");
        
        //NSString* content = [NSString stringWithContentsOfFile:string encoding:NSUTF16StringEncoding error:&error];
        //NSLog(@"%@",error);
        
        //NSLog(@"NSString类方法读取的内容是：\n%@",content);
        
        //BOOL cp = [fm copyItemAtPath:string toPath:documentsPath error:&error];
        //BOOL isExist = [fm fileExistsAtPath:documentsPath];
        //NSLog(@"%d",cp);
        //NSLog(@"%d",isExist);
        
        
      
        //[self. openPng:string];
        /*
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        docUploadConfirm *newDoc = [storyboard instantiateViewControllerWithIdentifier:@"UploadConfirm"];
        newDoc.docPath = string;
        NSLog(@"%@",newDoc.docPath);
        
        //[newDoc.navigationItem setBackBarButtonItem:<#(UIBarButtonItem * _Nullable)#>]
        [self.window.rootViewController presentViewController:newDoc animated:YES completion:nil];
        */
        



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "mars.LMS_Student" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LMS_Student" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LMS_Student.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([[url scheme] isEqualToString:@"LMS_Student"])
    {
        NSLog(@"%@",url);
    }
    return YES;
}

@end
