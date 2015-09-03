//
//  NSDate+Utilidades.m
//  Musa
//
//  Created by Hernán Beiza on 8/26/14.
//  Copyright (c) 2014 Geofaro. All rights reserved.
//

#import "NSDate+Utilidades.h"

@implementation NSDate (Utilidades)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:toDateTime];
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

+ (NSInteger)diasEntreFechaInicial:(NSDate *)inicialDate fechaFinal:(NSDate *)finalDate
{
    NSLog(@"inicialDate %@",inicialDate);
    NSLog(@"finalDate %@",finalDate);
    NSTimeInterval secondsBetween = [inicialDate timeIntervalSinceDate:finalDate];
    NSInteger dias = secondsBetween / 86400;    
    return dias;
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
        return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
        return NO;
    
    return YES;
}

+ (NSDate*)fusionarFecha:(NSDate*)fecha conHora:(NSDate*)hora
{
    //Fusionar hora y fecha en fechaEvento
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:fecha];
    NSDate *fechaNueva = [[NSCalendar currentCalendar] dateFromComponents:comps];
    unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [[NSCalendar currentCalendar] components:unitFlags fromDate:hora];
    fechaNueva = [[NSCalendar currentCalendar] dateByAddingComponents:comps toDate:fechaNueva options:0];
    //DBLog(@"NSDate fechaNueva %@",fechaNueva);
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale systemLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *fechaNuevaString = [dateFormatter stringFromDate:fechaNueva];
    DBLog(@"NSDate fechaNueva %@",fechaNueva);
    DBLog(@"NSString fechaNuevaString %@",fechaNuevaString);
    */
    return fechaNueva;
}

+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

@end
