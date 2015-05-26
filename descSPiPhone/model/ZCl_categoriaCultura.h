//
//  ZCl_categoriaCultura.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZCl_categorias, ZCl_cultura;

@interface ZCl_categoriaCultura : NSManagedObject

@property (nonatomic, retain) NSString * idCultura;
@property (nonatomic, retain) NSString * idCategoria;
@property (nonatomic, retain) ZCl_categorias *categoriasCl;
@property (nonatomic, retain) ZCl_cultura *cultura;

@end
