//
//  ZCl_categorias.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZCl_categoriaCultura;

@interface ZCl_categorias : NSManagedObject

@property (nonatomic, retain) NSString * idCategoria;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSString * idPadre;
@property (nonatomic, retain) ZCl_categoriaCultura *categoriaCultura;
@end

@interface ZCl_categorias (CoreDataGeneratedAccessors)

- (void)addCategoriaCulturaObject:(NSManagedObject *)value;
- (void)removeCategoriaCulturaObject:(NSManagedObject *)value;
- (void)addCategoriaCultura:(NSSet *)values;
- (void)removeCategoriaCultura:(NSSet *)values;

@end
