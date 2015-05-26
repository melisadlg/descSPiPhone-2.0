//
//  AppDelegate.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 2/5/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

#import "GAI.h" // 01

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) id<GAITracker> tracker; // 02

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

