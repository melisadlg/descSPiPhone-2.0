//
//  ZUsr_Profile.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZUsr_Users;

@interface ZUsr_Profile : NSManagedObject

@property (nonatomic, retain) NSString * idProfile;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) ZUsr_Users *users;
@end

@interface ZUsr_Profile (CoreDataGeneratedAccessors)

- (void)addUsersObject:(ZUsr_Users *)value;
- (void)removeUsersObject:(ZUsr_Users *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;

@end
