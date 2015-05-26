//
//  ZCl_cultura.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZCl_imagenes;

@interface ZCl_cultura : NSManagedObject

@property (nonatomic, retain) NSString * idCultura;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * fotografia;
@property (nonatomic, retain) NSString * autor;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSManagedObject *categoriaCultura;
@property (nonatomic, retain) ZCl_imagenes *imagenesCl;
@end

@interface ZCl_cultura (CoreDataGeneratedAccessors)

- (void)addImagenesClObject:(NSManagedObject *)value;
- (void)removeImagenesClObject:(NSManagedObject *)value;
- (void)addImagenesCl:(NSSet *)values;
- (void)removeImagenesCl:(NSSet *)values;

@end
