//
//  CoreDataHelper.h
//  RecruiterApp
//
//  Created by Ayush Goel on 20/05/13.
//  Copied by Ikjot Kaur on 04/01/2016.
//  Copyright (c) 2013 Ayush Goel. All rights reserved.
//

//marking up code before mmoc implementation
#import "CoreDataHelper.h"
#import <CoreData/CoreData.h>



@implementation CoreDataHelper
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize mainMOC = _mainMOC;
@synthesize writerMOC = _writerMOC;

+(CoreDataHelper *)sharedInstance{
    static CoreDataHelper *sharedInstance =  nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance  =  [[CoreDataHelper alloc]init];
    });
    return sharedInstance;
}
-(void)initialiseValues{
    [self mainMOC];
}
#pragma mark - Core Data stack

+(NSManagedObjectContext*)privateMoc
{
    NSManagedObjectContext *temporaryContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    temporaryContext.parentContext = [[CoreDataHelper sharedInstance] managedObjectContext];


    return temporaryContext;
    

}



// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    return [self mainMOC];
}
-(NSManagedObjectContext*)mainMOC{
    if (!_mainMOC)
    {
        _mainMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainMOC.parentContext = [self writerMOC];
        
    }
    return _mainMOC;
}
-(NSManagedObjectContext*)writerMOC{
    if (!_writerMOC)
    {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) {
            _writerMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            [_writerMOC setPersistentStoreCoordinator:coordinator];
        }
        
    }
    return _writerMOC;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSBundle *abc = [NSBundle bundleWithIdentifier:@"com.Framework.ServiceClient"];
    NSURL *modelURL = [abc URLForResource:@"TSGAPIDetails" withExtension:@"momd"];
    NSLog(@"Model URL------>%@",modelURL);
    
    if (modelURL != nil)
    {
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
    }
    return [[NSManagedObjectModel alloc] init];
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TSGAPIDetails.sqlite"];
    NSLog(@"storeURL----->%@",storeURL.absoluteString);
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString* foofile = [documentsPath stringByAppendingPathComponent:@"TSGAPIDetails.sqlite"];
        if([[NSFileManager defaultManager] fileExistsAtPath:foofile])
        {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtURL:storeURL error:NULL];
            _persistentStoreCoordinator=nil;
            [self persistentStoreCoordinator];
        }
    }
    return _persistentStoreCoordinator;
}
#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            abort();
        }
    }
}
+(void)saveDataContext
{
    NSManagedObjectContext *context =  [[CoreDataHelper sharedInstance] managedObjectContext];
    [context performBlockAndWait:^{
        [context save:nil];
    }];
    [context.parentContext performBlock:^{
        [context.parentContext save:nil];
    }];
}

@end
