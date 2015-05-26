//
//  EndAnnotation.h
//  Ride
//
//  Created by Nicholas Hubbard on 5/2/10.
//  Copyright (c) 2013 Zed Said Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>
#import "ZSPinAnnotation.h"

/*!
 An annotation helped class to be used to hold annotation data for ZSPinAnnotation
 */
@interface ZSAnnotation : NSObject <MKAnnotation>

/// The coordinate for the annotation
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

/// The title for the annotation
@property (nonatomic, copy) NSString *title;

/// The subtitle for the annotation
@property (nonatomic, copy) NSString *subtitle;

/// The color of the annotation
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) int tag;

/// The type of annotation to draw
@property (nonatomic) ZSPinAnnotationType type;

@property (nonatomic, copy) NSString *giro;

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *facebookURL;
@property (nonatomic, copy) NSString *twitterURL;
@property (nonatomic, copy) NSString *webURL;
@property (nonatomic, copy) NSString *mailURL;

@property (nonatomic, copy) UIImage *image00;
@property (nonatomic, copy) UIImage *image01;
@property (nonatomic, copy) UIImage *image02;
@property (nonatomic, copy) UIImage *image03;
@property (nonatomic, copy) UIImage *image04;

@end