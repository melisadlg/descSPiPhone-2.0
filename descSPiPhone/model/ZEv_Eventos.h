//
//  ZEv_Eventos.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 4/15/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZEv_Imagenes;

@interface ZEv_Eventos : NSManagedObject

@property (nonatomic, retain) NSString * anio;
@property (nonatomic, retain) NSString * arboleda;
@property (nonatomic, retain) NSString * correo;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * dia;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * fotografia;
@property (nonatomic, retain) NSString * horas;
@property (nonatomic, retain) NSString * idEvento;
@property (nonatomic, retain) NSString * lugar;
@property (nonatomic, retain) NSString * mes;
@property (nonatomic, retain) NSString * minutos;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * pagina;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) ZEv_Imagenes *imagenesEv;
@end

@interface ZEv_Eventos (CoreDataGeneratedAccessors)

- (void)addImagenesEvObject:(ZEv_Imagenes *)value;
- (void)removeImagenesEvObject:(ZEv_Imagenes *)value;
- (void)addImagenesEv:(NSSet *)values;
- (void)removeImagenesEv:(NSSet *)values;

@end
