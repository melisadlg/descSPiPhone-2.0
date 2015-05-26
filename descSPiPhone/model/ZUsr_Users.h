//
//  ZUsr_Users.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZUsr_Profile;

@interface ZUsr_Users : NSManagedObject

@property (nonatomic, retain) NSString * idUser;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * lastname;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * idProfile;
@property (nonatomic, retain) ZUsr_Profile *profile;

@end
