//
//  UIDevice+Hardware.h
//  Doggis
//
//  Created by Hernán Beiza on 10/4/13.
//  Copyright (c) 2013 Geofaro. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Categoría para UIDevice. Permite saber que tipo de iPhone es. ¡Hay que actualizarla!
 */
@interface UIDevice (Hardware)
/**
 *  Devuelve la plataforma del iPhone
 *
 *  @return NSString con la plataforma
 */
- (NSString *) platform;

@end
