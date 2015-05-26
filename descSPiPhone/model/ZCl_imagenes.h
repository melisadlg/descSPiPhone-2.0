//
//  ZCl_imagenes.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZCl_cultura;

@interface ZCl_imagenes : NSManagedObject

@property (nonatomic, retain) NSString * idImg;
@property (nonatomic, retain) NSString * idCultura;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * mime;
@property (nonatomic, retain) ZCl_cultura *cultura;

@end
