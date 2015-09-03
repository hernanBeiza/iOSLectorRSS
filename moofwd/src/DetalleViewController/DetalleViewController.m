//
//  DetalleViewController.m
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//

#import "DetalleViewController.h"
#import "UIImageView+WebCache.h"

@interface DetalleViewController ()
@property (nonatomic,weak) IBOutlet UIImageView *fotoImageView;
@property (nonatomic,weak) IBOutlet UILabel *tituloLabel;
@property (nonatomic,weak) IBOutlet UILabel *fechaLabel;
@property (nonatomic,weak) IBOutlet UITextView *descripcionTextView;

@end

@implementation DetalleViewController
@synthesize fotoImageView;
@synthesize tituloLabel;
@synthesize fechaLabel;
@synthesize descripcionTextView;
@synthesize info;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hiperactivo"]];
    self.navigationItem.titleView =logoImageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    NSString *titulo = [info valueForKey:@"title"];
    NSString *pubDate2 = [info valueForKey:@"pubDate2"];
    NSString *description = [info valueForKey:@"description"];

    NSLog(@"%@",titulo);
    NSLog(@"%@",pubDate2);
    NSLog(@"%@",description);
    
    if (titulo) {
        [tituloLabel setText:titulo];
    }
    if (pubDate2) {
        [fechaLabel setText:pubDate2];
    }
    if (description) {
        [descripcionTextView setText:[self stringByStrippingHTML:description]];
    }

    [fotoImageView sd_setImageWithURL:[NSURL URLWithString:[info valueForKey:@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [UIView animateWithDuration:0.5 animations:^{
            [fotoImageView setAlpha:1.0];
        }];
    }];
}

- (NSString *) stringByStrippingHTML:(NSString *)string {
    NSRange r;
    NSString *s = string;
    while ((r = [s rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        s = [s stringByReplacingCharactersInRange:r withString:@""];
    return s;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    info = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
