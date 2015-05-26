//
//  Aud_cambios.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 3/4/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Aud_cambios : NSManagedObject

@property (nonatomic, retain) NSString * idCambio;
@property (nonatomic, retain) NSString * idEnTabla;
@property (nonatomic, retain) NSString * tabla;
@property (nonatomic, retain) NSString * columna;
@property (nonatomic, retain) NSString * fechaHoraIntApp;
@property (nonatomic, retain) NSString * fechaHoraDecSrv;
@property (nonatomic, retain) NSString * tipoCambio;
@property (nonatomic, retain) NSString * idUsuario;

@end
