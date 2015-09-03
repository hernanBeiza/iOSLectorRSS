//
//  CargadorView.h
//  Cargador
//
//  Created by Hernán Beiza on 31-05-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  Vista que indica algo que se está cargando.
 */
@interface CargadorView : UIView
{
    UIView *fondoNegroView;
    UIActivityIndicatorView *spinnerActivityView;
    UITextField *txtMensaje;
}

+ (CargadorView *)sharedCargadorView;
- (void)animaEnView:(UIView*)view;
- (void)mensajeIN:(NSString*)mensaje;
- (void)centrarme;

- (void)animaIN;
- (void)animaOUT;


@end
