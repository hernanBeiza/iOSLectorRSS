//
//  CargadorView.m
//  Cargador
//
//  Created by Hernán Beiza on 31-05-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CargadorView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CargadorView

+ (CargadorView *)sharedCargadorView
{
    static dispatch_once_t once;
    static CargadorView *manager;
    dispatch_once(&once, ^ { manager = [[CargadorView alloc] init]; });
    return manager;
}

- (id)init
{
    self = [super init];
    
    if(self){
    }
    
    self = [self initWithFrame:CGRectMake(0, 0, 80, 80)];
    [self centrarme];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        // Initialization code
        fondoNegroView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [fondoNegroView setBackgroundColor:[UIColor blackColor]];
        [fondoNegroView setAlpha:0.6];
        
        [fondoNegroView.layer setCornerRadius:10.0f];
        [fondoNegroView.layer setMasksToBounds:YES];
        
        /*
         fondoNegroView.layer.backgroundColor = [UIColor whiteColor].CGColor;
         fondoNegroView.layer.cornerRadius = 20.0;
         fondoNegroView.layer.frame = CGRectInset(fondoNegroView.layer.frame, 20, 20);
         
         fondoNegroView.layer.shadowOffset = CGSizeMake(1, 0);
         fondoNegroView.layer.shadowColor = [[UIColor blackColor] CGColor];
         fondoNegroView.layer.shadowRadius = 5;
         fondoNegroView.layer.shadowOpacity = .25;
         */
        
        spinnerActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //spinnerActivityView.center = CGPointMake(CGRectGetMidX([fondoNegroView bounds]),CGRectGetMidY([fondoNegroView bounds]));
        [spinnerActivityView setFrame:CGRectMake(0,0, frame.size.width, frame.size.height)];
        
        // [fondoNegroView addSubview:spinnerActivityView];
        
        txtMensaje = [[UITextField alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        UIFont* font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        [txtMensaje setFont:font];
        [txtMensaje setTextColor:[UIColor whiteColor]];
        [txtMensaje setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:fondoNegroView];
        
        [self addSubview:spinnerActivityView];
        
        [self addSubview:txtMensaje];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)centrarme
{
    CGFloat anchoPantalla = self.superview.frame.size.width;
    CGFloat altoPantalla = self.superview.frame.size.height;    
    //CGFloat anchoPantalla = [UIScreen mainScreen].applicationFrame.size.width;
    //CGFloat altoPantalla = [UIScreen mainScreen].applicationFrame.size.height;
    //NSLog(@"anchoPantalla %f",anchoPantalla);
    //NSLog(@"altoPantalla %f",altoPantalla);
    [self setFrame:CGRectMake(anchoPantalla/2 - self.frame.size.height /2 ,
                              altoPantalla/2 - self.frame.size.width/2,
                              self.frame.size.width,
                              self.frame.size.height)];
}

- (void)animaEnView:(UIView *)view
{
    [view addSubview:self];
    
    [self centrarme];
    
    [spinnerActivityView startAnimating];
    
    [self setAlpha:0.0];
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)animaIN
{
    [spinnerActivityView startAnimating];
    
    [self setAlpha:0.0];
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animaOUT
{
    
    [self setAlpha:1.0];
    [UIView animateWithDuration:0.5 animations:^{
        [self setAlpha:0.0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [spinnerActivityView stopAnimating];
        [txtMensaje setText:@""];
    }];
    
}

- (void)mensajeIN:(NSString *)mensaje
{
    [txtMensaje setText:mensaje];
}

@end