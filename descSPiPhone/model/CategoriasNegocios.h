//
//  CategoriasNegocios.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categorias, Negocios;

@interface CategoriasNegocios : NSManagedObject

@property (nonatomic, retain) NSString * idNegocio;
@property (nonatomic, retain) NSString * idCategoria;
@property (nonatomic, retain) Categorias *categorias;
@property (nonatomic, retain) Negocios *negocios;

@end
