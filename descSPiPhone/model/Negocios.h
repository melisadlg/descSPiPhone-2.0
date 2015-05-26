//
//  Negocios.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ImagenesNeg,CategoriasNegocios;

@interface Negocios : NSManagedObject

@property (nonatomic, retain) NSString * idNegocio;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * direccion;
@property (nonatomic, retain) NSString * latitud;
@property (nonatomic, retain) NSString * longitud;
@property (nonatomic, retain) NSString * filtro;
@property (nonatomic, retain) NSString * favorito;
@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSString * imagenes;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * pagina;
@property (nonatomic, retain) NSString * correo;
@property (nonatomic, retain) ImagenesNeg *imagenesNeg;
@property (nonatomic, retain) CategoriasNegocios *categoriaNegocios;
@end

@interface Negocios (CoreDataGeneratedAccessors)

- (void)addImagenesNegObject:(NSManagedObject *)value;
- (void)removeImagenesNegObject:(NSManagedObject *)value;
- (void)addImagenesNeg:(NSSet *)values;
- (void)removeImagenesNeg:(NSSet *)values;

@end
