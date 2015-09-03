//
//  UIViewController+Utilidades.m
//  FotoSantiago
//
//  Created by Informática Spock on 20-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIViewController+Utilidades.h"

@implementation UIViewController (Utilidades)

- (BOOL)conectado
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                /*
                 // if target host is not reachable
                 UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Conéctate"
                 message:@"Necesitas Internet para ocupar esta aplicación"
                 delegate:self cancelButtonTitle:@"¡Ok!" otherButtonTitles:nil, nil];
                 [alerta show];
                 */
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

- (BOOL)conGPS
{
    if([CLLocationManager locationServicesEnabled]) {
        return YES;
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Servicio de ubicación"
                                    message:@"El GPS está apagado. Debes activarlo para poder ocupar Posstal"
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil]show];
        
        return NO;
    }
}

- (BOOL)apaisadaFoto:(UIImage*)foto
{
    BOOL estado;
    if(foto.size.width>foto.size.height){
        estado = YES;
    }else{
        estado = NO;
    }
    return estado;
}

- (BOOL)validarEmail:(NSString*)email
{
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:email] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}

- (UIImage *)escalarImagen:(UIImage *)image toSize:(CGSize)newSize
{
    /*
     if(image.size.width>image.size.height){
     NSLog(@"landScape");
     }else{
     NSLog(@"portrait");
     }
     */
    //NSLog(@"UIImage Original Ancho %f",image.size.width);
    //NSLog(@"UIImage Original Alto %f",image.size.height);
    NSLog(@"UIImage Original Ancho %f Alto %f",image.size.width,image.size.height);
    
    int porcentaje = (newSize.width * 100) / image.size.width;
    int altoFinal = (porcentaje * image.size.height)/100;
    /*
     NSLog(@"PORCENTAJE %i", porcentaje);
     NSLog(@"ANCHO FINAL %f", newSize.width);
     NSLog(@"ALTO FINAL %i", altoFinal);
     */
    newSize.height = altoFinal;
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    
    UIImage *nuevaImagen = UIGraphicsGetImageFromCurrentImageContext();
    //NSLog(@"UIImage Nueva Ancho %f",nuevaImagen.size.width);
    //NSLog(@"UIImage Nueva Alto %f",nuevaImagen.size.height);
    NSLog(@"anchoNuevo %f altoNuevo %f",nuevaImagen.size.width,nuevaImagen.size.height);
    UIGraphicsEndImageContext();
    return nuevaImagen;
}

- (UIImage *)normalizedImage:(UIImage*)imagenOriginal
{
    if (imagenOriginal.imageOrientation == UIImageOrientationUp) return imagenOriginal;
    
    UIGraphicsBeginImageContextWithOptions(imagenOriginal.size, NO, imagenOriginal.scale);
    [imagenOriginal drawInRect:(CGRect){0, 0, imagenOriginal.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

- (BOOL)is4InchRetina
{
    
    //NSLog(@"%f",[[UIScreen mainScreen] applicationFrame].size.width);
    //NSLog(@"%f",[[UIScreen mainScreen] applicationFrame].size.height);
    if([[UIScreen mainScreen] applicationFrame].size.height == 568 || [[UIScreen mainScreen] applicationFrame].size.height == 548){
        return YES;
    }
    
       /*
    if ((![UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 548) ||
        ([UIApplication sharedApplication].statusBarHidden && (int)[[UIScreen mainScreen] applicationFrame].size.height == 568))
        return YES;
    */
    return NO;
}

@end