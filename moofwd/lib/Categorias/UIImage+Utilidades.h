//
//  UIImage+Utilidades.h
//  Musa
//
//  Created by Hernán Beiza on 9/24/14.
//  Copyright (c) 2014 Geofaro. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Categoría para UIImage
 */
@interface UIImage (Utilidades)
/**
 *  Pinta un UIImage con un UIColor
 *
 *  @param color UIColor para pintar
 *
 *  @return UIImage con el resultado
 */
- (UIImage *)imageWithColor:(UIColor *)color;
@end
