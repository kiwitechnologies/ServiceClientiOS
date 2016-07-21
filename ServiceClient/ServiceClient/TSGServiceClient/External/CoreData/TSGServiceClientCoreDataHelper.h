//
//  CoreDataHelper.h
//  RecruiterApp
//
//  Created by Ayush Goel on 20/05/13.
//  Copied by Ikjot Kaur on 04/01/2016.
//  Copyright (c) 2013 Ayush Goel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TSGServiceClientCoreDataHelper : NSObject


@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong, readonly) NSManagedObjectContext *writerMOC;
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainMOC;

/**
 *  Get Singleton Object of NGCoreDataHelper.
 *
 *  @return Return Singleton Object.
 */

+(TSGServiceClientCoreDataHelper *)sharedInstance;
//-(void)deleteAllObjectsInCoreData;
-(void)initialiseValues;
+(NSManagedObjectContext*)privateMoc;
+(void)saveDataContext;
@end
