//
//  RSSParser.m
//  moofwd
//
//  Created by Hernán Beiza on 9/1/15.
//  Copyright (c) 2015 Hiperactivo. All rights reserved.
//


@import UIKit;
#import "RSSParser.h"
#import "Macros.h"
#import "NSObject+Utilidades.h"
NSString *const URLRSS = @"http://www.telegraph.co.uk/sport/football/rss";

@interface RSSParser () <NSURLSessionDelegate,NSXMLParserDelegate>
@property (nonatomic,strong) NSMutableString *datosString;
@property (nonatomic,strong) NSURLSessionDataTask *dataTask;

@property (nonatomic,strong) NSString *miTagPadre;
@property (nonatomic,strong) NSMutableDictionary *item;
@property (nonatomic,strong) NSMutableData *dataXML;
@property (nonatomic,strong) NSMutableArray *datosXML;
@property (nonatomic,strong) NSMutableArray *misDatos;
@property (nonatomic,strong) NSArray *misTagsLimpiar;
@end

@implementation RSSParser
@synthesize dataTask;
@synthesize datosString;

@synthesize dataXML;
@synthesize item;
@synthesize miTagPadre;
@synthesize misTagsLimpiar;
@synthesize datosXML;
@synthesize misDatos;

- (void)iniciar
{
    DBLog(@"");
    if ([self conectado]) {
        DBLog(@"Está conectado");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        NSURL *rutaAntiCloud = [NSURL URLWithString:URLRSS];
        DBLog(@"%@",rutaAntiCloud);
        
        NSError *error = nil;
        [rutaAntiCloud setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        
        NSURLSessionConfiguration *configSession = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *galeriaSession = [NSURLSession sessionWithConfiguration:configSession delegate:self delegateQueue:nil];
        
        miTagPadre =@"title";
        //misTagsLimpiar = [[NSArray alloc] initWithObjects:@"channel", nil];
        
        if (dataTask == nil) {
            dataTask = [galeriaSession dataTaskWithURL:rutaAntiCloud completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                if (!error) {
                    NSXMLParser *galeriaParser = [[NSXMLParser alloc] initWithData:data];
                    [galeriaParser setDelegate:self];
                    [galeriaParser parse];
                } else {
                    [[self delegate] rssParser:self conError:error];
                }
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            }];
            [dataTask resume];
        }
    } else {
        DBLog(@"No está conectado");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [[self delegate] rssParser:self conError:[NSError errorWithDomain:@"404" code:404 userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"No hay internet",@"error", nil]]];
    }
}

- (void)detener
{
    DBLog(@"");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [dataTask cancel];
}
#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    DBLog(@"");
    datosString = [[NSMutableString alloc] init];
    datosXML = [[NSMutableArray alloc] init];
    item = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    //DBLog(@"%@",elementName);
    //DBLog(@"%@",namespaceURI);
    datosString = [[NSMutableString alloc] init];
    if (miTagPadre) {
        if ([miTagPadre isEqualToString:elementName]) {
            //DBLog(@"iniciar item");
            item = [[NSMutableDictionary alloc] init];
        }
               //Obtener alguna imagen que sea...
        if ([elementName isEqualToString:@"enclosure"]) {
            [item setValue:[attributeDict valueForKey:@"url"] forKey:@"image"];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //DBLog(@"%@",string);
    if(!datosString){
        datosString = [[NSMutableString alloc] init];
    }
    [datosString appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    //DBLog(@"%@",datosString);
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //DBLog(@"%@",elementName);
    //DBLog(@"%@",namespaceURI);
    if(datosString){
        datosString = [NSMutableString stringWithString:[datosString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    BOOL agregar = YES;
    for (NSString *tag in misTagsLimpiar) {
        if ([tag isEqualToString:elementName]) {
            agregar = NO;
        }
    }
    
    if (agregar) {
        [item setValue:datosString forKey:elementName];
        //DBLog(@"%@ %@",elementName,datosString);
    }
    
    //Fecha
    if ([elementName isEqualToString:@"pubDate"]) {
        //DBLog(@"%@",datosString);
        //Wed, 02 Sep 2015 12:28:31 GMT
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss zzz"];
        NSDate *fecha = [dateFormatter dateFromString:datosString];
        //NSString *localDateString = [dateFormatter stringFromDate:fecha];
        //[dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateFormat:@"dd/MM/yyyy"];
        NSString *dateString = [dateFormatter stringFromDate:fecha];
        //NSLog(@"%@",dateString);
        [item setValue:dateString forKey:@"pubDate2"];
    }
    

    
    if (miTagPadre) {
        if ([miTagPadre isEqualToString:elementName]) {
            //DBLog(@"Agregar");
            //DBLog(@"%@",item);
            [datosXML addObject:item];
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    //DBLog(@"");
    //DBLog(@"%@",datosXML.lastObject);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    misDatos = [[NSMutableArray alloc] initWithArray:datosXML];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self delegate] rssParser:self conDatos:[NSArray arrayWithArray:misDatos]];
    });
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    DBLog(@"");
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self delegate] rssParser:self conError:parseError];
    });
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error;
{
    DBLog(@"");
}
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler;
{
    DBLog(@"");
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session NS_AVAILABLE_IOS(7_0)
{
    DBLog(@"");
}

- (void)dealloc
{
    DBLog(@"");
    datosString = nil;
    miTagPadre = nil;
    item = nil;
    [dataTask cancel];
    dataTask = nil,
    dataXML = nil;
    datosXML = nil;
    misDatos = nil;
    misTagsLimpiar = nil;
}
@end
