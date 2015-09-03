//
//  RSSParser.h
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RSSParser;
@protocol RSSParserDelegate <NSObject>
@required
- (void)rssParser:(RSSParser*)parser conDatos:(NSArray*)datos;
- (void)rssParser:(RSSParser*)parser conError:(NSError*)error;
@end
@interface RSSParser : NSObject
@property (nonatomic,weak) id delegate;
- (void)iniciar;
- (void)detener;
@end
