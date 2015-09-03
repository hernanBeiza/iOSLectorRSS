//
//  UIViewController+Utilidades.h
//  FotoSantiago
//
//  Created by Informática Spock on 20-06-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreLocation/CoreLocation.h>
/**
 *  Categoría para UIViewController
 */
@interface UIViewController (Utilidades)
/**
 *  Determina si el equipo está conectado a Internet
 *
 *  @return BOOL YES si está conectado. NO en caso contrario
 */
- (BOOL)conectado;
/**
 *  Determina si el equipo tiene GPS
 *
 *  @return BOOL YES si está. NO en caso contrario.
 */
- (BOOL)conGPS;
/**
 *  Determina si una foto está horizontal o no
 *
 *  @param foto UIImage de la foto a evaluar
 *
 *  @return BOOL YES si no está. NO en caso contrario.
 */
- (BOOL)apaisadaFoto:(UIImage*)foto;
/**
 *  Valida si un email está bien escrito
 *
 *  @param email NSString con el email a evaluar
 *
 *  @return BOOL YES si no está. NO en caso contrario
 */
- (BOOL)validarEmail:(NSString*)email;
/**
 *  Escala una UIImage a un CGSize dado
 *
 *  @param image   UIImage a escalar
 *  @param newSize CGSize para escalar
 *
 *  @return UIImage escalado
 */
- (UIImage *)escalarImagen:(UIImage*)image toSize:(CGSize)newSize;
/**
 *  Sin información
 *
 *  @param imagenOriginal UIImage en cuestión
 *
 *  @return UImage normalizado
 */
- (UIImage *)normalizedImage:(UIImage*)imagenOriginal;
/**
 *  Determina si es un iPhone 5 o 5S
 *
 *  @return BOOL YES si iPhone 5 o 5S. NO en caso contrario
 */
- (BOOL)is4InchRetina;
@end
