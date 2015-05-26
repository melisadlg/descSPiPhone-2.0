//
//  ImagenesNeg.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/12/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Negocios;

@interface ImagenesNeg : NSManagedObject

@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * idImg;
@property (nonatomic, retain) NSString * idNegocio;
@property (nonatomic, retain) NSString * mime;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Negocios *negocios;

@end
