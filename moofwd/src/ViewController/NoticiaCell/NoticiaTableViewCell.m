//
//  NoticiaTableViewCell.m
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//

#import "NoticiaTableViewCell.h"

#import "UIImageView+WebCache.h"
#import "Macros.h"
@interface NoticiaTableViewCell ()
@property (nonatomic,weak) IBOutlet UIImageView *fotoImageView;
@property (nonatomic,weak) IBOutlet UILabel *tituloLabel;
@property (nonatomic,weak) IBOutlet UILabel *descripcionLabel;
@property (nonatomic,weak) IBOutlet UILabel *fechaLabel;
@property (nonatomic,weak) IBOutlet UIButton *infoButton;

@end
@implementation NoticiaTableViewCell
@synthesize delegate;
@synthesize fotoImageView;
@synthesize tituloLabel;
@synthesize descripcionLabel;
@synthesize fechaLabel;
@synthesize infoButton;
@synthesize miIndexPath;

- (void)awakeFromNib {
    // Initialization code
    [infoButton addTarget:self action:@selector(irDetalle) forControlEvents:UIControlEventTouchUpInside];
}

- (void)irDetalle
{
    [[self delegate] noticiaTableViewCell:self irDetalleConPath:miIndexPath];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)config:(NSDictionary*)noticia
{
    DBLog(@"");
    DBLog(@"%@",noticia);
    
    NSString *image = [noticia valueForKey:@"image"];
    NSString *titulo = [noticia valueForKey:@"title"];

    NSLog(@"%@",image);
    if (titulo) {
        [tituloLabel setText:titulo];
    } else {
        [tituloLabel setText:@"N/A"];
    }
    NSLog(@"%@",[noticia valueForKey:@"pubDate2"]);
    [fechaLabel setText:[noticia valueForKey:@"pubDate2"]];
    
    [descripcionLabel setText:[noticia valueForKey:@"description"]];
    [fotoImageView sd_setImageWithURL:[NSURL URLWithString:[noticia valueForKey:@"image"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [UIView animateWithDuration:0.5 animations:^{
            [fotoImageView setAlpha:1.0];
        }];
    }];
}

- (void)dealloc
{
    miIndexPath = nil;
}

@end
