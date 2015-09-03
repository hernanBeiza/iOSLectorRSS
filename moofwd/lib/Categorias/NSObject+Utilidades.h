//
//  NSObject+Utilidades.h
//  ModaSantiago
//
//  Created by Hernán Beiza on 11-03-13.
//  Copyright (c) 2013 Nueva Spock LTDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
/**
 *  Categoría para NSObject
 */
@interface NSObject (Utilidades)
/**
 *  Detecta si está conectado
 *
 *  @return BOOL. YES si está conectado. NO en caso contrario.
 */
- (BOOL)conectado;
/**
 *  Detecta si es iOS7
 *
 *  @return BOOL. YES si es iOS7. NO en caso contrario.
 */
- (BOOL)esiOS7;
/**
 *  Detecta si es iOS8
 *
 *  @return BOOL. YES si es iOS8. NO en caso contrario.
 */
- (BOOL)esiOS8;
/**
 *  Detecta si es iPhone 5 o 5S
 *
 *  @return BOOL. YES si es 5 o 5S. NO en caso contrario.
 */
- (BOOL)is4InchRetina;
@end