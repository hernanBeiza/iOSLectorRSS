//
//  NoticiaTableViewCell.h
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoticiaTableViewCell;

@protocol NoticiaTableViewCellDelegate <NSObject>
@required
- (void)noticiaTableViewCell:(NoticiaTableViewCell*)noticiaTableViewCell irDetalleConPath:(NSIndexPath*)path;
@end

@interface NoticiaTableViewCell : UITableViewCell
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSIndexPath *miIndexPath;
- (void)config:(NSDictionary*)noticia;
@end
