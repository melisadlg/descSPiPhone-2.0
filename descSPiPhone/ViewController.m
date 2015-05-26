//
//  ViewController.m
//  descSPiPhone
//
//  Created by Desarrollo1 on 2/5/15.
//  Copyright (c) 2015 InkStudio. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "AFNetworking.h"
#import "AppDelegate.h"

#import "Aud_cambios.h"
#import "Aud_datos.h"
#import "Categorias.h"
#import "CategoriasNegocios.h"
#import "ImagenesNeg.h"
#import "Negocios.h"
#import "ZCl_categoriaCultura.h"
#import "ZCl_categorias.h"
#import "ZCl_cultura.h"
#import "ZCl_imagenes.h"
#import "ZEv_Eventos.h"
#import "ZEv_Imagenes.h"
#import "ZUsr_Profile.h"
#import "ZUsr_Users.h"

#import "GAI.h"     // *** 08 ***
#import "GAIFields.h"
#import "GAITracker.h"
#import "GAIDictionaryBuilder.h"

#import "ZSPinAnnotation.h"
#import "ZSAnnotation.h"

#import "MBProgressHUD.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *menuView;
@property (strong, nonatomic) IBOutlet UIButton *menuInOut;
@property (strong, nonatomic) IBOutlet UIButton *menuInteresBTN;
@property (strong, nonatomic) IBOutlet UIButton *menuHistoriaBTN;
@property (strong, nonatomic) IBOutlet UIButton *menuCulturaBTN;
@property (strong, nonatomic) IBOutlet UIButton *menuEventosBTN;
@property (strong, nonatomic) IBOutlet UIButton *menuDvcBTN;

@property (strong, nonatomic) IBOutlet UIButton *sitiosFiltrosBTN;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UIView *sitiosView;

@property (strong, nonatomic) IBOutlet UILabel *currentSecLbl;

@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIImageView *detailIMG00;
@property (strong, nonatomic) IBOutlet UIImageView *detailIMG01;
@property (strong, nonatomic) IBOutlet UIImageView *detailIMG02;
@property (strong, nonatomic) IBOutlet UIImageView *detailIMG03;
@property (strong, nonatomic) IBOutlet UIImageView *detailIMG04;
@property (strong, nonatomic) IBOutlet UILabel *detailName;
@property (strong, nonatomic) IBOutlet UILabel *detailGiro;
@property (strong, nonatomic) IBOutlet UITextView *detailTxt;
@property (strong, nonatomic) IBOutlet UIScrollView *detailScroll;
@property (strong, nonatomic) IBOutlet UIPageControl *detailPageControl;
@property (strong, nonatomic) IBOutlet UIButton *detailBtnFB;
@property (strong, nonatomic) IBOutlet UIButton *detailBtnTwitter;
@property (strong, nonatomic) IBOutlet UIButton *detailBtnMail;
@property (strong, nonatomic) IBOutlet UIButton *detailBtnWeb;

@property (strong, nonatomic) IBOutlet UIView *arboledaView;
@property (strong, nonatomic) IBOutlet UIButton *arboledaBtnClose;

@property (strong, nonatomic) IBOutlet UIView *historiaView;
@property (strong, nonatomic) IBOutlet UIScrollView *historiaScroll;
@property (strong, nonatomic) IBOutlet UILabel *historiaYearLbl;
@property (strong, nonatomic) IBOutlet UILabel *historiaTextLbl;
@property (strong, nonatomic) IBOutlet UIButton *historiaRwBtn;
@property (strong, nonatomic) IBOutlet UIButton *historiaFwdBtn;

@property (strong, nonatomic) IBOutlet UIView *dvcView;
@property (strong, nonatomic) IBOutlet UIButton *dvcBtn01;
@property (strong, nonatomic) IBOutlet UIButton *dvcBtn02;
@property (strong, nonatomic) IBOutlet UIButton *dvcBtn03;
@property (strong, nonatomic) IBOutlet UIButton *dvcBtn04;
@property (strong, nonatomic) IBOutlet UIButton *dvcBtn05;
@property (strong, nonatomic) IBOutlet UIView *dvcSeccionView;
@property (strong, nonatomic) IBOutlet UILabel *dvcSeccionLbl;
@property (strong, nonatomic) IBOutlet UILabel *dvcTituloLbl;
@property (strong, nonatomic) IBOutlet UITextView *dvcDescripTxt;

@end
NSDictionary *respObject;
UIScrollView *scrollview,*sclViewEvArb,*sclViewEvGen;
UIView *evView,*evViewTituloArb;

@implementation ViewController

@synthesize mapView;

const CGFloat hScrollObjHeight	= 504.0;
const CGFloat hScrollObjWidth	= 300.0;

const NSUInteger hNumImages		= 21;

int historiaPag = 1;

BOOL menuOut = FALSE;
BOOL sitiosFiltro = FALSE;

- (BOOL) prefersStatusBarHidden{
    
    return YES;
}

- (void)viewDidLoad{
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Descubre San Pedro"];
    [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
    
    _currentSecLbl.attributedText = attrStr;
    
    mapView.delegate = self;
    
    [super viewDidLoad];
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]);
    arrayCategorias00=[[NSMutableArray alloc] init];
    arrayCategorias01=[[NSMutableArray alloc] init];
    
    // *** 09 ***
    // SDK Version 3.08 and up. Sending the same screen view hit using [GAIDictionaryBuilder createScreenView]
    [[GAI sharedInstance].defaultTracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Home Screen DescSP-iPhone" forKey:kGAIScreenName] build]];
    
    mesesArr=[[NSArray alloc]initWithObjects:@"nada",@"Enero",@"Febrero",@"Marzo",@"Abril",@"Mayo",@"Junio",@"Julio",@"Agosto",@"Septiembre",@"Octubre",@"Noviembre",@"Diciembre",nil];
    
    [self downloadCatUsrDB];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentJustified];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [style setLineSpacing:18];
    
    UIFont *font1 = [UIFont fontWithName:@"Futura" size:14.0];
    
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style};
    
    NSMutableAttributedString *attString1 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString2 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString3 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString4 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString5 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString6 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString7 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString8 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString9 = [[NSMutableAttributedString alloc] init];
    NSMutableAttributedString *attString10 = [[NSMutableAttributedString alloc] init];
    
    [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"SITIOS DE INTERES" attributes:dict1]];
    [_menuInteresBTN setAttributedTitle:attString1 forState:UIControlStateNormal];
    [[_menuInteresBTN titleLabel] setNumberOfLines:0];
    [[_menuInteresBTN titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    _menuInteresBTN.titleLabel.textColor = [UIColor colorWithRed:0.42 green:0.43 blue:0.44 alpha:1.0];
    
    [attString2 appendAttributedString:[[NSAttributedString alloc] initWithString:@"HISTORIA" attributes:dict1]];
    [_menuHistoriaBTN setAttributedTitle:attString2 forState:UIControlStateNormal];
    [[_menuHistoriaBTN titleLabel] setNumberOfLines:0];
    [[_menuHistoriaBTN titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    _menuHistoriaBTN.titleLabel.textColor = [UIColor colorWithRed:0.42 green:0.43 blue:0.44 alpha:1.0];
    
    [attString3 appendAttributedString:[[NSAttributedString alloc] initWithString:@"CULTURA" attributes:dict1]];
    [_menuCulturaBTN setAttributedTitle:attString3 forState:UIControlStateNormal];
    [[_menuCulturaBTN titleLabel] setNumberOfLines:0];
    [[_menuCulturaBTN titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    _menuCulturaBTN.titleLabel.textColor = [UIColor colorWithRed:0.42 green:0.43 blue:0.44 alpha:1.0];
    
    [attString4 appendAttributedString:[[NSAttributedString alloc] initWithString:@"EVENTOS" attributes:dict1]];
    [_menuEventosBTN setAttributedTitle:attString4 forState:UIControlStateNormal];
    [[_menuEventosBTN titleLabel] setNumberOfLines:0];
    [[_menuEventosBTN titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    _menuEventosBTN.titleLabel.textColor = [UIColor colorWithRed:0.42 green:0.43 blue:0.44 alpha:1.0];
    
    [attString5 appendAttributedString:[[NSAttributedString alloc] initWithString:@"DVC" attributes:dict1]];
    [_menuDvcBTN setAttributedTitle:attString5 forState:UIControlStateNormal];
    [[_menuDvcBTN titleLabel] setNumberOfLines:0];
    [[_menuDvcBTN titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    _menuDvcBTN.titleLabel.textColor = [UIColor colorWithRed:0.42 green:0.43 blue:0.44 alpha:1.0];
    
    [attString6 appendAttributedString:[[NSAttributedString alloc] initWithString:@"NOSOTROS" attributes:dict1]];
    [_dvcBtn01 setAttributedTitle:attString6 forState:UIControlStateNormal];
    _dvcBtn01.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.89 alpha:1.0];
    
    [attString7 appendAttributedString:[[NSAttributedString alloc] initWithString:@"HISTORIA" attributes:dict1]];
    [_dvcBtn02 setAttributedTitle:attString7 forState:UIControlStateNormal];
    _dvcBtn02.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.89 alpha:1.0];
    
    [attString8 appendAttributedString:[[NSAttributedString alloc] initWithString:@"PRINCIPIOS" attributes:dict1]];
    [_dvcBtn03 setAttributedTitle:attString8 forState:UIControlStateNormal];
    _dvcBtn03.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.89 alpha:1.0];
    
    [attString9 appendAttributedString:[[NSAttributedString alloc] initWithString:@"R. COMUNIDAD" attributes:dict1]];
    [_dvcBtn04 setAttributedTitle:attString9 forState:UIControlStateNormal];
    _dvcBtn04.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.89 alpha:1.0];
    
    [attString10 appendAttributedString:[[NSAttributedString alloc] initWithString:@"ENVIAR SUGERENCIA" attributes:dict1]];
    [_dvcBtn05 setAttributedTitle:attString10 forState:UIControlStateNormal];
    _dvcBtn05.titleLabel.textColor = [UIColor colorWithRed:0.95 green:0.93 blue:0.89 alpha:1.0];
    
    
    
    
    [_detailView setFrame:CGRectMake(320, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    _historiaView.alpha = 0.0;
    _sitiosView.alpha = 0.0;
    _dvcView.alpha = 0.0;
    
    
    
}

- (IBAction)showMenu:(UIButton *)sender {
    
    if (menuOut == FALSE) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_menuView setFrame:CGRectMake(9, 51, 166, 506)];
                             _menuView.alpha = 1.0;
                         }
                         completion:^(BOOL finished){
                         }];
        menuOut = TRUE;
        
        _menuView.layer.zPosition = 1;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             [scrollview setFrame:CGRectMake(300, 52, 222, 504)];
                             [_sitiosFiltrosBTN setFrame:CGRectMake(280, 282, 32, 41)];
                         }
                         completion:^(BOOL finished){
                             [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             [scrollview removeFromSuperview];
                         }];
        
        sitiosFiltro = FALSE;
        [_sitiosFiltrosBTN setSelected:NO];
    }
    else if (menuOut == TRUE){
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_menuView setFrame:CGRectMake(-137, 51, 166, 506)];
                             _menuView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                         }];
        menuOut = FALSE;
    }
    
}

- (IBAction)showSitiosFiltros:(UIButton *)sender {
    
    if (sitiosFiltro == FALSE) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_sitiosFiltrosBTN setFrame:CGRectMake(58, 282, 32, 41)];
                         }
                         completion:^(BOOL finished){
                         }];
        sitiosFiltro = TRUE;
        [_sitiosFiltrosBTN setSelected:YES];
        
        [self ibaBoton1:sender];
    }
    else if (sitiosFiltro == TRUE) {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_sitiosFiltrosBTN setFrame:CGRectMake(280, 282, 32, 41)];
                             [scrollview setFrame:CGRectMake(300, 52, 222, 502)];
                             [_menuView setFrame:CGRectMake(-137, 51, 166, 506)];
                             _menuView.alpha = 0.0;
                         }
                         completion:^(BOOL finished){
                             [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             [scrollview removeFromSuperview];
                         }];
        
        sitiosFiltro = FALSE;
        [_sitiosFiltrosBTN setSelected:NO];
        
        menuOut = FALSE;


    }
}

- (IBAction)menuPrincipal:(UIButton *)sender {
    
    _menuView.layer.zPosition = 1;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [_menuView setFrame:CGRectMake(-137, 51, 166, 506)];
                         _menuView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                     }];
    
    menuOut = FALSE;
    
    if (sender.tag == 1) {
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Sitios de Interés"];
        [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
        
        _currentSecLbl.attributedText = attrStr;
        
        _sitiosView.alpha = 1.0;
        _historiaView.alpha = 0.0;
        _dvcView.alpha = 0.0;
        [evView removeFromSuperview];
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
        
        NSMutableArray * annotationsToRemove = [ mapView.annotations mutableCopy ] ;
        [ annotationsToRemove removeObject:mapView.userLocation ] ;
        [ mapView removeAnnotations:annotationsToRemove ] ;
        
            // Array
        NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
        
            // Create some annotations
        ZSAnnotation *annotation = nil;
        
        annotation = [[ZSAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake(25.6485119,-100.355266);
        annotation.type = ZSPinAnnotationTypeTag;
        annotation.color = RGB(72, 83, 59);
        annotation.title = @"Arboleda";
        annotation.tag = 11;
        [annotationArray addObject:annotation];
        
        [self.mapView addAnnotations:annotationArray];
        
        [_menuInteresBTN setBackgroundColor:[UIColor lightGrayColor]];
        [_menuHistoriaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuCulturaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuEventosBTN setBackgroundColor:[UIColor clearColor]];
        [_menuDvcBTN setBackgroundColor:[UIColor clearColor]];
    }
    else  if (sender.tag == 2) {
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Historia"];
        [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
        
        _currentSecLbl.attributedText = attrStr;
        
        _sitiosView.alpha = 0.0;
        _historiaView.alpha = 1.0;
        _dvcView.alpha = 0.0;
        [evView removeFromSuperview];
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
        
        [self loadHistoria];
        
        [_menuInteresBTN setBackgroundColor:[UIColor clearColor]];
        [_menuHistoriaBTN setBackgroundColor:[UIColor lightGrayColor]];
        [_menuCulturaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuEventosBTN setBackgroundColor:[UIColor clearColor]];
        [_menuDvcBTN setBackgroundColor:[UIColor clearColor]];
    }
    else  if (sender.tag == 3) {
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Cultura"];
        [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
        
        _currentSecLbl.attributedText = attrStr;
        
        _sitiosView.alpha = 0.0;
        _historiaView.alpha = 0.0;
        _dvcView.alpha = 0.0;
        [evView removeFromSuperview];
        
        [_menuInteresBTN setBackgroundColor:[UIColor clearColor]];
        [_menuHistoriaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuCulturaBTN setBackgroundColor:[UIColor lightGrayColor]];
        [_menuEventosBTN setBackgroundColor:[UIColor clearColor]];
        [_menuDvcBTN setBackgroundColor:[UIColor clearColor]];
    }
    else  if (sender.tag == 4) {
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Eventos"];
        [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
        
        _currentSecLbl.attributedText = attrStr;
        
        _sitiosView.alpha = 0.0;
        _historiaView.alpha = 0.0;
        _dvcView.alpha = 0.0;
            // [evView removeFromSuperview];
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
        
        [_menuInteresBTN setBackgroundColor:[UIColor clearColor]];
        [_menuHistoriaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuCulturaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuEventosBTN setBackgroundColor:[UIColor lightGrayColor]];
        [_menuDvcBTN setBackgroundColor:[UIColor clearColor]];
    }
    else  if (sender.tag == 5) {
        NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] initWithString: @"Distrito Valle del Campestre"];
        [attrStr addAttribute:NSKernAttributeName value:@(0.55) range:NSMakeRange(0, attrStr.length)];
        
        _currentSecLbl.attributedText = attrStr;
        
        _sitiosView.alpha = 0.0;
        _historiaView.alpha = 0.0;
        _dvcView.alpha = 1.0;
        [evView removeFromSuperview];
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
        
        
        [_menuInteresBTN setBackgroundColor:[UIColor clearColor]];
        [_menuHistoriaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuCulturaBTN setBackgroundColor:[UIColor clearColor]];
        [_menuEventosBTN setBackgroundColor:[UIColor clearColor]];
        [_menuDvcBTN setBackgroundColor:[UIColor lightGrayColor]];
    }
}

#pragma mark - Detalles
    //Sitios culturales: 96, 169, 166
    //Restaurantes: 166, 31, 15
    //Nightlife: 64, 5, 4
    //Plazas Comerciales: 193, 65, 77
    //Torres de Negocios: 78, 132, 132
    //Hoteles: 149, 189, 181
    //25.6485119,-100.355266

- (IBAction)socialMenu:(UIButton *)sender {
 
    ZSAnnotation *annotationPin = [[mapView selectedAnnotations] objectAtIndex:0];
    
    
    MFMailComposeViewController *controller1 = [[MFMailComposeViewController alloc] init];
    controller1.mailComposeDelegate = self;
    
    NSString *facebook = [NSString stringWithFormat:@"https://www.facebook.com/%@",annotationPin.facebookURL];
    
    NSString *twitter = [NSString stringWithFormat:@"https://www.twitter.com/%@",annotationPin.twitterURL];
    
    if (sender.tag == 1) {
            //facebook
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:facebook]];
    }
    else if (sender.tag == 2) {
            //twitter
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:twitter]];
    }
    else if (sender.tag == 3) {
            //correo
        if ([MFMailComposeViewController canSendMail]) {
            [controller1 setSubject:@"Informes Descubre San Pedro"];
           
            NSArray *toRecipients = [NSArray arrayWithObjects:annotationPin.mailURL,nil];
            [controller1 setToRecipients:toRecipients];
        }
        [self presentViewController:controller1 animated:YES completion:nil];
    }
    else if (sender.tag == 4) {
            //web
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:annotationPin.webURL]];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error{
    [self dismissViewControllerAnimated:YES completion:nil];
        // [self dismissModalViewControllerAnimated:YES];
}

- (void) showDetails:(ZSAnnotation *)annotation{
    
    ZSAnnotation *annotationPin = [[mapView selectedAnnotations] objectAtIndex:0];
    
    if ([annotationPin.title isEqualToString:@"Arboleda"]) {
            _arboledaView.alpha = 1.0;
        
        [UIView animateWithDuration:0.7
                         animations:^{
                                 [_arboledaView setFrame:CGRectMake(0, 0, _arboledaView.frame.size.width, _arboledaView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
    else {
        [UIView animateWithDuration:0.7
                         animations:^{
                             [_detailView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                         }];
        
        [_detailName setText:annotationPin.title];
        [_detailGiro setText:annotationPin.giro];
        [_detailTxt setText:annotationPin.desc];
        [_detailTxt setFont:[UIFont fontWithName:@"GaramondPremrPro" size:14.0]];
        
        [_detailName setNumberOfLines:0];
            // [detailTxt sizeToFit];
        
        [_detailIMG00 setImage:annotationPin.image00];
        [_detailIMG01 setImage:annotationPin.image01];
        [_detailIMG02 setImage:annotationPin.image02];
        [_detailIMG03 setImage:annotationPin.image03];
        [_detailIMG04 setImage:annotationPin.image04];
        
        if ([annotationPin.facebookURL isEqualToString:@"inkstudiomx360"]) {
            [_detailBtnFB setEnabled:NO];
        }
        else {
            [_detailBtnFB setEnabled:YES];
        }
        
        if ([annotationPin.twitterURL isEqualToString:@"inkstudiomx360"]) {
            [_detailBtnTwitter setEnabled:NO];
        }
        else {
            [_detailBtnTwitter setEnabled:YES];
        }
        
        if ([annotationPin.mailURL isEqualToString:@"inkstudiomx360@inkstudiomx360.com"]) {
            [_detailBtnMail setEnabled:NO];
        }
        else {
            [_detailBtnMail setEnabled:YES];
        }
        
        if ([annotationPin.webURL isEqualToString:@"http://www.inkstudiomx360.com"]) {
            [_detailBtnWeb setEnabled:NO];
        }
        else {
            [_detailBtnWeb setEnabled:YES];
        }
    }
}

- (IBAction)detailClose:(UIButton *)sender {
    if (sender.tag == 1) {
        [UIView animateWithDuration:0.7
                         animations:^{
                             [_detailView setFrame:CGRectMake(350, 0, self.view.frame.size.width, self.view.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             [_detailScroll setContentOffset:CGPointMake(0, 0)];
                             [_detailPageControl setCurrentPage:1];
                         }];
    }
    else if (sender.tag == 2) {
        [UIView animateWithDuration:0.7
                         animations:^{
                             [_arboledaView setFrame:CGRectMake(350, 0, _arboledaView.frame.size.width, _arboledaView.frame.size.height)];
                             
                         }
                         completion:^(BOOL finished){
                             [_detailScroll setContentOffset:CGPointMake(0, 0)];
                             [_detailPageControl setCurrentPage:1];
                         }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat detalleWidth = _detailScroll.frame.size.width;
    
    int paginaDetalle = floor((_detailScroll.contentOffset.x - detalleWidth / 2) / detalleWidth) + 1;
    _detailPageControl.currentPage = paginaDetalle;
    
    CGFloat historiaWidth = 301;
    int paginaAntecedentes = floor((_historiaScroll.contentOffset.x - historiaWidth / 2) / historiaWidth) + 1;
    
  /*
    if (paginaAntecedentes == 0) {
        [_historiaYearLbl setText:@"1579"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se establece el Nuevo Reino de León.\nEl choque cultural provoca violencia entre españoles y nativos, quienes huyeron hacia el norte."];
        else
            [_historiaTextLbl setText:@"Nuevo Reino de Leon is established.\nThe cultural shock provokes violence between Spaniards and natives, who fled north."];
    }
    else if (paginaAntecedentes == 1) {
        [_historiaYearLbl setText:@"1596"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Diego de Montemayor, fundador de Monterrey otorga el terreno, conocido como “Hacienda los Nogales”, a su hijo Diego de Montemayor “El Mozo”."];
        else
            [_historiaTextLbl setText:@"Diego de Montemayor, Monterrey's founder, grants the land known as ""Hacienda los Nogales"" to his son Diego de Montemayor ""El Mozo""."];
    }
    else if (paginaAntecedentes == 2) {
        [_historiaYearLbl setText:@"1700"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"El Valle de San Pedro se convierte en el principal proveedor de frutos y legumbres de Monterrey."];
        else
            [_historiaTextLbl setText:@"The San Pedro Valley becomes the main supplier of fruits and vegetables of Monterrey."];
    }
    else if (paginaAntecedentes == 3) {
        [_historiaYearLbl setText:@"1800"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Las casas comienzan a ubicarse en lo que hoy es el Casco de San Pedro y se cambia el nombre a “Hacienda San Pedro”."];
        else
            [_historiaTextLbl setText:@"The houses begin to settle in what is now the Town of San Pedro and the name is changed to ""Hacienda San Pedro""."];
    }
    else if (paginaAntecedentes == 4) {
        [_historiaYearLbl setText:@"1842"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se adquieren las tierras del fraccionamiento Valle del Seminario, en las que se construyó el primer molino, donde se elaboraría la harina “Río Bravo”."];
        else
            [_historiaTextLbl setText:@"The lands of the Valle del Seminario complex are acquired, in which the first mill was built, where the ""Rio Bravo"" flour would be developed."];
    }
    else if (paginaAntecedentes == 5) {
        [_historiaYearLbl setText:@"1865"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Abre la primer escuela pública, a la que asistían 75 niños para aprender a leer y a escribir, estudiar matemáticas y religión."];
        else
            [_historiaTextLbl setText:@"The first public school is opened for 75 children who would attend to learn to read and write, study math and religion."];
    }
    else if (paginaAntecedentes == 6) {
        [_historiaYearLbl setText:@"1887"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Concluye la construcción de la Parroquia de Guadalupe, la cual es destruida en 1965."];
        else
            [_historiaTextLbl setText:@"Concludes the construction of the Church of Guadalupe, which was destroyed in 1965."];
    }
    else if (paginaAntecedentes == 7) {
        [_historiaYearLbl setText:@"1927"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se funda la Logia Masónica de San Pedro."];
        else
            [_historiaTextLbl setText:@"Masonic Lodge of San Pedro is founded."];
    }
    else if (paginaAntecedentes == 8) {
        [_historiaYearLbl setText:@"1933"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Juan Andreu Almazán conecta la actual Avenida Vasconcelos con la carretera a Chipinque, ahora conocida como Gómez Morín."];
        else
            [_historiaTextLbl setText:@"Juan Andreu Almazan connects the current Avenida Vasconcelos with Chipinque road, now known as Gomez Morin."];
    }
    else if (paginaAntecedentes == 9) {
        [_historiaYearLbl setText:@"1940"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Jesús Llaguno comienza a fundar empresas en las siguientes décadas, entre las que se encuentran Textiles del Norte y Nylon de México."];
        else
            [_historiaTextLbl setText:@"Jesus Llaguno begins to form companies in the following decades, among which are North and Nylon Textiles of Mexico."];
    }
    else if (paginaAntecedentes == 10) {
        [_historiaYearLbl setText:@"1950"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inaugura la empresa ACCO, donde se elaboraba la manteca INCA y la crema de cacahuate Aladino."];
        else
            [_historiaTextLbl setText:@"Company ACCO where INCA butter and Aladdin peanut butter is produced opens."];
    }
    else if (paginaAntecedentes == 11) {
        [_historiaYearLbl setText:@"1954"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inaugura el Club Campestre de Monterrey con los primeros 9 hoyos, contribuyendo al inicio del desarrollo del municipio."];
        else
            [_historiaTextLbl setText:@"Monterrey Country Club opens with the first 9 holes, contributing to the early development of the municipality."];
    }
    else if (paginaAntecedentes == 12) {
        [_historiaYearLbl setText:@"1955"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se funda Cerámica Regiomontana S.A., principal productora de azulejos para pisos y paredes."];
        else
            [_historiaTextLbl setText:@"Ceramica Regiomontana S.A., the main producer of tiles for floors and walls is founded."];
    }
    else if (paginaAntecedentes == 13) {
        [_historiaYearLbl setText:@"1959"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Las calles se iluminan por primera vez y, con sólo 35 alumnos, inicia labores la primera escuela secundaria; la cual fue inaugurada en el Barrio de Tampiquito."];
        else
            [_historiaTextLbl setText:@"The streets are lit for the first time and, with only 35 students, the first high school started working, which was opened in the neighborhood of Tampiquito."];
    }
    else if (paginaAntecedentes == 14) {
        [_historiaYearLbl setText:@"1976"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"The new Municipal Palace is built on the same site of the old building.\nAlfa Group buys Spinning and Weaving Factory ""La Leona""."];
        else
            [_historiaTextLbl setText:@"Se construye el Nuevo Palacio Municipal en el mismo lugar del antiguo edificio.\nGrupo Alfa compra la Fábrica de Hilados y Tejidos “La Leona”."];
    }
    else if (paginaAntecedentes == 15) {
        [_historiaYearLbl setText:@"1978"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inaugura la Rotonda de la Alianza para la Producción, también conocida como “Los Tubos”."];
        else
            [_historiaTextLbl setText:@"The Allience for the Production Roundabout inaugurates, also known as “Los Tubos”."];
    }
    else if (paginaAntecedentes == 16) {
        [_historiaYearLbl setText:@"1980"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inauguran la Casa de la Cultura y el museo El Centenario.\nTambién se instala la escultura de Diana la Cazadora y la estatua de chatarra del apóstol San Pedro."];
        else
            [_historiaTextLbl setText:@"The Culture House and El Centenario museum were inaugurated.\nThe sculpture of Diana the Huntress and the scrap statue of St. Peter the Apostle are also installed."];
    }
    else if (paginaAntecedentes == 17) {
        [_historiaYearLbl setText:@"1983"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se construye un modelo habitacional con 551 casas, la ahora conocida Colonia Lázaro Garza Ayala."];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"A housing model with 551 houses were built, the now known Colonia Lazaro Garza Ayala."];
    }
    else if (paginaAntecedentes == 18) {
        [_historiaYearLbl setText:@"1990"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inaugura el Parque Rufino Tamayo."];
        else
            [_historiaTextLbl setText:@"Rufino Tamayo Park opens."];
    }
    else if (paginaAntecedentes == 19) {
        [_historiaYearLbl setText:@"2001"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Se inaugura el Puente Atirantado."];
        else
            [_historiaTextLbl setText:@"The Puente Atirantado opens."];
    }
    else if (paginaAntecedentes == 20) {
        [_historiaYearLbl setText:@"Presente"];
        if (spanish == TRUE)
            [_historiaTextLbl setText:@"Así es como luce el municipio de San Pedro en la actualidad, la ciudad modelo de México."];
        else
            [_historiaTextLbl setText:@"This is how the town of San Pedro looks today, a model city in Mexico."];
    }
    */
    
    
    if (historiaPag == 1) {
        _historiaRwBtn.hidden = YES;
        _historiaFwdBtn.hidden = NO;
    }
    else if (historiaPag == 21) {
        _historiaRwBtn.hidden = NO;
        _historiaFwdBtn.hidden = YES;
    }
    else {
        _historiaRwBtn.hidden = NO;
        _historiaFwdBtn.hidden = NO;
    }
    
    if (paginaAntecedentes == 0) {
        [_historiaYearLbl setText:@"1579"];
        [_historiaTextLbl setText:@"Se establece el Nuevo Reino de León.\nEl choque cultural provoca violencia entre españoles y nativos, quienes huyeron hacia el norte."];
    }
    else if (paginaAntecedentes == 1) {
        [_historiaYearLbl setText:@"1596"];
        [_historiaTextLbl setText:@"Diego de Montemayor, fundador de Monterrey otorga el terreno, conocido como “Hacienda los Nogales”, a su hijo Diego de Montemayor “El Mozo”."];
    }
    else if (paginaAntecedentes == 2) {
        [_historiaYearLbl setText:@"1700"];
        [_historiaTextLbl setText:@"El Valle de San Pedro se convierte en el principal proveedor de frutos y legumbres de Monterrey."];
    }
    else if (paginaAntecedentes == 3) {
        [_historiaYearLbl setText:@"1800"];
        [_historiaTextLbl setText:@"Las casas comienzan a ubicarse en lo que hoy es el Casco de San Pedro y se cambia el nombre a “Hacienda San Pedro”."];
    }
    else if (paginaAntecedentes == 4) {
        [_historiaYearLbl setText:@"1842"];
        [_historiaTextLbl setText:@"Se adquieren las tierras del fraccionamiento Valle del Seminario, en las que se construyó el primer molino, donde se elaboraría la harina “Río Bravo”."];
    }
    else if (paginaAntecedentes == 5) {
        [_historiaYearLbl setText:@"1865"];
        [_historiaTextLbl setText:@"Abre la primer escuela pública, a la que asistían 75 niños para aprender a leer y a escribir, estudiar matemáticas y religión."];
    }
    else if (paginaAntecedentes == 6) {
        [_historiaYearLbl setText:@"1887"];
        [_historiaTextLbl setText:@"Concluye la construcción de la Parroquia de Guadalupe, la cual es destruida en 1965."];
    }
    else if (paginaAntecedentes == 7) {
        [_historiaYearLbl setText:@"1927"];
        [_historiaTextLbl setText:@"Se funda la Logia Masónica de San Pedro."];
    }
    else if (paginaAntecedentes == 8) {
        [_historiaYearLbl setText:@"1933"];
        [_historiaTextLbl setText:@"Juan Andreu Almazán conecta la actual Avenida Vasconcelos con la carretera a Chipinque, ahora conocida como Gómez Morín."];
    }
    else if (paginaAntecedentes == 9) {
        [_historiaYearLbl setText:@"1940"];
        [_historiaTextLbl setText:@"Jesús Llaguno comienza a fundar empresas en las siguientes décadas, entre las que se encuentran Textiles del Norte y Nylon de México."];
    }
    else if (paginaAntecedentes == 10) {
        [_historiaYearLbl setText:@"1950"];
        [_historiaTextLbl setText:@"Se inaugura la empresa ACCO, donde se elaboraba la manteca INCA y la crema de cacahuate Aladino."];
    }
    else if (paginaAntecedentes == 11) {
        [_historiaYearLbl setText:@"1954"];
        [_historiaTextLbl setText:@"Se inaugura el Club Campestre de Monterrey con los primeros 9 hoyos, contribuyendo al inicio del desarrollo del municipio."];
    }
    else if (paginaAntecedentes == 12) {
        [_historiaYearLbl setText:@"1955"];
        [_historiaTextLbl setText:@"Se funda Cerámica Regiomontana S.A., principal productora de azulejos para pisos y paredes."];
    }
    else if (paginaAntecedentes == 13) {
        [_historiaYearLbl setText:@"1959"];
        [_historiaTextLbl setText:@"Las calles se iluminan por primera vez y, con sólo 35 alumnos, inicia labores la primera escuela secundaria; la cual fue inaugurada en el Barrio de Tampiquito."];
    }
    else if (paginaAntecedentes == 14) {
        [_historiaYearLbl setText:@"1976"];
        [_historiaTextLbl setText:@"Se construye el Nuevo Palacio Municipal en el mismo lugar del antiguo edificio.\nGrupo Alfa compra la Fábrica de Hilados y Tejidos “La Leona”."];
    }
    else if (paginaAntecedentes == 15) {
        [_historiaYearLbl setText:@"1978"];
        [_historiaTextLbl setText:@"Se inaugura la Rotonda de la Alianza para la Producción, también conocida como “Los Tubos”."];
    }
    else if (paginaAntecedentes == 16) {
        [_historiaYearLbl setText:@"1980"];
        [_historiaTextLbl setText:@"Se inauguran la Casa de la Cultura y el museo El Centenario.\nTambién se instala la escultura de Diana la Cazadora y la estatua de chatarra del apóstol San Pedro."];
    }
    else if (paginaAntecedentes == 17) {
        [_historiaYearLbl setText:@"1983"];
        [_historiaTextLbl setText:@"Se construye un modelo habitacional con 551 casas, la ahora conocida Colonia Lázaro Garza Ayala."];
    }
    else if (paginaAntecedentes == 18) {
        [_historiaYearLbl setText:@"1990"];
        [_historiaTextLbl setText:@"Se inaugura el Parque Rufino Tamayo."];
    }
    else if (paginaAntecedentes == 19) {
        [_historiaYearLbl setText:@"2001"];
        [_historiaTextLbl setText:@"Se inaugura el Puente Atirantado."];
    }
    else if (paginaAntecedentes == 20) {
        [_historiaYearLbl setText:@"Presente"];
        [_historiaTextLbl setText:@"Así es como luce el municipio de San Pedro en la actualidad, la ciudad modelo de México."];
    }
 
    [_historiaTextLbl setNumberOfLines:0];
        //[_historiaTextLbl sizeToFit];
    
    historiaPag = paginaAntecedentes +1;
}

#pragma mark - MapKit

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    return flyTo;
    
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"ann.title = %@", view.annotation.title);
}

- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
        // Don't mess with user location
    if(![annotation isKindOfClass:[ZSAnnotation class]])
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
        // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[mV dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [button setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    pinView.rightCalloutAccessoryView = button;
    pinView.annotationType = a.type;
    pinView.annotationColor = a.color;
        //   pinView.annotationTag = a.tag;
    [button addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    [pinView setEnabled:YES];
    pinView.canShowCallout = YES;
    
    
    NSLog(@"pin %i", pinView.annotationTag);
    
    return pinView;
    
}

#pragma mark - DVC

- (IBAction)menuDVC:(UIButton *)sender {
    
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentJustified];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [style setLineSpacing:12];
    
    UIFont *font1 = [UIFont fontWithName:@"GaramondPremrPro" size:14.0];
    
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style};
    
    NSMutableAttributedString *attString1 = [[NSMutableAttributedString alloc] init];
    
    if (sender.tag == 1) {//Nostros
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_dvcSeccionView setFrame:CGRectMake(0, 0, 320, 504)];
                         }
                         completion:^(BOOL finished){
                         }];
        [_dvcSeccionLbl setText:@"NOSOTROS"];
        
        [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"El proyecto DVC es un proceso de Construcción de un Modelo urbano y de comunidad para mejorar la calidad de vida del Sector y del Municipio, eventualmente. Es un modelo que propone:\n\n•	  Innovación. La construcción de este modelo se lleva a cabo conjuntamente con la visión de expertos locales nutrida por expertos internacionales, que proponen modelos y métodos innovadores de alto nivel, utilizados y probados a nivel internacional\n\n•	Visión compartida. El Modelo DVC incluye la visión compartida de las necesidades y propuestas de los diferentes entornos que conforman la comunidad como vecinos, escuelas, comercios y comunidad en general\n\n•	 Inclusión de la autoridad. El modelo DVC incluye a la autoridad dentro del desarrollo del proyecto a fin de compaginar necesidades y acordar términos legales para su desarrollo" attributes:dict1]];
        [_dvcDescripTxt setAttributedText:attString1];
        
    }
    else if (sender.tag == 2) {//Historia
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_dvcSeccionView setFrame:CGRectMake(0, 0, 320, 504)];
                         }
                         completion:^(BOOL finished){
                         }];
        [_dvcSeccionLbl setText:@"HISTORIA"];
        
        [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"En el 2013 se empezaron a juntar distintos miembros de la comunidad con la problemática del tráfico que ocasionarían los nuevos desarrollos en el Distrito. Esto era y es una preocupación para vecinos, escuelas, comercios y los desarrollos mismos. Se consiguió una inversión privada para hacer un estudio en la zona, primero teniendo en mente sólo el tráfico, pero la visión se ha ido transformando hacia un proyecto integrador.\n\nConsultores:\n\n-  Federico Cassanni (Mobility in Chain). Empresa con base en Italia, expertos en movilidad.\n\n-  Dennis Frenchman (MIT) – Director del área de Urbanismo de la institución académica.\n\n-  David Leland. Consultor independiente con más de 40 años de experiencia en proyectos inmobiliarios y de Distritos como DVC.\n\nDurante el 2013 se organizaron tres talleres junto con los consultores, la comunidad y el gobierno, en los que se definió un Plan Maestro para el Distrito. " attributes:dict1]];
        [_dvcDescripTxt setAttributedText:attString1];
    
    }
    else if (sender.tag == 3) {//Principios
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_dvcSeccionView setFrame:CGRectMake(0, 0, 320, 504)];
                         }
                         completion:^(BOOL finished){
                         }];
        [_dvcSeccionLbl setText:@"PRINCIPIOS"];
        
        [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"1. Preservar las zonas residenciales.\nTomando en cuenta las preocupaciones y visiones de los vecinos.\n\n2. Mejorar todos los tipos de movilidad.\nTransformar desde la infraestructura hasta la cultura para aprovechar mejor las calles y convertirlas en espacios donde automovilistas, patones, ciclistas y usuarios de transporte público puedan convivir en perfecta armonía.\n\n3. Incrementar la conectividad y accesibilidad entre las partes.\nMediante la recuperación y revitalización de espacios y calles, se disminuirán los tiempos de traslado en la zona y se aumentará la calidad de vida.\n\n4. Crear una red ajardinada de espacios públicos interconectados.\nEl equilibrio entre el respeto al medio ambiente y la creación de mejores espacios públicos se refleja en diversas propuestas como el Parque lineal perimétrico del Club Campestre y el Parque “Plaza la Alianza”." attributes:dict1]];
        [_dvcDescripTxt setAttributedText:attString1];
    }
    else if (sender.tag == 4) {//Comunidad
        [UIView animateWithDuration:0.5
                         animations:^{
                             [_dvcSeccionView setFrame:CGRectMake(0, 0, 320, 504)];
                         }
                         completion:^(BOOL finished){
                         }];
        [_dvcSeccionLbl setText:@"RELACION CON LA COMUNIDAD"];
        
        [attString1 appendAttributedString:[[NSAttributedString alloc] initWithString:@"Vecinos\n- Contacto constante con los Presidentes de 5 colonias del Distrito.\n- Presentaciones del DVC a Juntas vecinales.\n- Apoyo a los vecinos integrantes de la Comisión Mixta en temas de Desarrollo Urbano y Movilidad.\n\nEscuelas\n- Reuniones uno a uno con los directivos y algunos maestros de las escuelas para compartir visión DVC.\n- Taller de dibujo con niños del Instituto San Roberto (ISR).\n- Encuesta a padres de familia del Instituto San Roberto (ISR).\n- Reunión con madres de familia del Instituto Irlandés.\n- Recomendaciones en tema de movilidad al ISR, la primera que se implementará será un sistema de “car-pooling” es el instituto a través de la plataforma “Aventones”.\n\nONGs\nParticipación en eventos organizados por ONGs que tienen relación a los principios del DVC. Ejemplos recientes:\n-  Día de la Ciudad – Distrito Tec\n-  Taller del BiciPlan – Moisés López, El Narval e IDOM\n-  Foro Metropolitano – Academia Nacional de Arquitectura\n-  Paseo Metropolitano – Alcalde ¿cómo vamos?\n-  Agenda ciudadana: mesas de movilidad y planeación urbana – Consejo Cívico\n-  City manager de Evolución Mexicana\n-  Reunión de Distritos: Distrito Tec, Distrito la Purísima, Polígono Edison y DVC.\n\nGobierno\nImplan San Pedro: Este organismo ha sido un aliado clave en la relación con la administración municipal. Desde el inicio se ha trabajado en todos los talleres con ellos, además de reuniones de trabajo periódicas.\nImplanc Monterrey: Colaboración en la gestión inicial de un plan parcial para el distrito y colaboración activa en el evento Monterrey Creativa, coordinado por el Laboratorio de Convivencia. " attributes:dict1]];
        [_dvcDescripTxt setAttributedText:attString1];
        
    }
    else if (sender.tag == 5) {//Sugerencias
        
    }
}

- (IBAction)dvcBack:(id)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [_dvcSeccionView setFrame:CGRectMake(320, 0, 320, 504)];
                     }
                     completion:^(BOOL finished){
                     }];
}

#pragma mark - Historia

- (void) loadHistoria {
    
    _historiaRwBtn.hidden = YES;
    _historiaFwdBtn.hidden = NO;
    
    NSUInteger i;
    for (i = 1; i <= hNumImages; i++){
        NSString *imageName = [NSString stringWithFormat:@"anteimg%lu.jpg", (unsigned long)i];
            //UIImage *image = [UIImage imageNamed:imageName];
        
        NSString *filePath=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imageName];
        UIImage *image=[UIImage imageWithContentsOfFile:filePath];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = 504;
        rect.size.width = hScrollObjWidth;
        imageView.frame = rect;
        imageView.tag = i;
        [_historiaScroll addSubview:imageView];
    }
    
    [_historiaScroll setCanCancelContentTouches:NO];
    _historiaScroll.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    _historiaScroll.clipsToBounds = YES;
    _historiaScroll.scrollEnabled = YES;
    _historiaScroll.pagingEnabled = YES;
    _historiaScroll.bounces = NO;
    _historiaScroll.showsVerticalScrollIndicator = NO;
    _historiaScroll.showsHorizontalScrollIndicator = NO;
    _historiaScroll.delegate = self;
    
    [self layoutScrollImages];
    
}

- (void)layoutScrollImages {
    UIImageView *view1 = nil;
    NSArray *subviews1 = [_historiaScroll subviews];
    
    CGFloat curXLoc1 = 0;
    for (view1 in subviews1)
    {
        if ([view1 isKindOfClass:[UIImageView class]] && view1.tag > 0)
        {
            CGRect frame = view1.frame;
            frame.origin = CGPointMake(curXLoc1, 0);
            view1.frame = frame;
            
            curXLoc1 += (hScrollObjWidth);
        }
    }
    
    [_historiaScroll setContentSize:CGSizeMake((hNumImages * hScrollObjWidth), 504)];
}

- (IBAction)menuHistoria:(UIButton *)sender {
    
    if (sender.tag == 1) {
        if (historiaPag > 1) {
            [_historiaScroll setContentOffset:CGPointMake(_historiaScroll.contentOffset.x-_historiaScroll.frame.size.width, 0)];
        }
    }
    else if (sender.tag == 2) {
        if (historiaPag < 22) {
            [_historiaScroll setContentOffset:CGPointMake(_historiaScroll.frame.size.width *historiaPag, 0)];
        }
    }
    
    if (historiaPag == 1) {
        _historiaRwBtn.hidden = YES;
        _historiaFwdBtn.hidden = NO;
    }
    else if (historiaPag == 21) {
        _historiaRwBtn.hidden = NO;
        _historiaFwdBtn.hidden = YES;
    }
    else {
        _historiaRwBtn.hidden = NO;
        _historiaFwdBtn.hidden = NO;
    }
}

#pragma mark - Pedro

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)defaultCategoriasNeg
{
    NSString *jsonString = @"{\"categorias\":[{\"idCategoria\":\"-1\",\"nombre\":\"Ninguna\",\"idPadre\":\"0\"},{\"idCategoria\":\"1\",\"nombre\":\"Areas de recreacion\",\"idPadre\":\"0\"},{\"idCategoria\":\"2\",\"nombre\":\"parques\",\"idPadre\":\"1\"},{\"idCategoria\":\"3\",\"nombre\":\"deportivos\",\"idPadre\":\"1\"},{\"idCategoria\":\"4\",\"nombre\":\"gimnasios\",\"idPadre\":\"1\"},{\"idCategoria\":\"5\",\"nombre\":\"talleres y studios\",\"idPadre\":\"1\"},{\"idCategoria\":\"6\",\"nombre\":\"Productos locales\",\"idPadre\":\"0\"},{\"idCategoria\":\"7\",\"nombre\":\"productos organicos\",\"idPadre\":\"6\"},{\"idCategoria\":\"8\",\"nombre\":\"reposteria\",\"idPadre\":\"6\"},{\"idCategoria\":\"9\",\"nombre\":\"ropa y accesorios\",\"idPadre\":\"6\"},{\"idCategoria\":\"10\",\"nombre\":\"varios\",\"idPadre\":\"6\"},{\"idCategoria\":\"11\",\"nombre\":\"Sitios culturales\",\"idPadre\":\"0\"},{\"idCategoria\":\"12\",\"nombre\":\"museos\",\"idPadre\":\"11\"},{\"idCategoria\":\"13\",\"nombre\":\"galerias\",\"idPadre\":\"11\"},{\"idCategoria\":\"14\",\"nombre\":\"monumentos\",\"idPadre\":\"11\"},{\"idCategoria\":\"15\",\"nombre\":\"bibliotecas\",\"idPadre\":\"11\"},{\"idCategoria\":\"16\",\"nombre\":\"eventos\",\"idPadre\":\"11\"},{\"idCategoria\":\"17\",\"nombre\":\"Restaurantes\",\"idPadre\":\"0\"},{\"idCategoria\":\"18\",\"nombre\":\"mexicana\",\"idPadre\":\"17\"},{\"idCategoria\":\"19\",\"nombre\":\"internacional\",\"idPadre\":\"17\"},{\"idCategoria\":\"20\",\"nombre\":\"fusion\",\"idPadre\":\"17\"},{\"idCategoria\":\"21\",\"nombre\":\"food truck\",\"idPadre\":\"17\"},{\"idCategoria\":\"22\",\"nombre\":\"comida rapida\",\"idPadre\":\"17\"},{\"idCategoria\":\"23\",\"nombre\":\"cafes\",\"idPadre\":\"17\"},{\"idCategoria\":\"24\",\"nombre\":\"Nightlife\",\"idPadre\":\"0\"},{\"idCategoria\":\"25\",\"nombre\":\"antros\",\"idPadre\":\"24\"},{\"idCategoria\":\"26\",\"nombre\":\"bares\",\"idPadre\":\"24\"},{\"idCategoria\":\"27\",\"nombre\":\"musica en vivo\",\"idPadre\":\"24\"},{\"idCategoria\":\"28\",\"nombre\":\"Plazas comerciales\",\"idPadre\":\"0\"},{\"idCategoria\":\"29\",\"nombre\":\"Autoservicio\",\"idPadre\":\"0\"},{\"idCategoria\":\"30\",\"nombre\":\"Torres de Negocios\",\"idPadre\":\"0\"},{\"idCategoria\":\"31\",\"nombre\":\"Hoteles\",\"idPadre\":\"0\"},{\"idCategoria\":\"32\",\"nombre\":\"int01\",\"idPadre\":\"19\"},{\"idCategoria\":\"33\",\"nombre\":\"int02\",\"idPadre\":\"32\"},{\"idCategoria\":\"34\",\"nombre\":\"int03\",\"idPadre\":\"33\"}]}";
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [self insUpdCD:@"INSERT" datos:json];
}

-(void)defaultCategoriasCult
{
    NSString *jsonString = @"{\"zCl_categorias\":[{\"idCategoria\":\"-1\",\"nombre\":\"Ninguna\",\"idPadre\":\"0\"},{\"idCategoria\":\"1\",\"nombre\":\"Fotografia\",\"idPadre\":\"0\"},{\"idCategoria\":\"2\",\"nombre\":\"Arquitectura\",\"idPadre\":\"0\"},{\"idCategoria\":\"3\",\"nombre\":\"Gastronomia\",\"idPadre\":\"0\"},{\"idCategoria\":\"4\",\"nombre\":\"Escultura\",\"idPadre\":\"0\"},{\"idCategoria\":\"5\",\"nombre\":\"Naturaleza\",\"idPadre\":\"0\"},{\"idCategoria\":\"6\",\"nombre\":\"Pintura\",\"idPadre\":\"0\"},{\"idCategoria\":\"7\",\"nombre\":\"Posters\",\"idPadre\":\"0\"},{\"idCategoria\":\"8\",\"nombre\":\"Objetos\",\"idPadre\":\"0\"}]}";
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    [self insUpdCD:@"INSERT" datos:json];
}

-(bool)checkCatNeg
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *categoriasEnt=[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:categoriasEnt];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        NSLog(@"Categorias > 0...");
        return true;
    }
    else
    {
        NSLog(@"Categorias nada...");
        return false;
    }
}

-(bool)checkCatCult
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;

    NSEntityDescription *categoriasEnt=[NSEntityDescription entityForName:@"ZCl_categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:categoriasEnt];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        NSLog(@"CategoriasCL > 0...");
        return true;
    }
    else
    {
        NSLog(@"CategoriasCL nada...");
        return false;
    }
}

-(void)downloadCatUsrDB
{
    bool catng=[self checkCatNeg];
    bool catcl=[self checkCatCult];
    if((!catng)||(!catcl))
    {
        // json
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"descTodo":@"1"};
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [manager POST:@"http://www.inkrender.com/wsDescSP/descCatUsr.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             if(!catng)
             {
                 [self saveCD_CatUsr:responseObject key:@"categorias"];
             }
             if(!catcl)
             {
                 [self saveCD_CatUsr:responseObject key:@"zCl_categorias"];
             }
             [self downloadDB];
         }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             NSLog(@"Error: %@", error);
         }];
    }
    else
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self downloadDB];
    }

}

-(void)saveCD_CatUsr:(NSDictionary*)datos key:(NSString*)key
{
    NSMutableDictionary *resObj=[datos mutableCopy];
    for(NSString *keyTabla in [datos allKeys])
    {
        if(![keyTabla isEqualToString:key])
        {
            [resObj removeObjectForKey:keyTabla];
        }
    }
    [self insUpdCD:@"INSERT" datos:resObj];
}

-(void)insUpdCD:(NSString*)tipo datos:(NSDictionary*)datos
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    int cn=1;
    for(NSString *keyTabla in [datos allKeys]) //dictTipoCmb
    {
        NSDictionary *dictTabla = [datos objectForKey:keyTabla];
        NSArray *jsonDictTabla = (NSArray *)dictTabla;
        for(NSDictionary *object in jsonDictTabla)
        {
            NSMutableArray *mutArray = [[NSMutableArray alloc] init];
            cn++;
            if([keyTabla isEqualToString:@"categorias"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    Categorias *add=[NSEntityDescription insertNewObjectForEntityForName:@"Categorias" inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    Categorias *cat = [mutArray objectAtIndex:0];
                    cat.idCategoria=[object objectForKey:@"idCategoria"];
                    cat.nombre=[object objectForKey:@"nombre"];
                    cat.idPadre=[object objectForKey:@"idPadre"];
                    cat.red=[object objectForKey:@"red"];
                    cat.green=[object objectForKey:@"green"];
                    cat.blue=[object objectForKey:@"blue"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCategoria=%@",[object valueForKey:@"idCategoria"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    Categorias *cat=[fetchedArray objectAtIndex:0];
                    cat.idCategoria=[object objectForKey:@"idCategoria"];
                    cat.nombre=[object objectForKey:@"nombre"];
                    cat.idPadre=[object objectForKey:@"idPadre"];
                    cat.red=[object objectForKey:@"red"];
                    cat.green=[object objectForKey:@"green"];
                    cat.blue=[object objectForKey:@"blue"];
                }
                //NSLog(@"categorias\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_categorias"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZCl_categorias *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZCl_categorias"inManagedObjectContext:context];
                    [mutArray addObject:add];
                                        
                    ZCl_categorias *cCl = [mutArray objectAtIndex:0];
                    cCl.idCategoria=[object objectForKey:@"idCategoria"];
                    cCl.nombre=[object objectForKey:@"nombre"];
                    cCl.idPadre=[object objectForKey:@"idPadre"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_categorias" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCategoria=%@",[object valueForKey:@"idCategoria"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZCl_categorias *cCl=[fetchedArray objectAtIndex:0];
                    cCl.idCategoria=[object objectForKey:@"idCategoria"];
                    cCl.nombre=[object objectForKey:@"nombre"];
                    cCl.idPadre=[object objectForKey:@"idPadre"];
                }
                //NSLog(@"zCl_categorias\n");
            }
            else
            if([keyTabla isEqualToString:@"categoriasNegocios"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    CategoriasNegocios *add=[NSEntityDescription insertNewObjectForEntityForName:@"CategoriasNegocios"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    CategoriasNegocios *cng = [mutArray objectAtIndex:0];
                    cng.idNegocio=[object objectForKey:@"idNegocio"];
                    cng.idCategoria=[object objectForKey:@"idCategoria"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"CategoriasNegocios" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",[object valueForKey:@"idNegocio"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    CategoriasNegocios *cng=[fetchedArray objectAtIndex:0];
                    cng.idNegocio=[object objectForKey:@"idNegocio"];
                    cng.idCategoria=[object objectForKey:@"idCategoria"];
                }
                //NSLog(@"categoriasNegocios\n");
            }
            else
            if([keyTabla isEqualToString:@"imagenesNeg"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ImagenesNeg *add=[NSEntityDescription insertNewObjectForEntityForName:@"ImagenesNeg"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ImagenesNeg *ing = [mutArray objectAtIndex:0];
                    ing.idImg=[object objectForKey:@"idImg"];
                    ing.idNegocio=[object objectForKey:@"idNegocio"];
                    ing.url=[object objectForKey:@"url"];
                    ing.descripcion=[object objectForKey:@"descripcion"];
                    ing.tipo=[object objectForKey:@"tipo"];
                    ing.mime=[object objectForKey:@"mime"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ImagenesNeg" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ImagenesNeg *ing=[fetchedArray objectAtIndex:0];
                    ing.idImg=[object objectForKey:@"idImg"];
                    ing.idNegocio=[object objectForKey:@"idNegocio"];
                    ing.url=[object objectForKey:@"url"];
                    ing.descripcion=[object objectForKey:@"descripcion"];
                    ing.tipo=[object objectForKey:@"tipo"];
                    ing.mime=[object objectForKey:@"mime"];
                }
                //NSLog(@"imagenesNeg\n");
            }
            else
            if([keyTabla isEqualToString:@"negocios"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    Negocios *add=[NSEntityDescription insertNewObjectForEntityForName:@"Negocios"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    Negocios *ng = [mutArray objectAtIndex:0];
                    ng.idNegocio=[object objectForKey:@"idNegocio"];
                    ng.nombre=[object objectForKey:@"nombre"];
                    ng.direccion=[object objectForKey:@"direccion"];
                    ng.latitud=[object objectForKey:@"latitud"];
                    ng.longitud=[object objectForKey:@"longitud"];
                    ng.filtro=[object objectForKey:@"filtro"];
                    ng.favorito=[object objectForKey:@"favorito"];
                    ng.descripcion=[object objectForKey:@"descripcion"];
                    ng.imagenes=[object objectForKey:@"imagenes"];
                    ng.facebook=[object objectForKey:@"facebook"];
                    ng.twitter=[object objectForKey:@"twitter"];
                    ng.pagina=[object objectForKey:@"pagina"];
                    ng.correo=[object objectForKey:@"correo"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Negocios" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",[object valueForKey:@"idNegocio"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    Negocios *ng=[fetchedArray objectAtIndex:0];
                    ng.idNegocio=[object objectForKey:@"idNegocio"];
                    ng.nombre=[object objectForKey:@"nombre"];
                    ng.direccion=[object objectForKey:@"direccion"];
                    ng.latitud=[object objectForKey:@"latitud"];
                    ng.longitud=[object objectForKey:@"longitud"];
                    ng.filtro=[object objectForKey:@"filtro"];
                    ng.favorito=[object objectForKey:@"favorito"];
                    ng.descripcion=[object objectForKey:@"descripcion"];
                    ng.imagenes=[object objectForKey:@"imagenes"];
                    ng.facebook=[object objectForKey:@"facebook"];
                    ng.twitter=[object objectForKey:@"twitter"];
                    ng.pagina=[object objectForKey:@"pagina"];
                    ng.correo=[object objectForKey:@"correo"];
                }
                //NSLog(@"negocios\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_categoriaCultura"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZCl_categoriaCultura *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZCl_categoriaCultura"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZCl_categoriaCultura *ccCl = [mutArray objectAtIndex:0];
                    ccCl.idCultura=[object objectForKey:@"idCultura"];
                    ccCl.idCategoria=[object objectForKey:@"idCategoria"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_categoriaCultura" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",[object valueForKey:@"idCultura"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZCl_categoriaCultura *ccCl=[fetchedArray objectAtIndex:0];
                    ccCl.idCultura=[object objectForKey:@"idCultura"];
                    ccCl.idCategoria=[object objectForKey:@"idCategoria"];
                }
                //NSLog(@"zCl_categoriaCultura\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_cultura"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZCl_cultura *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZCl_cultura"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZCl_cultura *cCLc = [mutArray objectAtIndex:0];
                    cCLc.idCultura=[object objectForKey:@"idCultura"];
                    cCLc.nombre=[object objectForKey:@"nombre"];
                    cCLc.fotografia=[object objectForKey:@"fotografia"];
                    cCLc.autor=[object objectForKey:@"autor"];
                    cCLc.descripcion=[object objectForKey:@"descripcion"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_cultura" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",[object valueForKey:@"idCultura"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZCl_cultura *cCLc=[fetchedArray objectAtIndex:0];
                    cCLc.idCultura=[object objectForKey:@"idCultura"];
                    cCLc.nombre=[object objectForKey:@"nombre"];
                    cCLc.fotografia=[object objectForKey:@"fotografia"];
                    cCLc.autor=[object objectForKey:@"autor"];
                    cCLc.descripcion=[object objectForKey:@"descripcion"];
                }
                //NSLog(@"zCl_cultura\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_imagenes"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZCl_imagenes *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZCl_imagenes"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZCl_imagenes *cim = [mutArray objectAtIndex:0];
                    cim.idImg=[object objectForKey:@"idImg"];
                    cim.idCultura=[object objectForKey:@"idCultura"];
                    cim.url=[object objectForKey:@"url"];
                    cim.descripcion=[object objectForKey:@"descripcion"];
                    cim.tipo=[object objectForKey:@"tipo"];
                    cim.mime=[object objectForKey:@"mime"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_imagenes" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZCl_imagenes *cim=[fetchedArray objectAtIndex:0];
                    cim.idImg=[object objectForKey:@"idImg"];
                    cim.idCultura=[object objectForKey:@"idCultura"];
                    cim.url=[object objectForKey:@"url"];
                    cim.descripcion=[object objectForKey:@"descripcion"];
                    cim.tipo=[object objectForKey:@"tipo"];
                    cim.mime=[object objectForKey:@"mime"];
                }
                //NSLog(@"zCl_imagenes\n");
            }
            else
            if([keyTabla isEqualToString:@"zEv_Eventos"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZEv_Eventos *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZEv_Eventos"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZEv_Eventos *evE = [mutArray objectAtIndex:0];
                    evE.idEvento=[object objectForKey:@"idEvento"];
                    evE.nombre=[object objectForKey:@"nombre"];
                    evE.lugar=[object objectForKey:@"lugar"];
                    evE.dia=[object objectForKey:@"dia"];
                    evE.mes=[object objectForKey:@"mes"];
                    evE.anio=[object objectForKey:@"anio"];
                    evE.horas=[object objectForKey:@"horas"];
                    evE.minutos=[object objectForKey:@"minutos"];
                    evE.descripcion=[object objectForKey:@"descripcion"];
                    evE.facebook=[object objectForKey:@"facebook"];
                    evE.twitter=[object objectForKey:@"twitter"];
                    evE.pagina=[object objectForKey:@"pagina"];
                    evE.correo=[object objectForKey:@"correo"];
                    evE.fotografia=[object objectForKey:@"fotografia"]; // se usa la de zEv_Imagenes
                    //NSLog(@"***ARBOLEDA:%@",[object objectForKey:@"arboleda"]);
                    evE.arboleda=[object objectForKey:@"arboleda"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZEv_Eventos" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idEvento=%@",[object valueForKey:@"idEvento"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZEv_Eventos *evE=[fetchedArray objectAtIndex:0];
                    evE.idEvento=[object objectForKey:@"idEvento"];
                    evE.nombre=[object objectForKey:@"nombre"];
                    evE.lugar=[object objectForKey:@"lugar"];
                    evE.dia=[object objectForKey:@"dia"];
                    evE.mes=[object objectForKey:@"mes"];
                    evE.anio=[object objectForKey:@"anio"];
                    evE.horas=[object objectForKey:@"horas"];
                    evE.minutos=[object objectForKey:@"minutos"];
                    evE.descripcion=[object objectForKey:@"descripcion"];
                    evE.facebook=[object objectForKey:@"facebook"];
                    evE.twitter=[object objectForKey:@"twitter"];
                    evE.pagina=[object objectForKey:@"pagina"];
                    evE.correo=[object objectForKey:@"correo"];
                    evE.fotografia=[object objectForKey:@"fotografia"]; // se usa la de zEv_Imagenes
                    //NSLog(@"***ARBOLEDA:%@",[object objectForKey:@"arboleda"]);
                    evE.arboleda=[object objectForKey:@"arboleda"];
                }
                //NSLog(@"zEv_Eventos\n");
            }
            else
            if([keyTabla isEqualToString:@"zEv_Imagenes"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZEv_Imagenes *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZEv_Imagenes"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZEv_Imagenes *evI = [mutArray objectAtIndex:0];
                    evI.idImg=[object objectForKey:@"idImg"];
                    evI.idEvento=[object objectForKey:@"idEvento"];
                    evI.url=[object objectForKey:@"url"];
                    evI.descripcion=[object objectForKey:@"descripcion"];
                    evI.tipo=[object objectForKey:@"tipo"];
                    evI.mime=[object objectForKey:@"mime"];
                    
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZEv_Imagenes" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZEv_Imagenes *evI=[fetchedArray objectAtIndex:0];
                    evI.idImg=[object objectForKey:@"idImg"];
                    evI.idEvento=[object objectForKey:@"idEvento"];
                    evI.url=[object objectForKey:@"url"];
                    evI.descripcion=[object objectForKey:@"descripcion"];
                    evI.tipo=[object objectForKey:@"tipo"];
                    evI.mime=[object objectForKey:@"mime"];
                }
                //NSLog(@"zEv_Imagenes\n");
            }
            else
            if([keyTabla isEqualToString:@"zUsr_Profile"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZUsr_Profile *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZUsr_Profile"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZUsr_Profile *pr = [mutArray objectAtIndex:0];
                    pr.idProfile=[object objectForKey:@"idProfile"];
                    pr.name=[object objectForKey:@"name"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZUsr_Profile" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idProfile=%@",[object valueForKey:@"idProfile"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZUsr_Profile *pr=[fetchedArray objectAtIndex:0];
                    pr.idProfile=[object objectForKey:@"idProfile"];
                    pr.name=[object objectForKey:@"name"];
                }
                //NSLog(@"zUsr_Profile\n");
            }
            else
            if([keyTabla isEqualToString:@"zUsr_Users"])
            {
                if([tipo isEqualToString:@"INSERT"])
                {
                    ZUsr_Users *add=[NSEntityDescription insertNewObjectForEntityForName:@"ZUsr_Users"inManagedObjectContext:context];
                    [mutArray addObject:add];
                    
                    ZUsr_Users *usr = [mutArray objectAtIndex:0];
                    usr.idUser=[object objectForKey:@"idUser"];
                    usr.name=[object objectForKey:@"name"];
                    usr.lastname=[object objectForKey:@"lastname"];
                    usr.username=[object objectForKey:@"username"];
                    usr.password=[object objectForKey:@"password"];
                    usr.email=[object objectForKey:@"email"];
                    usr.idProfile=[object objectForKey:@"idProfile"];
                }
                else
                if([tipo isEqualToString:@"UPDATE"])
                {
                    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                    [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZUsr_Users" inManagedObjectContext:context]];
                    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idUser=%@",[object valueForKey:@"idUser"]]];
                    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                    
                    ZUsr_Users *usr=[fetchedArray objectAtIndex:0];
                    usr.idUser=[object objectForKey:@"idUser"];
                    usr.name=[object objectForKey:@"name"];
                    usr.lastname=[object objectForKey:@"lastname"];
                    usr.username=[object objectForKey:@"username"];
                    usr.password=[object objectForKey:@"password"];
                    usr.email=[object objectForKey:@"email"];
                    usr.idProfile=[object objectForKey:@"idProfile"];
                }
                //NSLog(@"zUsr_Users\n");
            }
            else
            if([keyTabla isEqualToString:@"DATOS"])
            {
                [self deleteCD_tipo:@"DATOS" datos:datos];
                Aud_datos *add=[NSEntityDescription insertNewObjectForEntityForName:@"Aud_datos"inManagedObjectContext:context];
                [mutArray addObject:add];
                NSLog(@"%@,,,%@",[object objectForKey:@"idCambio"],[object objectForKey:@"fecha"]);
                Aud_datos *adt = [mutArray objectAtIndex:0];
                adt.aFecha=[object objectForKey:@"fecha"];
                adt.bIdCambio=[object objectForKey:@"idCambio"];
                
                NSLog(@"DATOS:FECHA:IDC\n");
            }
            /*else
            if([keyTabla isEqualToString:@"aud_cambios"])
            {
            }
            */
            
            if (![context save:&error])
            {
                NSLog(@"Whoops, couldn't save: %@", [error userInfo]);
            }
        }
    }
    [self updRel:datos];
}

-(void)updRel:(NSDictionary*)datos
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    for(NSString *keyTabla in [datos allKeys]) //dictTipoCmb
    {
        NSDictionary *dictTabla = [datos objectForKey:keyTabla];
        NSArray *jsonDictTabla = (NSArray *)dictTabla;
        for(NSDictionary *object in jsonDictTabla)
        {
            if([keyTabla isEqualToString:@"categorias"])
            {
                //NSLog(@"REL - categorias\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_categorias"])
            {
                //NSLog(@"REL - zCl_categorias\n");
            }
            else
            if([keyTabla isEqualToString:@"categoriasNegocios"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"CategoriasNegocios" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",[object valueForKey:@"idNegocio"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                CategoriasNegocios *cng=[fetchedArray objectAtIndex:0]; // ****
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"Negocios" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",[object valueForKey:@"idNegocio"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                cng.negocios=[fetchedArray01 objectAtIndex:0];
                    
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCategoria=%@",[object valueForKey:@"idCategoria"]]];
                NSArray *fetchedArray02 = [context executeFetchRequest:fetchRequest error:&error];
                cng.categorias=[fetchedArray02 objectAtIndex:0];
                //NSLog(@"REL - categoriasNegocios\n");//%@",[fetchedArray01 objectAtIndex:0]);
            }
            else
            if([keyTabla isEqualToString:@"imagenesNeg"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ImagenesNeg" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                ImagenesNeg *ing=[fetchedArray objectAtIndex:0];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"Negocios" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",[object valueForKey:@"idNegocio"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                ing.negocios=[fetchedArray01 objectAtIndex:0];
                
                //NSLog(@"REL - imagenesNeg\n");//%@",[fetchedArray01 objectAtIndex:0]);
            }
            else
            if([keyTabla isEqualToString:@"negocios"])
            {
                //NSLog(@"REL - negocios\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_categoriaCultura"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_categoriaCultura" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",[object valueForKey:@"idCultura"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                ZCl_categoriaCultura *ccl=[fetchedArray objectAtIndex:0];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_cultura" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",[object valueForKey:@"idCultura"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                ccl.cultura=[fetchedArray01 objectAtIndex:0];
                
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_categorias" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCategoria=%@",[object valueForKey:@"idCategoria"]]];
                NSArray *fetchedArray02 = [context executeFetchRequest:fetchRequest error:&error];
                ccl.categoriasCl=[fetchedArray02 objectAtIndex:0];
                
                //NSLog(@"REL - zCl_categoriaCultura\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_cultura"])
            {
                //NSLog(@"REL - zCl_cultura\n");
            }
            else
            if([keyTabla isEqualToString:@"zCl_imagenes"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_imagenes" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                ZCl_imagenes *ccl=[fetchedArray objectAtIndex:0];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZCl_cultura" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",[object valueForKey:@"idCultura"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                ccl.cultura=[fetchedArray01 objectAtIndex:0];
                
                //NSLog(@"REL - zCl_imagenes\n");//%@",[fetchedArray01 objectAtIndex:0]);
            }
            else
            if([keyTabla isEqualToString:@"zEv_Eventos"])
            {
                //NSLog(@"REL - zEv_Eventos\n");
            }
            else
            if([keyTabla isEqualToString:@"zEv_Imagenes"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZEv_Imagenes" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idImg=%@",[object valueForKey:@"idImg"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                ZEv_Imagenes *eim=[fetchedArray objectAtIndex:0];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZEv_Eventos" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idEvento=%@",[object valueForKey:@"idEvento"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                eim.eventos=[fetchedArray01 objectAtIndex:0];
                
                //NSLog(@"REL - zEv_Imagenes\n");
            }
            else
            if([keyTabla isEqualToString:@"zUsr_Profile"])
            {
                //NSLog(@"REL - zUsr_Profile\n");
            }
            else
            if([keyTabla isEqualToString:@"zUsr_Users"])
            {
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZUsr_Users" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idUser=%@",[object valueForKey:@"idUser"]]];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                ZUsr_Users *usr=[fetchedArray objectAtIndex:0];
                [fetchRequest setEntity:[NSEntityDescription entityForName:@"ZUsr_Profile" inManagedObjectContext:context]];
                [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idProfile=%@",[object valueForKey:@"idProfile"]]];
                NSArray *fetchedArray01 = [context executeFetchRequest:fetchRequest error:&error];
                usr.profile=[fetchedArray01 objectAtIndex:0];

                //NSLog(@"REL - zUsr_Users\n");
            }
            else
            if([keyTabla isEqualToString:@"FECHA"])
            {
                //NSLog(@"REL - FECHA\n");
            }
            /*else
            if([keyTabla isEqualToString:@"aud_cambios"])
            {
            }
            */
            
            if (![context save:&error])
            {
                NSLog(@"Whoops, couldn't save: %@", [error userInfo]);
            }
        }
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

-(void)deleteCD_tipo:(NSString*)tipo datos:(NSDictionary*)datos
{
     AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
     NSManagedObjectContext *context = [appDelegate managedObjectContext];
     NSError *error = nil;
    
    if([tipo isEqualToString:@"UPDATE"])
    {
        for(NSString *keyTabla in [datos allKeys]) //dictTipoCmb
        {
            NSDictionary *dictTabla = [datos objectForKey:keyTabla];
            NSArray *jsonDictTabla = (NSArray *)dictTabla;
            NSString *columna;
            NSString *valor;
            for(NSDictionary *object in jsonDictTabla)
            {
                if([keyTabla isEqualToString:@"categorias"])
                {
                        columna=@"idCategoria";
                        valor=[object objectForKey:@"idCategoria"];
                }
                else
                if([keyTabla isEqualToString:@"zCl_categorias"])
                {
                    columna=@"idCategoria";
                    valor=[object objectForKey:@"idCategoria"];
                }
                else
                if([keyTabla isEqualToString:@"categoriasNegocios"])
                {
                    columna=@"idNegocio";
                    valor=[object objectForKey:@"idNegocio"];
                }
                else
                if([keyTabla isEqualToString:@"imagenesNeg"])
                {
                    columna=@"idImg";
                    valor=[object objectForKey:@"idImg"];
                }
                else
                if([keyTabla isEqualToString:@"negocios"])
                {
                    columna=@"idNegocio";
                    valor=[object objectForKey:@"idNegocio"];
                }
                else
                if([keyTabla isEqualToString:@"zCl_categoriaCultura"])
                {
                    columna=@"idCultura";
                    valor=[object objectForKey:@"idCultura"];
                }
                else
                if([keyTabla isEqualToString:@"zCl_cultura"])
                {
                    columna=@"idCultura";
                    valor=[object objectForKey:@"idCultura"];
                }
                else
                if([keyTabla isEqualToString:@"zCl_imagenes"])
                {
                    columna=@"idImg";
                    valor=[object objectForKey:@"idImg"];
                }
                else
                if([keyTabla isEqualToString:@"zEv_Eventos"])
                {
                    columna=@"idEvento";
                    valor=[object objectForKey:@"idEvento"];
                }
                else
                if([keyTabla isEqualToString:@"zEv_Imagenes"])
                {
                    columna=@"idImg";
                    valor=[object objectForKey:@"idImg"];
                }
                else
                if([keyTabla isEqualToString:@"zUsr_Profile"])
                {
                    columna=@"idProfile";
                    valor=[object objectForKey:@"idProfile"];
                }
                else
                if([keyTabla isEqualToString:@"zUsr_Users"])
                {
                    columna=@"idUser";
                    valor=[object objectForKey:@"idUser"];
                }
                else
                if([keyTabla isEqualToString:@"FECHA"])
                {
                    columna=@"aFecha";
                    valor=[object objectForKey:@"fecha"];
                }
                /*else
                if([keyTabla isEqualToString:@"aud_cambios"])
                {
                }
                */
            
                NSString *tablaUC = keyTabla;
                tablaUC = [NSString stringWithFormat:@"%@%@",[[tablaUC substringToIndex:1] uppercaseString],[tablaUC substringFromIndex:1] ];
                
                NSEntityDescription *entity=[NSEntityDescription entityForName:tablaUC inManagedObjectContext:context];
                NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@=%@",columna,valor]];
                NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
                [fetchRequest setEntity:entity];
                [fetchRequest setPredicate:predicate];
                NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
                
                NSLog(@"tabla:%@,columna:%@,valor:%@,pred:%@,cnt:%lu",tablaUC,columna,valor,predicate,(unsigned long)[fetchedArray count]);
                
                for (int i = 0; i < [fetchedArray count]; i++)
                {
                    [context deleteObject:[fetchedArray objectAtIndex:i]];
                }
                
                if (![context save:&error])
                {
                    NSLog(@"Whoops, couldn't delete: %@", [error userInfo]);
                }
                else
                {
                    NSLog(@"Borrado Update...");
                }
            }
        }
    }
    else
    if([tipo isEqualToString:@"DELETEimg"]||[tipo isEqualToString:@"DELETE"])
    {
        int i=1;
        NSArray *jsonDictTabla = (NSArray *)datos;
        for(NSDictionary *object in jsonDictTabla)
        {
            NSString *tabla=[object objectForKey:@"tabla"];
            NSString *columna=[object objectForKey:@"columna"];
            NSString *idEnTabla=[object objectForKey:@"idEnTabla"];
            i++;
            
            NSString *tablaUC = tabla;
            tablaUC = [NSString stringWithFormat:@"%@%@",[[tablaUC substringToIndex:1] uppercaseString],[tablaUC substringFromIndex:1] ];
            
            NSEntityDescription *entity=[NSEntityDescription entityForName:tablaUC inManagedObjectContext:context];
            NSPredicate *predicate=[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@=%@",columna,idEnTabla]];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            [fetchRequest setEntity:entity];
            [fetchRequest setPredicate:predicate];
            NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
            
            //NSLog(@"tabla:%@,columna:%@,idEnTab:%@,pred:%@,cnt:%lu",tablaUC,columna,idEnTabla,predicate,(unsigned long)[fetchedArray count]);
            
            for (int i = 0; i < [fetchedArray count]; i++)
            {
                [context deleteObject:[fetchedArray objectAtIndex:i]];
            }
            
            if (![context save:&error])
            {
                NSLog(@"Whoops, couldn't delete: %@", [error userInfo]);
            }
            else
            {
                NSLog(@"Borrado DeleteImg Delete...");
            }
        }
    }
    if([tipo isEqualToString:@"DATOS"])
    {
        NSLog(@"\n\n***delete DATOS...***\n");//%@",datos);
        
        NSEntityDescription *entity=[NSEntityDescription entityForName:@"Aud_datos" inManagedObjectContext:context];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
        
        NSLog(@"cnt:%lu",(unsigned long)[fetchedArray count]);
        
        for (int i = 0; i < [fetchedArray count]; i++)
        {
            [context deleteObject:[fetchedArray objectAtIndex:i]];
        }
        
        if (![context save:&error])
        {
            NSLog(@"Whoops, couldn't delete: %@", [error userInfo]);
        }
        else
        {
            NSLog(@"Borrado Aud_datos...");
        }
    }
}

-(NSArray*)fechaCD
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Aud_datos" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        return fetchedArray;
    }
    else
    {
        NSArray *array=[[NSArray alloc]initWithObjects:nil];
        return array;
    }
}

-(void)downloadDB
{
    NSArray *fetchedArray=[self fechaCD];
    NSString *fecha;
    NSString *idCambioAud;
    if([fetchedArray count]==0)
    {
        fecha=@"0";
        idCambioAud=@"0";
    }
    else
    {
        for(NSDictionary *object in fetchedArray)
        {
            fecha=[object valueForKey:@"aFecha"];
            idCambioAud=[object valueForKey:@"bIdCambio"];
        }
    }
    //NSLog(@"FECHA IDCAMBIO CORE DATA:%@,,,%@",fecha,idCambioAud);
    
    // json
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"ultSinApp":idCambioAud}; //@"2014030911552598162"};
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [manager POST:@"http://www.inkrender.com/wsDescSP/cambios.php" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self db_cambios:responseObject];
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
     }];
}

-(void)db_cambios:(NSDictionary*)cambios
{
    NSDictionary *dictCambios = [cambios objectForKey:@"Cambios"];
    
    bool boolCambio=NO;//int i=1;int ii=1;
    for (NSString *keyTipoCmb in [dictCambios allKeys])
    {
        if([keyTipoCmb isEqualToString:@"cambio"])
        {
            NSLog(@"db_cambios - Sí existe el key 'cambio', NO hay cambios...");
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            boolCambio=YES;
        }
        else
        {
            NSLog(@"No existe el key 'cambio', entonces SI hay cambios...");
            boolCambio=NO;
        }
    }
    
    if(boolCambio==NO)
    {
        if([[cambios objectForKey:@"Cambios"] objectForKey:@"INSERT"])
        {
            NSDictionary *insert = [[cambios objectForKey:@"Cambios"] objectForKey:@"INSERT"];
            NSLog(@"\n\nINSERT - db_cambios\n\n");//\n%@\n",insert);
            [self insUpdCD:@"INSERT" datos:insert];
        }
        if([[cambios objectForKey:@"Cambios"] objectForKey:@"UPDATE"])
        {
            NSDictionary *update = [[cambios objectForKey:@"Cambios"] objectForKey:@"UPDATE"];
            NSLog(@"\n\nUPDATE - db_cambios\n\n");//\n%@\n",update);
            [self insUpdCD:@"UPDATE" datos:update];
        }
        
                if([[cambios objectForKey:@"Cambios"] objectForKey:@"DELETEimg"])
                {
                    NSDictionary *deleteImg = [[cambios objectForKey:@"Cambios"] objectForKey:@"DELETEimg"];
                    NSLog(@"\n\nDELETEimg - db_cambios\n\n");//\n%@\n",deleteImg);
                    [self deleteCD_tipo:@"DELETEimg" datos:deleteImg];
                }
                if([[cambios objectForKey:@"Cambios"] objectForKey:@"DELETE"])
                {
                    NSDictionary *delete = [[cambios objectForKey:@"Cambios"] objectForKey:@"DELETE"];
                    NSLog(@"\n\nDELETE - db_cambios\n\n");//\n%@\n",delete);
                    [self deleteCD_tipo:@"DELETE" datos:delete];
                }
        
        if([[cambios objectForKey:@"OtrosDatos"] objectForKey:@"INSERT"])
        {
            NSDictionary *dictFecha = [[cambios objectForKey:@"OtrosDatos"] objectForKey:@"INSERT"];
            NSLog(@"\n\nFECHA - db_cambios\n\n");//\n%@\n",update);
            [self insUpdCD:@"INSERT" datos:dictFecha];
        }
    }
}

NSUInteger fetchedArrayCnt;
-(void)subCategorias:(UIButton*)sender
{
    NSString *idCat01=sender.accessibilityIdentifier;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idPadre=%@",idCat01];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    fetchedArrayCnt=[fetchedArray count];
    //NSLog(@"subCategorias()...idCategoria:%@...fetchedArrayCnt:%lu",idCat01,(unsigned long)fetchedArrayCnt);
    
    if([fetchedArray count]>0)
    {
        [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSMutableArray *idCategoria01=[[NSMutableArray alloc]init];
        NSMutableArray *nombre01=[[NSMutableArray alloc]init];
        NSMutableArray *idPadre01=[[NSMutableArray alloc]init];
        
        CGFloat xbtn=0,ybtn=0;//,width=300.0,height=30.0;
        
        UIButton *myButton01 = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton01 addTarget:self action:@selector(ibaBoton1:) forControlEvents:UIControlEventTouchUpInside];
        [myButton01 setBackgroundColor:[UIColor colorWithRed:(255.0/255.0) green:(201.0/255.0) blue:(14.0/255.0) alpha:1]];
        [myButton01 setTitle:@"< < <" forState:UIControlStateNormal];
        myButton01.frame = CGRectMake(xbtn, ybtn, width, height);
        [scrollview addSubview:myButton01];
        ybtn=ybtn+31;
        
        for(Categorias *cat in fetchedArray)
        {
            NSLog(@"idcat:%@ idpad:%@ %@",cat.idCategoria,cat.idPadre,cat.nombre);
            if(![cat.idCategoria isEqualToString:@"-1"])
            {
                [idCategoria01 addObject:cat.idCategoria];
                [nombre01 addObject:cat.nombre];
                [idPadre01 addObject:cat.idPadre];
                
                UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton addTarget:self action:@selector(subCategorias:) forControlEvents:UIControlEventTouchUpInside];
                [myButton setAccessibilityIdentifier:cat.idCategoria];
                [myButton01 setAccessibilityIdentifier:cat.idPadre];
                [myButton setBackgroundColor:[UIColor colorWithRed:(34.0/255.0) green:(177.0/255.0) blue:(76.0/255.0) alpha:1]];
                [myButton setTitle:cat.nombre forState:UIControlStateNormal];
                myButton.frame = CGRectMake(xbtn, ybtn, width, height);//CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
                [scrollview addSubview:myButton];
                ybtn=ybtn+31;
            }
        }
        
        //NSLog(@"ybtn02:%f",ybtn);
        CGFloat scHScr;
        if(ybtn<hScr)
        {
            scHScr=ybtn;
        }
        else
        {
            scHScr=hScr;
        }
        scrollview.frame = CGRectMake(xScr, yScr, wScr, scHScr); //0, 30, width, ybtn);
        
        scrollview.contentSize = CGSizeMake(width, ybtn);
        [scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    else
    {
        NSLog(@"No hay datos SC...idCategoria:%@",idCat01);
        [scrollview removeFromSuperview];
        /*
        for(UIView *subview in [self.view subviews])
        {
            NSLog(@"subview:%@",subview.description);
        }
        */
    }
}

-(NSArray*)idCat:(NSString*)str01 idC:(NSString*)idC
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate;
    if([idC isEqualToString:@"idCategoria"])
    {
        predicate=[NSPredicate predicateWithFormat:@"idCategoria=%@",str01]; // << atras Sub categorias
    }
    else
    if([idC isEqualToString:@"idPadre"])
    {
        predicate=[NSPredicate predicateWithFormat:@"idPadre=%@",str01];
    }
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        return fetchedArray;
    }
    else
    {
        NSArray *array=[[NSArray alloc]initWithObjects:nil];
        return array;
    }
}

-(void)negCat:(UIButton*)sender
{
    NSString *id01;
    if(sender.accessibilityIdentifier)
    {
        id01=sender.accessibilityIdentifier;
    }
    else
    {
        id01=@"0";
    }
    
    if(sender.accessibilityLabel)
    {
        [arrayCategorias00 addObject:sender.accessibilityLabel];
        NSString *output = [arrayCategorias00 componentsJoinedByString:@" > "];
        NSString *output2 = [NSString stringWithFormat:@"Negocios:\"%@\"",output];
        
    [[GAI sharedInstance].defaultTracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Categorias" action:@"buttonClick" label:output2 value:nil] build]];
    }
    
    NSString *idNegocio00,*idCategoria00,*idNegocio01,*nombre00,*direccion00,*latitud00,*longitud00,*descripcion00,*facebook00,*twitter00,*pagina00,*correo00,*red00,*green00,*blue00;
    NSString *nombreCat00;
    NSString *img00=@"",*img01=@"",*img02=@"",*img03=@"",*img04=@"";
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CategoriasNegocios" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idCategoria=%@",id01];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        
        [UIView animateWithDuration:0.5
                      animations:^{
                          [scrollview setFrame:CGRectMake(300, 52, 222, 502)];
                          [_sitiosFiltrosBTN setFrame:CGRectMake(280, 282, 32, 41)];
                      }
                      completion:^(BOOL finished){
                          [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                          [scrollview removeFromSuperview];
                      }];
        
        sitiosFiltro = FALSE;
        [_sitiosFiltrosBTN setSelected:NO];
            // [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            // [scrollview removeFromSuperview];
        
        
        NSMutableArray * annotationsToRemove = [ mapView.annotations mutableCopy ] ;
        [ annotationsToRemove removeObject:mapView.userLocation ] ;
        [ mapView removeAnnotations:annotationsToRemove ] ;
        
            // Array
        NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
        
            // Create some annotations
        ZSAnnotation *annotation = nil;
        
        for(CategoriasNegocios *cng in fetchedArray)
        {
            idNegocio00=cng.idNegocio;
            idCategoria00=cng.idCategoria;
            idNegocio01=cng.negocios.idNegocio;
            nombre00=cng.negocios.nombre;
            direccion00=cng.negocios.direccion;
            latitud00=cng.negocios.latitud;
            longitud00=cng.negocios.longitud;
            descripcion00=cng.negocios.descripcion;
            facebook00=cng.negocios.facebook;
            twitter00=cng.negocios.twitter;
            pagina00=cng.negocios.pagina;
            correo00=cng.negocios.correo;
            
            nombreCat00=cng.categorias.nombre;
            red00=cng.categorias.red;
            green00=cng.categorias.green;
            blue00=cng.categorias.blue;
            
                //Convert to double
            double latdouble = [latitud00 doubleValue];
            double londouble = [longitud00 doubleValue];
            
            double reddouble = [red00 doubleValue];
            double greendouble = [green00 doubleValue];
            double bluedouble = [blue00 doubleValue];
            
            NSArray *imgArr=[self imagenNg:idNegocio00];
            if([imgArr count]>0)
            {
                
                [_detailPageControl setNumberOfPages:imgArr.count];
                
                [_detailScroll setContentSize:CGSizeMake(_detailScroll.frame.size.width*imgArr.count, _detailScroll.frame.size.height)];
                
                for(ImagenesNeg *ing in imgArr)
                {
                    if([ing.tipo isEqualToString:@"0"])
                    {
                        img00=ing.url;
                    }
                    if([ing.tipo isEqualToString:@"1"])
                    {
                        img01=ing.url;
                    }
                    if([ing.tipo isEqualToString:@"2"])
                    {
                        img02=ing.url;
                    }
                    if([ing.tipo isEqualToString:@"3"])
                    {
                        img03=ing.url;
                    }
                    if([ing.tipo isEqualToString:@"4"])
                    {
                        img04=ing.url;
                    }
                }
            }
            else{}
            
            
            [_detailScroll setPagingEnabled:YES];
            _detailScroll.bounces = NO;
            _detailScroll.showsHorizontalScrollIndicator = NO;
            _detailScroll.delegate = self;
            
            annotation = [[ZSAnnotation alloc] init];
            annotation.coordinate = CLLocationCoordinate2DMake(latdouble,londouble);
            annotation.type = ZSPinAnnotationTypeTag;
            annotation.color = RGB(reddouble, greendouble, bluedouble);
            annotation.title = nombre00;
            annotation.giro = nombreCat00;
            annotation.desc = descripcion00;
            annotation.facebookURL = facebook00;
            annotation.twitterURL = twitter00;
            annotation.webURL = pagina00;
            annotation.mailURL = correo00;
            annotation.image00 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img00]]];
            annotation.image01 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img01]]];
            annotation.image02 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img02]]];
            annotation.image03 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img03]]];
            annotation.image04 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img04]]];
            [annotationArray addObject:annotation];
            
            [self.mapView addAnnotations:annotationArray];
                // Center map
            self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];

            
            printf("\nidN:%s..idC:%s..nIdN:%s..nom:%s..dir:%s..lat:%s..lon:%s..des:%s..face:%s..tw:%s..pag:%s..corr:%s",[idNegocio00 UTF8String],[idCategoria00 UTF8String],[idNegocio01 UTF8String],[nombre00 UTF8String],[direccion00 UTF8String],[latitud00 UTF8String],[longitud00 UTF8String],[descripcion00 UTF8String],[facebook00 UTF8String],[twitter00 UTF8String],[pagina00 UTF8String],[correo00 UTF8String]);
            NSLog(@"\nimgs:\n-01%@\n-02%@\n-03%@\n-04%@\n-05%@\n",img00,img01,img02,img03,img04);
            
            img00=@"";img01=@"";img02=@"";img03=@"";img04=@"";
        }
        [arrayCategorias00 removeAllObjects];
    }
    else
    {
        //NSLog(@"No hay datos negCat...");
        [arrayCategorias00 removeLastObject];
        
        UIAlertView *Msg =[[UIAlertView alloc] initWithTitle:@"Info" message:@"No hay negocios." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [Msg show];
    }
    
    
        // NSMutableArray * annotationsToRemove = [ mapView.annotations mutableCopy ] ;
        // [ annotationsToRemove removeObject:mapView.userLocation ] ;
        //  [ mapView removeAnnotations:annotationsToRemove ] ;
    
        // Array
    NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
    
        // Create some annotations
    ZSAnnotation *annotation = nil;
    
    annotation = [[ZSAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(25.6485119,-100.355266);
    annotation.type = ZSPinAnnotationTypeTag;
    annotation.color = RGB(72, 83, 59);
    annotation.title = @"Arboleda";
    annotation.tag = 11;
    [annotationArray addObject:annotation];
    
    [self.mapView addAnnotations:annotationArray];
}

CGFloat xScr=90,yScr=52,wScr=222.0,hScr=502.0;  //wScr=width; x y ancho alto -> scroll
CGFloat /*xbtn=0,ybtn=0,*/width=222.0,height=34.0;  // ancho alto -> boton
NSMutableArray *arrayCategorias00;

-(void)mostrarTodo {
    [[GAI sharedInstance].defaultTracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Categorias" action:@"buttonClick" label:@"VER TODO" value:nil] build]];
    
    NSString *idNegocio00,*idCategoria00,*idNegocio01,*nombre00,*direccion00,*latitud00,*longitud00,*descripcion00,*facebook00,*twitter00,*pagina00,*correo00,*red00,*green00,*blue00;
    NSString *nombreCat00;
    NSString *img00=@"",*img01=@"",*img02=@"",*img03=@"",*img04=@"";
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CategoriasNegocios" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        //NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idCategoria=%@",id01];
    [fetchRequest setEntity:entity];
        //[fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             [scrollview setFrame:CGRectMake(300, 52, 222, 502)];
                             [_sitiosFiltrosBTN setFrame:CGRectMake(280, 282, 32, 41)];
                         }
                         completion:^(BOOL finished){
                             [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             [scrollview removeFromSuperview];
                         }];
        
        sitiosFiltro = FALSE;
        [_sitiosFiltrosBTN setSelected:NO];
        
            //  [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            //  [scrollview removeFromSuperview];
        NSMutableArray * annotationsToRemove = [ mapView.annotations mutableCopy ] ;
        [ annotationsToRemove removeObject:mapView.userLocation ] ;
        [ mapView removeAnnotations:annotationsToRemove ] ;
        
            // Array
        NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
        
            // Create some annotations
        ZSAnnotation *annotation = nil;

        
        for(CategoriasNegocios *cng in fetchedArray)
        {
            if (![cng.idCategoria isEqualToString:@"-1"]) {
            
                idNegocio00=cng.idNegocio;
                idCategoria00=cng.idCategoria;
                idNegocio01=cng.negocios.idNegocio;
                nombre00=cng.negocios.nombre;
                direccion00=cng.negocios.direccion;
                latitud00=cng.negocios.latitud;
                longitud00=cng.negocios.longitud;
                descripcion00=cng.negocios.descripcion;
                facebook00=cng.negocios.facebook;
                twitter00=cng.negocios.twitter;
                pagina00=cng.negocios.pagina;
                correo00=cng.negocios.correo;
                
                nombreCat00=cng.categorias.nombre;
                red00=cng.categorias.red;
                green00=cng.categorias.green;
                blue00=cng.categorias.blue;
                
                double latdouble = [latitud00 doubleValue];
                double londouble = [longitud00 doubleValue];
                
                double reddouble = [red00 doubleValue];
                double greendouble = [green00 doubleValue];
                double bluedouble = [blue00 doubleValue];
                
                NSArray *imgArr=[self imagenNg:idNegocio00];
                if([imgArr count]>0)
                {
                    
                    [_detailPageControl setNumberOfPages:imgArr.count];
                    
                    [_detailScroll setContentSize:CGSizeMake(_detailScroll.frame.size.width*imgArr.count, _detailScroll.frame.size.height)];
                    
                    for(ImagenesNeg *ing in imgArr)
                    {
                        if([ing.tipo isEqualToString:@"0"])
                        {
                            img00=ing.url;
                        }
                        if([ing.tipo isEqualToString:@"1"])
                        {
                            img01=ing.url;
                        }
                        if([ing.tipo isEqualToString:@"2"])
                        {
                            img02=ing.url;
                        }
                        if([ing.tipo isEqualToString:@"3"])
                        {
                            img03=ing.url;
                        }
                        if([ing.tipo isEqualToString:@"4"])
                        {
                            img04=ing.url;
                        }
                        
                    }
                }
                else
                {
                }
                
                [_detailScroll setPagingEnabled:YES];
                _detailScroll.bounces = NO;
                _detailScroll.showsHorizontalScrollIndicator = NO;
                _detailScroll.delegate = self;
                
                annotation = [[ZSAnnotation alloc] init];
                annotation.coordinate = CLLocationCoordinate2DMake(latdouble,londouble);
                annotation.type = ZSPinAnnotationTypeTag;
                annotation.color = RGB(reddouble, greendouble, bluedouble);
                annotation.title = nombre00;
                annotation.giro = nombreCat00;
                annotation.desc = descripcion00;
                annotation.facebookURL = facebook00;
                annotation.twitterURL = twitter00;
                annotation.webURL = pagina00;
                annotation.mailURL = correo00;
                annotation.image00 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img00]]];
                annotation.image01 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img01]]];
                annotation.image02 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img02]]];
                annotation.image03 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img03]]];
                annotation.image04 = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:img04]]];
                [annotationArray addObject:annotation];
                
                [self.mapView addAnnotations:annotationArray];
                    // Center map
                self.mapView.visibleMapRect = [self makeMapRectWithAnnotations:annotationArray];
                
                
                printf("\nidN:%s..idC:%s..nIdN:%s..nom:%s..dir:%s..lat:%s..lon:%s..des:%s..face:%s..tw:%s..pag:%s..corr:%s",[idNegocio00 UTF8String],[idCategoria00 UTF8String],[idNegocio01 UTF8String],[nombre00 UTF8String],[direccion00 UTF8String],[latitud00 UTF8String],[longitud00 UTF8String],[descripcion00 UTF8String],[facebook00 UTF8String],[twitter00 UTF8String],[pagina00 UTF8String],[correo00 UTF8String]);
                NSLog(@"\nimgs:\n-01%@\n-02%@\n-03%@\n-04%@\n-05%@\n",img00,img01,img02,img03,img04);
                
                img00=@"";img01=@"";img02=@"";img03=@"";img04=@"";
            }
        }
        [arrayCategorias00 removeAllObjects];
    }
    else
    {
            //NSLog(@"No hay datos negCat...");
            //[array*Categorias00 removeLastObject];
        [arrayCategorias00 removeAllObjects];
        
        UIAlertView *Msg =[[UIAlertView alloc] initWithTitle:@"Info" message:@"No hay negocios." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [Msg show];
    }
    
    NSMutableArray *annotationArray = [[NSMutableArray alloc] init];
    
        // Create some annotations
    ZSAnnotation *annotation = nil;
    
    annotation = [[ZSAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(25.6485119,-100.355266);
    annotation.type = ZSPinAnnotationTypeTag;
    annotation.color = RGB(72, 83, 59);
    annotation.title = @"Arboleda";
    annotation.tag = 11;
    [annotationArray addObject:annotation];
    
    [self.mapView addAnnotations:annotationArray];
    
}

- (IBAction)ibaBoton1:(UIButton*)sender
{
    [UIView animateWithDuration:0.5
                     animations:^{
                         [_menuView setFrame:CGRectMake(-137, 51, 166, 503)];
                         _menuView.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                     }];
    menuOut = FALSE;
    
    NSString *id01;
    if(sender.accessibilityIdentifier) // lo tenia - >> adelante Sub categorias
    {
        id01=sender.accessibilityIdentifier;
    }
    else
    {
        id01=@"0";
        [[GAI sharedInstance].defaultTracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Negocios" forKey:kGAIScreenName] build]];
        
        [arrayCategorias00 removeAllObjects];
    }
    if(sender.accessibilityHint) // << atras Sub categorias
    {
        NSArray *result=[self idCat:id01 idC:@"idCategoria"];
        NSString *idPadre;
        if([result count]>0)
        {
            for(Categorias *cat in result)
            {
                idPadre=cat.idPadre;
            }
        }
        else
        {
            //NSLog(@"00 No hay datos idPadreCat...");
        }
        id01=idPadre;
        [arrayCategorias00 removeLastObject];
    }
    
    if(sender.accessibilityLabel)
    {
        [arrayCategorias00 addObject:sender.accessibilityLabel];
    }
    
    [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [scrollview removeFromSuperview];
   
    CGFloat xbtn=0,ybtn=0;//,width=300.0,height=30.0;
    
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(300, 52, 222, 502)];
    [self.view addSubview:scrollview];
   
    [UIView animateWithDuration:0.5
                     animations:^{
                         [scrollview setFrame:CGRectMake(90, 52, 222, 502)];
                         [_sitiosFiltrosBTN setFrame:CGRectMake(58, 282, 32, 41)];
                     }
                     completion:^(BOOL finished){
                     }];

    sitiosFiltro = TRUE;
    [_sitiosFiltrosBTN setSelected:YES];
    
        // scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(90, 52, 222, 502)];


    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idPadre=%@",id01]; //idPadre=0 >> adelante Sub categorias
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentJustified];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    [style setLineSpacing:18];
    
    UIFont *font1 = [UIFont fontWithName:@"Futura" size:14.0];
    
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            NSParagraphStyleAttributeName:style};
    
    NSMutableAttributedString *attString1 = [[NSMutableAttributedString alloc] init];
   
    
    if([fetchedArray count]>0)
    {
        UIButton *myButton01 = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton01 addTarget:self action:@selector(ibaBoton1:) forControlEvents:UIControlEventTouchUpInside];
        [myButton01 setBackgroundColor:[UIColor colorWithRed:(252.0/255.0) green:(251.0/255.0) blue:(250.0/255.0) alpha:1]];
        [myButton01 setTitle:@"< < <" forState:UIControlStateNormal];
        [myButton01 setTitleColor:[UIColor colorWithRed:(109.0/255.0) green:(110.0/255.0) blue:(113.0/255.0) alpha:1] forState:UIControlStateNormal];
        myButton01.frame = CGRectMake(xbtn, ybtn, width, height);
            // [scrollview addSubview:myButton01];
        
        UIButton *btnMostrarTodo = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnMostrarTodo addTarget:self action:@selector(mostrarTodo) forControlEvents:UIControlEventTouchUpInside];
        [btnMostrarTodo setBackgroundColor:[UIColor colorWithRed:(255.0/255.0) green:(201.0/255.0) blue:(14.0/255.0) alpha:1]];
        [btnMostrarTodo setTitle:@"VER TODO" forState:UIControlStateNormal];
        [btnMostrarTodo setBackgroundColor:[UIColor colorWithRed:(252.0/255.0) green:(251.0/255.0) blue:(250.0/255.0) alpha:1]];
        [btnMostrarTodo setTitleColor:[UIColor colorWithRed:(109.0/255.0) green:(110.0/255.0) blue:(113.0/255.0) alpha:1] forState:UIControlStateNormal];
        [btnMostrarTodo.titleLabel setFont:[UIFont fontWithName:@"Futura" size:14.0]];
        btnMostrarTodo.frame = CGRectMake(xbtn, ybtn, width, height);
        
        if([id01 isEqualToString:@"0"])
        {
            [scrollview addSubview:btnMostrarTodo];
        }
        else
        {
            [scrollview addSubview:myButton01];
        }

        ybtn=ybtn+height+1;
        
        
        
        for(Categorias *cat in fetchedArray)
        {
            if(![cat.idCategoria isEqualToString:@"-1"])
            {
                UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton setAccessibilityIdentifier:cat.idCategoria]; // >> adelante Sub categorias
                [myButton01 setAccessibilityHint:@"atras"]; // << atras Sub categorias
                [myButton01 setAccessibilityIdentifier:cat.idPadre]; // << atras Sub categorias
                [myButton setBackgroundColor:[UIColor colorWithRed:(252.0/255.0) green:(251.0/255.0) blue:(250.0/255.0) alpha:1]];
                [myButton setTitleColor:[UIColor colorWithRed:(109.0/255.0) green:(110.0/255.0) blue:(113.0/255.0) alpha:1] forState:UIControlStateNormal];
                
                
                UIButton *myButton02;
                NSString *titulo;
                NSArray *result01=[self idCat:cat.idCategoria idC:@"idPadre"];
                
                if([result01 count]>0)
                {
                    // /*
                    // un boton hasta llegar al fondo de las subcategorias y el ultimo se buscan negocios.
                    [myButton addTarget:self action:@selector(ibaBoton1:) forControlEvents:UIControlEventTouchUpInside];
                    titulo=[NSString stringWithFormat:@"%@",cat.nombre];
                    
                    NSString *uppercase = [titulo uppercaseString];
                    titulo =  uppercase;
                    
                    myButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    myButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
                   
                    [myButton setAccessibilityLabel:cat.nombre];
                    [myButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:14.0]];
                    // */
                    
                     /*
                    // dos botones ej. boton [Areas de recreacion >>] hacia adelante subcategorias y boton [√] para ver si hay negocios solo de esa categoria(NO de las subcategorias que pueda tener).
                    [myButton addTarget:self action:@selector(ibaBoton1:) forControlEvents:UIControlEventTouchUpInside];
                    titulo=[NSString stringWithFormat:@"%@ >>",cat.nombre];
                    //[myButton setTitle:titulo forState:UIControlStateNormal];
                    //myButton.frame = CGRectMake(xbtn, ybtn, width, height);//CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
                    //[scrollview addSubview:myButton];
                    
                    myButton02 = [UIButton buttonWithType:UIButtonTypeCustom];
                    [myButton02 addTarget:self action:@selector(negCat:) forControlEvents:UIControlEventTouchUpInside];
                    [myButton02 setAccessibilityIdentifier:cat.idCategoria];
                    [myButton02 setBackgroundColor:[UIColor colorWithRed:(34.0/255.0) green:(177.0/255.0) blue:(76.0/255.0) alpha:1]];
                    NSString *titulo02=[NSString stringWithFormat:@"√"];
                    [myButton02 setTitle:titulo02 forState:UIControlStateNormal];
                    myButton02.frame = CGRectMake(btnSlcPos, ybtn, tamBtnSelect, height);// x,y,width,height
                    //[scrollview addSubview:myButton02];
                     */
                }
                else
                {
                    [myButton addTarget:self action:@selector(negCat:) forControlEvents:UIControlEventTouchUpInside];
                    titulo=[NSString stringWithFormat:@"%@",cat.nombre];
                    NSString *uppercase = [titulo uppercaseString];
                    titulo =  uppercase;
                    
                    myButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    myButton.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
                    
                    [myButton setAccessibilityLabel:cat.nombre];
                    [myButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:14.0]];
                }
                [myButton setTitle:titulo forState:UIControlStateNormal];
                myButton.frame = CGRectMake(xbtn, ybtn, width, height);//CGRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
                [scrollview addSubview:myButton];
                [scrollview addSubview:myButton02];
                ybtn=ybtn+height+1;
                
            }
            
        }
        /*
         [scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
        */
        // ***** quitar para usar -(void)subCategorias:(UIButton*)sender *****
        CGFloat scHScr;
        if(ybtn<hScr)
        {
            scHScr=ybtn;
        }
        else
        {
            scHScr=hScr;
        }
        scrollview.frame = CGRectMake(xScr, yScr, wScr, 502);
        // ***** ******
        
        //scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, width, 200)];
        scrollview.contentSize = CGSizeMake(width, ybtn);
        scrollview.showsVerticalScrollIndicator=YES;
        scrollview.scrollEnabled=YES;
        scrollview.userInteractionEnabled=YES;
        scrollview.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(251.0/255.0) blue:(250.0/255.0) alpha:1];
    }
    else
    {
        [UIView animateWithDuration:0.5
                         animations:^{
                             [scrollview setFrame:CGRectMake(300, 52, 222, 502)];
                             [_sitiosFiltrosBTN setFrame:CGRectMake(280, 282, 32, 41)];
                         }
                         completion:^(BOOL finished){
                             [scrollview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
                             [scrollview removeFromSuperview];
                         }];
        
        sitiosFiltro = FALSE;
        [_sitiosFiltrosBTN setSelected:NO];

        
        //NSLog(@"00 No hay datos...arrayCat:%@",arrayCategorias00);
    }
}

 /*
 for(UIView *subview in [self.view subviews])
 {
    if(subview.tag==1)
    {
        NSLog(@"subview:%@",subview);
    }
 }
 */

UILabel *lblArbTitulo;//,*lblGnTitulo;
NSInteger xWebVGn,yWebVGn,webVGnWidth=150,webVGnSep=10; // tamaños web view Otros Eventos...
NSInteger evViewX=11,evViewY=51,evViewWidth=300,evViewheight=504; // tamaño evento View
NSInteger webVArbX=0,/*webVArbY=0,*/webVArbWidth,webVArbPorc=50,webVArbRen=30;//tamaño web view arboleda, webVArbPorc=porcentaje para calcular el ancho 40%, webVArbRen=espacio para mover hacia abajo el web view arboleda(alto renglon).
NSInteger evTitArbH=30,evTitArbHeight; //alto del titulo del evento Arboleda, evTitArbH=alto, evTitArbHeight=calculo final del alto.
NSInteger mesesAdelante=3;
NSString *htmlStringArb,*htmlStringGn;
bool difMes=NO,sigAnio=NO;
NSString *htmlEvArb=@"<html><head><title>Eventos Arboleda</title></head><body><div align='center'><div style='font-size:13px;font-family:GaramondPremrPro;color:#6D6E71;'>";
NSString *htmlEvGn= @"<html><head><title>Otros Eventos</title></head><body><div align='center'><div style='font-size:13px;font-family:GaramondPremrPro;color:#6D6E71;'>";
NSInteger btnCerrarY=0,btnCerrarWidth=30,btnCerrarHeight=30;

NSString *htmlStringEvn;

- (IBAction)ibaBtnEv:(id)sender
{
    [[GAI sharedInstance].defaultTracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Eventos" forKey:kGAIScreenName] build]];
    
    [sclViewEvGen.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [sclViewEvGen removeFromSuperview];
    [evView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [evView removeFromSuperview];
    
    xWebVGn=0,yWebVGn=0;
    
    webVArbWidth=(evViewWidth*webVArbPorc)/100;//ancho web view arboleda,(ancho Evento view * Porcentaje/100)
    
    evView=[[UIView alloc]initWithFrame:CGRectMake(evViewX,evViewY,evViewWidth,evViewheight)]; // este mueve todos los tamaños de los views.
    [evView setTag:1];
    [evView setBackgroundColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5]];
    [self.view addSubview:evView];
    evView.layer.zPosition = 0;
    
    evTitArbHeight=evViewheight-(-(evTitArbH-evViewheight));
    
    lblArbTitulo=[[UILabel alloc]initWithFrame:CGRectMake((evView.frame.size.width/2)-((evViewWidth-webVArbWidth)/2),evViewY-evViewY,webVArbWidth,evTitArbHeight)];
    lblArbTitulo.text=@"EVENTOS ARBOLEDA"; //Eventos Arboleda
    lblArbTitulo.textAlignment=NSTextAlignmentCenter;
    lblArbTitulo.textColor = [UIColor lightGrayColor];
    [evView addSubview:lblArbTitulo];
    [lblArbTitulo setFont:[UIFont fontWithName:@"Futura" size:14.0]];
    
    UILabel *lblGnTitulo;
    lblGnTitulo=[[UILabel alloc]initWithFrame:CGRectMake((evView.frame.size.width/2)-((evViewWidth-webVArbWidth)/2),250,evViewWidth-webVArbWidth,evTitArbHeight)];
    lblGnTitulo.text=@"OTROS EVENTOS"; // Otros Eventos
    lblGnTitulo.textAlignment=NSTextAlignmentCenter;
    lblGnTitulo.textColor = [UIColor lightGrayColor];
        //lblGnTitulo.backgroundColor=[UIColor colorWithRed:(251.0/255.0) green:(250.0/255.0) blue:(247.0/255.0) alpha:1];
    [evView addSubview:lblGnTitulo];
    [lblGnTitulo setFont:[UIFont fontWithName:@"Futura" size:14.0]];
    
    //                                                         190, 30, 185, 250
    sclViewEvGen=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 300, 300, evViewheight-webVArbRen)];
    
    sclViewEvGen.showsHorizontalScrollIndicator=YES;
    sclViewEvGen.scrollEnabled=YES;
    sclViewEvGen.userInteractionEnabled=YES;
        // sclViewEvGen.backgroundColor = [UIColor colorWithRed:(95.0/255.0) green:(195.0/255.0) blue:(195.0/255.0) alpha:1];
        // [evView addSubview:sclViewEvGen];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger day = [components day];
    NSInteger month = [components month]; //24;
    NSInteger year = [components year];
    day=day;
    
    UIWebView *webviewArb=[[UIWebView alloc]initWithFrame:CGRectMake(webVArbX, /*webVArbY+*/webVArbRen, 300, 220)]; // 0, 0, 185,200
    htmlStringArb=htmlEvArb;
    
        //mesesAdelante=22;
    //day=1;
    //month=1;
    //year=2014;
    
    UIWebView *webviewGn=[[UIWebView alloc]initWithFrame:CGRectMake(0,280,300, 225)];
    htmlStringEvn=@"";
    
    for (int i=1; i<=mesesAdelante; i++)
    {
        if(month>12)
        {
            month=month-12;
            year=year+1;
            sigAnio=YES;
        }
        
        /*
        UIWebView *webviewGn=[[UIWebView alloc]initWithFrame:CGRectMake(xWebVGn+webVGnSep,yWebVGn+webVArbRen,webVGnWidth, evViewheight-webVArbRen-webVArbRen)];
        lblGnTitulo=[[UILabel alloc]initWithFrame:CGRectMake(xWebVGn+webVGnSep,yWebVGn, webVGnWidth, webVArbRen)];
        lblGnTitulo.textAlignment=NSTextAlignmentCenter;
       */
        htmlStringGn=htmlEvGn;
        
        [self eventos_Mes:month anio:year];
        /*
        if(sigAnio)
        {
            lblGnTitulo.text=[NSString stringWithFormat:@"%@ %ld",[mesesArr objectAtIndex:month],(long)year]; //Meses Otros Eventos
        }
        else
        {
            lblGnTitulo.text=[mesesArr objectAtIndex:month]; //Meses Otros Eventos
        }
        
        [lblGnTitulo setFont:[UIFont fontWithName:@"GaramondPremrPro-It" size:14.0]];
        
        [sclViewEvGen addSubview:lblGnTitulo];
        sclViewEvGen.contentSize = CGSizeMake(xWebVGn+webVGnSep, 0);
        htmlStringGn=[htmlStringGn stringByAppendingString:@"</div></body></html>"];
        [webviewGn loadHTMLString:htmlStringGn baseURL:nil];
        [sclViewEvGen addSubview:webviewGn];
        webviewGn.delegate=self;
        */
        month=month+1;
    }
    sigAnio=NO;
    htmlStringArb=[htmlStringArb stringByAppendingString:@"</div></body></html>"];
    
    sclViewEvGen.contentSize = CGSizeMake(webVArbWidth, 0);
    htmlStringGn=[htmlStringGn stringByAppendingString:@"</div></body></html>"];
    
    [webviewGn loadHTMLString:htmlStringGn baseURL:nil];
        //[sclViewEvGen addSubview:webviewGn];
    [evView addSubview:webviewGn];
    
    webviewGn.delegate=self;

    [webviewArb loadHTMLString:htmlStringArb baseURL:nil];
    [/*sclViewEvArb*/evView addSubview:webviewArb];
    webviewArb.delegate=self;
    
//    UIButton *myButtonX = [UIButton buttonWithType:UIButtonTypeCustom];
//    [myButtonX addTarget:self action:@selector(cerrarEv) forControlEvents:UIControlEventTouchUpInside];
//    [myButtonX setBackgroundColor:[UIColor colorWithRed:(255.0/255.0) green:(201.0/255.0) blue:(14.0/255.0) alpha:1]];
//    [myButtonX setTitle:@" X " forState:UIControlStateNormal];
//    myButtonX.frame = CGRectMake(evViewWidth-btnCerrarWidth, btnCerrarY, btnCerrarWidth, btnCerrarHeight);//NSInteger evViewX=0,evViewY=255,evViewWidth=375,evViewheight=280;
//    [evView addSubview:myButtonX];
}

-(void)cerrarEv
{
    [sclViewEvGen.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [sclViewEvGen removeFromSuperview];
    [evView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [evView removeFromSuperview];
}

CGFloat xScrCl=11,yScrCl=60,wScrCl=300.0,hScrCl=504.0; //wScrCl=widthCl; x y ancho alto -> scroll
CGFloat /*xbtn=0,ybtn=0,*/widthCl=300.0,heightCl=100.0; // ancho alto -> boton
NSMutableArray *arrayCategorias01;
UIScrollView *scrollviewCl;
- (IBAction)ibaBtnCul:(UIButton*)sender
{
    NSString *id01;
    if(sender.accessibilityIdentifier) // lo tenia - >> adelante Sub categorias
    {
        id01=sender.accessibilityIdentifier;
    }
    else
    {
        id01=@"0";
        [[GAI sharedInstance].defaultTracker send:[[[GAIDictionaryBuilder createScreenView] set:@"Cultura" forKey:kGAIScreenName] build]];
    }
    if(sender.accessibilityHint) // << atras Sub categorias
    {
        NSArray *result=[self idCatCul:id01 idC:@"idCategoria"];
        NSString *idPadre;
        if([result count]>0)
        {
            for(Categorias *cat in result)
            {
                //printf("\nidCat:%s idPad:%s nom:%s\n",[cat.idCategoria UTF8String],[cat.idPadre UTF8String],[cat.nombre UTF8String]);
                idPadre=cat.idPadre;
            }
        }
        else
        {
            NSLog(@"01 No hay datos idPadreCat...");
        }
        id01=idPadre;
        [arrayCategorias01 removeLastObject];
    }
    
    if(sender.accessibilityLabel)
    {
        [arrayCategorias01 addObject:sender.accessibilityLabel];
    }
    
    [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [scrollviewCl removeFromSuperview];
    CGFloat xbtnCl=0,ybtnCl=0;//,width=300.0,height=30.0;
    scrollviewCl=[[UIScrollView alloc]initWithFrame:CGRectMake(xScrCl, yScrCl, wScrCl, hScrCl)];
    [self.view addSubview:scrollviewCl];

    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"ZCl_categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idPadre=%@",id01]; //idPadre=0 >> adelante Sub categorias
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        UIButton *myButton01 = [UIButton buttonWithType:UIButtonTypeCustom];
        [myButton01 addTarget:self action:@selector(ibaBtnCul:) forControlEvents:UIControlEventTouchUpInside];
        [myButton01 setBackgroundColor:[UIColor colorWithRed:(255.0/255.0) green:(201.0/255.0) blue:(14.0/255.0) alpha:1]];
        [myButton01 setTitle:@"< < <" forState:UIControlStateNormal];
        myButton01.frame = CGRectMake(xbtnCl, ybtnCl, widthCl, heightCl);
        [scrollviewCl addSubview:myButton01];
        ybtnCl=ybtnCl+heightCl+1;
        
        for(ZCl_categorias *cat in fetchedArray)
        {
            if(![cat.idCategoria isEqualToString:@"-1"])
            {
                UIButton *myButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [myButton setAccessibilityIdentifier:cat.idCategoria]; // >> adelante Sub categorias
                [myButton01 setAccessibilityHint:@"atras"]; // << atras Sub categorias
                [myButton01 setAccessibilityIdentifier:cat.idPadre]; // << atras Sub categorias
                [myButton setBackgroundColor:[UIColor colorWithRed:(51.0/255.0) green:(250.0/255.0) blue:(247.0/255.0) alpha:1]];
                [myButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                
                UIButton *myButton02;
                NSString *titulo;
                NSArray *result01=[self idCatCul:cat.idCategoria idC:@"idPadre"];
                
                if([result01 count]>0)
                {
                    [myButton addTarget:self action:@selector(ibaBtnCul:) forControlEvents:UIControlEventTouchUpInside];
                    titulo=[NSString stringWithFormat:@"%@ >>",cat.nombre];
                    [myButton setAccessibilityLabel:cat.nombre];
                }
                else
                {
                    [myButton addTarget:self action:@selector(culCat:) forControlEvents:UIControlEventTouchUpInside];
                    titulo=[NSString stringWithFormat:@"%@",cat.nombre];
                    [myButton setAccessibilityLabel:cat.nombre];
                }
                
                NSString *uppercase = [titulo uppercaseString];
                titulo =  uppercase;
                [myButton setTitle:titulo forState:UIControlStateNormal];
                [myButton.titleLabel setFont:[UIFont fontWithName:@"Futura" size:14.0]];
                [myButton setBackgroundImage:[UIImage imageNamed:@"anteimg1.jpg"] forState:UIControlStateNormal];
                myButton.frame = CGRectMake(xbtnCl, ybtnCl, widthCl, heightCl);
                myButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                myButton.contentEdgeInsets = UIEdgeInsetsMake(70, 10, 0, 0);
                
                [scrollviewCl addSubview:myButton];
                [scrollviewCl addSubview:myButton02];
                
                ybtnCl=ybtnCl+heightCl+10;
                //printf("\nidCat:%s\t\tcategoria:%s\t\t\t\tidPadre:%s",[cat.idCategoria UTF8String],[cat.nombre UTF8String],[cat.idPadre UTF8String]);
            }
        }
        
        CGFloat scHScrCl;
        if(ybtnCl<hScrCl)
        {
            scHScrCl=ybtnCl;
        }
        else
        {
            scHScrCl=hScrCl;
        }
        scrollviewCl.frame = CGRectMake(xScrCl, yScrCl, wScrCl, scHScrCl);
        
        scrollviewCl.contentSize = CGSizeMake(widthCl, ybtnCl);
        scrollviewCl.showsVerticalScrollIndicator=YES;
        scrollviewCl.scrollEnabled=YES;
        scrollviewCl.userInteractionEnabled=YES;
        scrollviewCl.backgroundColor = [UIColor colorWithRed:(251.0/255.0) green:(250.0/255.0) blue:(247.0/255.0) alpha:1];
    }
    else
    {
        //NSLog(@"01 No hay datos...arrayCat:%@",arrayCategorias01);
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
    }
}

-(void)culCat:(UIButton*)sender
{
    NSString *id01;
    if(sender.accessibilityIdentifier)
    {
        id01=sender.accessibilityIdentifier;
    }
    else
    {
        id01=@"0";
    }
    
    if(sender.accessibilityLabel)
    {
        [arrayCategorias01 addObject:sender.accessibilityLabel];
        NSString *output = [arrayCategorias01 componentsJoinedByString:@" > "];
        NSString *output2 = [NSString stringWithFormat:@"Cultura:\"%@\"",output];
[[GAI sharedInstance].defaultTracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Categorias" action:@"buttonClick" label:output2 value:nil] build]];
        NSLog(@"00 *SI* culCat output2:%@",output2);
    }
    
    NSString *idCultura00,*idCategoria00,*idCultura01,*nombreCl00,*fotografiaCl00,*autorCl00,*descripcionCl00;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"ZCl_categoriaCultura" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idCategoria=%@",id01];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        [scrollviewCl.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [scrollviewCl removeFromSuperview];
        
        for(ZCl_categoriaCultura *cng in fetchedArray)
        {
            idCultura00=cng.idCultura;
            idCategoria00=cng.idCategoria;
            idCultura01=cng.cultura.idCultura;
            nombreCl00=cng.cultura.nombre;
            //fotografiaCl00=cng.cultura.fotografia;
            autorCl00=cng.cultura.autor;
            descripcionCl00=cng.cultura.descripcion;
            
            NSArray *arrImg=[self imagenCl:idCultura00];
            if([arrImg count]>0)
            {
                ZCl_imagenes *img = [arrImg objectAtIndex:0];
                fotografiaCl00=img.url;
            }
            else
            {
                fotografiaCl00=@"";
            }
            
            printf("\nidC:%s..idC:%s..nIdC:%s..nom:%s..foto:%s..aut:%s..des:%s..",[idCultura00 UTF8String],[idCategoria00 UTF8String],[idCultura01 UTF8String],[nombreCl00 UTF8String],[fotografiaCl00 UTF8String],[autorCl00 UTF8String],[descripcionCl00 UTF8String]);
            NSLog(@"img:%@",fotografiaCl00);
        }
        [arrayCategorias01 removeAllObjects];
    }
    else
    {
        //NSLog(@"No hay datos cultCat...");
        [arrayCategorias01 removeLastObject];
        UIAlertView *Msg =[[UIAlertView alloc] initWithTitle:@"Info" message:@"No hay informacion." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [Msg show];
    }
}

-(NSArray*)idCatCul:(NSString*)str01 idC:(NSString*)idC
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"ZCl_categorias" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSPredicate *predicate;
    if([idC isEqualToString:@"idCategoria"])
    {
        predicate=[NSPredicate predicateWithFormat:@"idCategoria=%@",str01]; // << atras Sub categorias
    }
    else
    if([idC isEqualToString:@"idPadre"])
    {
        predicate=[NSPredicate predicateWithFormat:@"idPadre=%@",str01];
    }
    
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    if([fetchedArray count]>0)
    {
        return fetchedArray;
    }
    else
    {
        NSArray *array=[[NSArray alloc]initWithObjects:nil];
        return array;
    }
}

NSString *anio00,*arboleda00,*correo00,*descripcion00,*dia00,*facebook00,*fotografia00,*horas00,*idEvento00,*lugar00,*mes00,*minutos00,*nombre00,*pagina00,*twitter00;
NSArray *mesesArr;
NSInteger thumbsArWd=50,thumbsArHt=50;
NSInteger thumbsGnWd=50,thumbsGnHt=50;
//NSString *htmlEvArb=@"<html><head><title>Eventos Arboleda</title></head><body><div align='center'>";
//NSString *htmlEvGn= @"<html><head><title>Otros Eventos</title></head><body><div align='center'>";

-(void)eventos_Mes:(NSInteger)month anio:(NSInteger)year
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"ZEv_Eventos" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSString *mesStr=[NSString stringWithFormat:@"%ld",(long)month];
    NSString *anioStr=[NSString stringWithFormat:@"%ld",(long)year];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"mes=%@ && anio=%@",mesStr,anioStr];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
        //NSSortDescriptor *sortYear = [[NSSortDescriptor alloc] initWithKey:@"anio" ascending:YES]; // para Numbers.
        //NSSortDescriptor *sortMonth = [[NSSortDescriptor alloc] initWithKey:@"mes" ascending:YES];
    NSSortDescriptor *sortDay = [NSSortDescriptor sortDescriptorWithKey:@"dia" ascending:YES selector:@selector(localizedStandardCompare:)]; // para Strings.
    NSSortDescriptor *sortHrs = [NSSortDescriptor sortDescriptorWithKey:@"horas" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *sortMin = [NSSortDescriptor sortDescriptorWithKey:@"minutos" ascending:YES selector:@selector(localizedStandardCompare:)];
        //[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortArb,sortYear,sortMonth,sortDay,sortHrs,sortMin,nil]];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDay,sortHrs,sortMin, nil]];
    
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
        //NSString *htmArNoEvAA=@"",*htmArNoEv=@"",*htmArNoEvStr=@"",*htmArNoEvSiOTaa=@"",*htmArNoEvSiOT=@"";
    
    if([fetchedArray count]>0)
    {
        int evArbCnt=0,evGnCnt=0;
        for(ZEv_Eventos *ev in fetchedArray)
        {
            anio00=ev.anio;
            arboleda00=ev.arboleda;
            correo00=ev.correo;
            descripcion00=ev.descripcion;
            dia00=ev.dia;
            facebook00=ev.facebook;
                //fotografia00=ev.fotografia;
            horas00=ev.horas;
            idEvento00=ev.idEvento;
            lugar00=ev.lugar;
            mes00=ev.mes;
            minutos00=ev.minutos;
            nombre00=ev.nombre;
            pagina00=ev.pagina;
            twitter00=ev.twitter;
            
            if([horas00 intValue]<10)
            {
                horas00=[NSString stringWithFormat:@"0%@",horas00];
            }
            if([minutos00 intValue]<10)
            {
                minutos00=[NSString stringWithFormat:@"0%@",minutos00];
            }
            
            NSArray *arrImg=[self imagenEv:idEvento00];
            if([arrImg count]>0)
            {
                ZEv_Imagenes *img = [arrImg objectAtIndex:0];
                fotografia00=img.url;
                /*for(ZEv_Imagenes *img in arrImg)
                 {
                 NSLog(@"img:%@",img.url);
                 fotografia00=img.url;
                 }*/
            }
            else
            {
                fotografia00=@"";
            }
            
                // NSURL *url=[[NSBundle mainBundle] bundleURL];
                //  NSString *imageName = @"imagen01.jpg";
                //   NSString *path =[NSString stringWithFormat:@"%@%@",url,imageName];//[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
            
            NSString *htmMmddaa=[NSString stringWithFormat:@"<b>%@ %@ %@</b></u>",[mesesArr objectAtIndex:[mes00 intValue]],dia00,anio00];
            NSString *htmMmdd=[NSString stringWithFormat:@"<b>%@ %@</b></u>",[mesesArr objectAtIndex:[mes00 intValue]],dia00];
                //NSString *htmdd=[NSString stringWithFormat:@"<b>%@</b></u><br><br>",dia00]; // Otros Eventos...
            NSString *htmNombre=[NSString stringWithFormat:@"%@<br>",nombre00];
            
                // NSString *htmImgPathLoc=[NSString stringWithFormat:@"<img src='%@'><br>",path];
                //NSString *htmImgPathInet=[NSString stringWithFormat:@"<img src='%@'><br>",fotografia00];
            NSString *htmImgThumbInet=[NSString stringWithFormat:@"<img src='http://www.inkrender.com/wsDescSP/thumbs.php?url=%@&wd=%ld&ht=%ld'><br>",fotografia00,(long)thumbsArWd,(long)thumbsArHt];
           
            NSURL *MyURL = [[NSBundle mainBundle] URLForResource: @"@_gris" withExtension:@"png"];
            
            NSString *htmDescripcion=[NSString stringWithFormat:@"%@<br>",descripcion00];
            NSString *htmHrsMin=[NSString stringWithFormat:@" - %@:%@ hrs.<br><br>",horas00,minutos00];
            NSString *htmLugar=[NSString stringWithFormat:@"%@<br>",lugar00];
            NSString *htmPagina=[NSString stringWithFormat:@"<a href='%@'><input style='background-image:url(%@); height: 113px; width: 113px; border:0px; ' type='button'></a><br>",pagina00,MyURL];
            NSString *htmFacebook=[NSString stringWithFormat:@"<a href='http://www.facebook.com/%@'>facebook.com/%@</a><br>",facebook00,facebook00];
            NSString *htmTwitter=[NSString stringWithFormat:@"<a href='http://www.twitter.com/%@'>twitter.com/%@</a><br>",twitter00,twitter00];
            NSString *htmCorreo=[NSString stringWithFormat:@"<a href='mailto:%@'>%@</a><br><br>",correo00,correo00];
            
            
                //NSString *htmPagBtn = [NSString stringWithFormat:@"<input style='background-image:url(%@); height: 113px; width: 113px; border:0px;' type='button' onclick='window.location.href='%@'></div></body></html>",MyURL,pagina00];
            
                //printf("'año:%s,,mes:%s,,dia:%s,,arb?:%s,,correo:%s,,desc:%s,,fb:%s,,foto:%s,,hora:%s,,idEv:%s,,lugar:%s,,min:%s,,nom:%s,,pag:%s,,tw:%s'\n",[anio00 UTF8String],[mes00 UTF8String],[dia00 UTF8String],[arboleda00 UTF8String],[correo00 UTF8String],[descripcion00 UTF8String],[facebook00 UTF8String],[fotografia00 UTF8String],[horas00 UTF8String],[idEvento00 UTF8String],[lugar00 UTF8String],[minutos00 UTF8String],[nombre00 UTF8String],[pagina00 UTF8String],[twitter00 UTF8String]);
            
                //printf("'año:%s,,mes:%s,,dia:%s,,hrs:%s,,min:%s,,arb?:%s,,idEv:%s\n",[anio00 UTF8String],[mes00 UTF8String],[dia00 UTF8String],[horas00 UTF8String],[minutos00 UTF8String],[arboleda00 UTF8String],[idEvento00 UTF8String]);
            
            if([arboleda00 isEqualToString:@"si"])
            {
                    //printf("'año:%s,,mes:%s,,dia:%s,,hrs:%s,,min:%s,,arb?:%s,,idEv:%s\n",[anio00 UTF8String],[mes00 UTF8String],[dia00 UTF8String],[horas00 UTF8String],[minutos00 UTF8String],[arboleda00 UTF8String],[idEvento00 UTF8String]);
                
                if([fotografia00 isEqualToString:@""])
                {
                        // si no se quiere poner nada.
                    /*if(sigAnio)
                     {
                     htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                     }
                     else
                     {
                     htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                     }*/
                    
                        // ***** Si se quiere cargar una imagen local *****
                    if(sigAnio)
                    {
                        htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                    }
                    else
                    {
                        htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                    }
                }
                else
                {
                        //NSLog(@"fotografia00:%@",fotografia00);
                    bool inet=[self testConnection];
                    if(inet)
                    {
                            // thumbnails
                        if(sigAnio)
                        {
                            htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmImgThumbInet,htmMmddaa,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                        else
                        {
                            htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmImgThumbInet,htmMmdd,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                        
                            // NO thumbnails
                        /*if(sigAnio)
                         {
                         htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmNombre,htmImgPathInet,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                         }
                         else
                         {
                         htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmNombre,htmImgPathInet,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                         }*/
                    }
                    else
                    {
                            // ***** Si se quiere cargar una imagen local *****
                        if(sigAnio)
                        {
                            htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                        else
                        {
                            htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                    }
                }
                evArbCnt++;
            }
            else
            {
                    // NSString *htmlStringEvn=@""; // *****
                if([fotografia00 isEqualToString:@""])
                {
                        // *****
                        // Si se quiere cargar una imagen local
                    if(sigAnio)
                    {
                        htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                    }
                    else
                    {
                        htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                    }
                        // *****
                    
                        // si no se quiere poner nada.
                        //htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmdd,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                    
                        // Si se quiere cargar una imagen local
                        // htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgPathLoc,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                        //***htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgPathLoc,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                }
                else
                {
                    bool inet=[self testConnection];
                    if(inet)
                    {
                            // *****
                            // con thumbnail...
                        if(sigAnio)
                        {
                            htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmImgThumbInet,htmMmddaa,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                        else
                        {
                            htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmImgThumbInet,htmMmdd,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                            // *****
                        
                            // thumbnail...
                            //htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgThumbInet,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                        
                            //***htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgThumbInet,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                            //NSLog(@"\n001...\nhtmlStringEvn:\n%@\n",htmlStringEvn);
                        
                        
                            // NO thumbnail...
                            //htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@<hr>",htmdd,htmNombre,htmImgPathInet,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                    }
                    else
                    {
                            // *****
                            // Si se quiere cargar una imagen local
                        if(sigAnio)
                        {
                            htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmddaa,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                        else
                        {
                            htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmHrsMin,htmNombre,htmDescripcion,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                        }
                            // *****
                        
                            // si no se quiere poner nada.
                            //htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@<hr>",htmdd,htmNombre,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                        
                        
                            // Si se quiere cargar una imagen local
                            //htmlStringEvn=[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgPathLoc,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo];
                            //htmlStringEvn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"<br>%@%@%@%@%@%@%@%@%@%@%@<hr>",htmMmdd,htmdd,htmNombre,htmImgPathLoc,htmDescripcion,htmHrsMin,htmLugar,htmPagina,htmFacebook,htmTwitter,htmCorreo]];
                            //NSLog(@"\n002...\nhtmlStringEvn:\n%@\n",htmlStringEvn);
                    }
                }
                htmlStringGn=[htmlStringGn stringByAppendingString:htmlStringEvn];
                evGnCnt++;
                
                    //printf("\n'año:%s,,mes:%s,,dia:%s,,arb?:%s,,correo:%s,,desc:%s,,fb:%s,,foto:%s,,hora:%s,,idEv:%s,,lugar:%s,,min:%s,,nom:%s,,pag:%s,,tw:%s'\n",[anio00 UTF8String],[mes00 UTF8String],[dia00 UTF8String],[arboleda00 UTF8String],[correo00 UTF8String],[descripcion00 UTF8String],[facebook00 UTF8String],[fotografia00 UTF8String],[horas00 UTF8String],[idEvento00 UTF8String],[lugar00 UTF8String],[minutos00 UTF8String],[nombre00 UTF8String],[pagina00 UTF8String],[twitter00 UTF8String]);
            }
        }
            // Cuando no hay evento en Arboleda pero si hay en Otros...
        NSString *htmArNoEvSiOTaa=[NSString stringWithFormat:@"<b>%@ %@</b><br><br>0 No hay Eventos**...<br><br>",[mesesArr objectAtIndex:[mes00 intValue]],anio00];
        NSString *htmArNoEvSiOT=[NSString stringWithFormat:@"<b>%@</b><br><br>0 No hay Eventos*...<br><br>",[mesesArr objectAtIndex:[mes00 intValue]]];
        
            // Cuando no hay Otros Eventos pero si hay en Arboleda...
        NSString *htmOtNoEvSiAr=@"01 No hay Eventos...";
        
        if(evArbCnt==0)
        {
            if(sigAnio)
            {
                htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@<hr>",htmArNoEvSiOTaa]]; //htmlEvArb
            }
            else
            {
                htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@<hr>",htmArNoEvSiOT]]; //htmlEvArb
            }
        }
        if(evGnCnt==0)
        {
                // *****
            NSString *str01=@"";
            if(sigAnio)
            {
                str01=[NSString stringWithFormat:@"<br><b>%@ %@</b><br><br>%@<br><br><hr>",[mesesArr objectAtIndex:[mes00 intValue]],anio00,htmOtNoEvSiAr];
            }
            else
            {
                str01=[NSString stringWithFormat:@"<br><b>%@</b><br><br>%@<br><br><hr>",[mesesArr objectAtIndex:[mes00 intValue]],htmOtNoEvSiAr];
            }
            htmlStringEvn=[htmlStringEvn stringByAppendingString:str01];
            htmlStringGn=[htmlStringGn stringByAppendingString:htmlStringEvn];
                // *****
            
                //htmlStringGn=[NSString stringWithFormat:@"%@<br>%@",htmlEvGn,htmOtNoEvSiAr];
                //htmlStringGn=[htmlStringEvn stringByAppendingString:[NSString stringWithFormat:@"%@<br>%@",htmlEvGn,htmOtNoEvSiAr]];
                //NSString *str01=[NSString stringWithFormat:@"%@<br>%@",htmlEvGn,htmOtNoEvSiAr];
                //NSLog(@"*****\nevGnCnt==0\nhtmlStringEvn:\n%@\nstr01:\n%@\nhtmlStringGn:\n%@",htmlStringEvn,str01,htmlStringGn);
            
                //htmlStringGn=[htmlStringGn stringByAppendingString:[NSString stringWithFormat:@"%@%@",htmlStringEvn,str01]];
                //NSLog(@"\n*****\nevGnCnt==0 mesesArr:%@\nhtmlStringGn:%@\n*****",[mesesArr objectAtIndex:[mesStr intValue]],htmlStringGn);
        }
    }
    else
    {
            // No hay eventos Arboleda...
        NSString *htmArNoEvAA=[NSString stringWithFormat:@"<br><b>%@ %@</b><br>",[mesesArr objectAtIndex:[mesStr intValue]],anioStr];
        NSString *htmArNoEv=[NSString stringWithFormat:@"<br><b>%@</b><br>",[mesesArr objectAtIndex:[mesStr intValue]]];
        NSString *htmArNoEvStr=[NSString stringWithFormat:@"%@<br><br>",@"No hay Eventos..."];
        
            // No hay Otros Eventos...
            //NSLog(@"mesesArr:%@",[mesesArr objectAtIndex:[mesStr intValue]]);
            // *****
        NSString *htmlStringNOevStr=@"02 No hay Eventos...";
        NSString *htmlStringNOevAA=[NSString stringWithFormat:@"<br><b>%@ %@</b><br><br>%@<br><br><hr>",[mesesArr objectAtIndex:[mesStr intValue]],anioStr,htmlStringNOevStr];
        NSString *htmlStringNOev=[NSString stringWithFormat:@"<br><b>%@</b><br><br>%@<br><br><hr>",[mesesArr objectAtIndex:[mesStr intValue]],htmlStringNOevStr];
            // *****
        
            //NSLog(@"No hay Eventos...");
        if(sigAnio)
        {
            htmlStringArb=[htmlStringArb stringByAppendingString:htmArNoEvAA];
            htmlStringEvn=[htmlStringEvn stringByAppendingString:htmlStringNOevAA]; // *****
        }
        else
        {
            htmlStringArb=[htmlStringArb stringByAppendingString:htmArNoEv];
            htmlStringEvn=[htmlStringEvn stringByAppendingString:htmlStringNOev]; // *****
        }
        htmlStringArb=[htmlStringArb stringByAppendingString:[NSString stringWithFormat:@"<br>%@<hr>",htmArNoEvStr]];
        
            // *****
        htmlStringGn=[htmlStringGn stringByAppendingString:[NSString stringWithFormat:@"%@",htmlStringEvn]];
            // *****
        
            //htmlStringGn=[htmlStringGn stringByAppendingString:[NSString stringWithFormat:@"<br>%@",htmlStringNOev]];
            //htmlStringGn=[htmlStringGn stringByAppendingString:htmlStringEvn];
            //htmlStringGn=[htmlStringGn stringByAppendingString:[NSString stringWithFormat:@"<br>%@",htmlStringNOev]];
        
    }
    xWebVGn=xWebVGn+webVGnWidth+webVGnSep;
    
}

-(NSArray*)imagenNg:(NSString*)idNg
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *Ev_Imagenes=[NSEntityDescription entityForName:@"ImagenesNeg" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idNegocio=%@",idNg]];
    [fetchRequest setEntity:Ev_Imagenes];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedArray;
}

-(NSArray*)imagenEv:(NSString*)idEv
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *Ev_Imagenes=[NSEntityDescription entityForName:@"ZEv_Imagenes" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idEvento=%@",idEv]];
    [fetchRequest setEntity:Ev_Imagenes];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedArray;
}

-(NSArray*)imagenCl:(NSString*)idCl
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error = nil;
    
    NSEntityDescription *Ev_Imagenes=[NSEntityDescription entityForName:@"ZCl_imagenes" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"idCultura=%@",idCl]];
    [fetchRequest setEntity:Ev_Imagenes];
    NSArray *fetchedArray = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedArray;
}

-(BOOL)testConnection
{
    NSURL *url1 = [NSURL URLWithString:@"http://www.inkrender.com/temp/verde.png"];
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    if(data1==nil)
    {
        //NSLog(@"No hay internet.");
        return NO;
    }
    else
    {
        //NSLog(@"Conectado a internet.");
        return YES;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if(navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        NSLog(@"...UIWebViewNavigationTypeLinkClicked...");
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //NSLog(@"...webViewDidStartLoad...");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //NSLog(@"...webViewDidFinishLoad...");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"...didFailLoadWithError...");
}

@end
