//
//  ViewController.h
//  descSPiPhone
//
//  Created by Desarrollo1 on 2/5/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MessageUI/MessageUI.h>

@interface ViewController : UIViewController<UIWebViewDelegate, MKMapViewDelegate, MFMailComposeViewControllerDelegate,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *iboBoton1;
- (IBAction)ibaBoton1:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *iboBtnEv;
- (IBAction)ibaBtnEv:(id)sender;
- (IBAction)ibaBtnCul:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *iboBtnCul;

- (IBAction)menuPrincipal:(UIButton *)sender;
@end

