//
//  CoreDataManager.h
//  MTG Score
//
//  Created by Luca Bertani on 18/04/11.
//  Copyright 2011 home. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CoreDataManager : NSObject {
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedCoreDataManager;
- (void)cleanup;
- (void)saveCurrentContext;
- (NSManagedObjectContext *)managedObjectContext;

@end
