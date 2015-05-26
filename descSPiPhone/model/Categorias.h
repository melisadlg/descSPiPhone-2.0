//
//  Categorias.h
//  descSPiPhone
//
//  Created by Melisa on 5/18/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CategoriasNegocios;

@interface Categorias : NSManagedObject

@property (nonatomic, retain) NSString * idCategoria;
@property (nonatomic, retain) NSString * idPadre;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * red;
@property (nonatomic, retain) NSString * green;
@property (nonatomic, retain) NSString * blue;
@property (nonatomic, retain) CategoriasNegocios *categoriasNegocios;
@end

@interface Categorias (CoreDataGeneratedAccessors)

- (void)addCategoriasNegociosObject:(CategoriasNegocios *)value;
- (void)removeCategoriasNegociosObject:(CategoriasNegocios *)value;
- (void)addCategoriasNegocios:(NSSet *)values;
- (void)removeCategoriasNegocios:(NSSet *)values;

@end
