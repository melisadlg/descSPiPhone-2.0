//
//  ZEv_Imagenes.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 4/15/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZEv_Eventos;

@interface ZEv_Imagenes : NSManagedObject

@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * idEvento;
@property (nonatomic, retain) NSString * idImg;
@property (nonatomic, retain) NSString * mime;
@property (nonatomic, retain) NSString * tipo;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) ZEv_Eventos *eventos;

@end
