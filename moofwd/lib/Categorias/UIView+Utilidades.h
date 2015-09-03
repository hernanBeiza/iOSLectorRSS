//
//  UIView+Utilidades.h
//  ModaSantiago
//
//  Created by Hernán Beiza on 07-03-13.
//  Copyright (c) 2013 Nueva Spock LTDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CoreLocation/CoreLocation.h>
/**
 *  Utilidades para el UIView
 */
@interface UIView (Utilidades)
/**
 *  Determina si el teléfono está conectado a internet
 *
 *  @return BOOL YES si está conectado. NO en caso contrario
 */
- (BOOL)conectado;
/**
 *  Determina si el teléfono tiene el GPS con permisos
 *
 *  @return BOOL YES si está con permisos. NO en caso contrario
 */
- (BOOL)conGPS;
/**
 *  Determina si una foto está apaisada o no
 *
 *  @param foto UIImage a evaluar
 *
 *  @return BOOL YES si está horizontal. NO en caso contrario
 */
- (BOOL)apaisadaFoto:(UIImage*)foto;
/**
 *  Valida la estructura de un correo eléctronico
 *
 *  @param email NSString con el correo electrónico
 *
 *  @return BOOL YES si es válido. NO en caso contrario
 */
- (BOOL)validarEmail:(NSString*)email;
/**
 *  Escala una imagen
 *
 *  @param image   UIImage a escalar
 *  @param newSize CGSize destino
 *
 *  @return UIImage escalada
 */
- (UIImage *)escalarImagen:(UIImage*)image toSize:(CGSize)newSize;
/**
 *  Sin uso.
 *
 *  @param imagenOriginal imagen a normalizar
 *
 *  @return Devuelve el UIImage normalizado
 */
- (UIImage *)normalizedImage:(UIImage*)imagenOriginal;
/**
 *  Determina si el teléfono es un iPhone 5 o 5S
 *
 *  @return BOOL YES si es iPhone 5 o 5S. NO en caso contrario
 */
- (BOOL)is4InchRetina;

@end