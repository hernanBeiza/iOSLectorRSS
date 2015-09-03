//
//  NSDate+Utilidades.h
//  Musa
//
//  Created by Hernán Beiza on 8/26/14.
//  Copyright (c) 2014 Geofaro. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Utilidades para NSDate ¡Importante!
 */
@interface NSDate (Utilidades)
/**
 *  Cuenta los días entre dos fechas. Imporntate para saber cuántas pastillas quedan, etc
 *
 *  @param fromDateTime NSDate primera fecha
 *  @param toDateTime   NSDate segunda fecha
 *
 *  @return NSInteger diferencia de días
 */
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
/**
 *  Días entre la fecha inicial y la fecha final
 *
 *  @param inicialDate NDate primera fecha
 *  @param finalDate   NSDate segunda fecha
 *
 *  @return NSInteger diferencia de días
 */
+ (NSInteger)diasEntreFechaInicial:(NSDate*)inicialDate fechaFinal:(NSDate*)finalDate;
/**
 *  Sirve para identificar si un NSDate está entre dos NSDate
 *
 *  @param date      NSDate a revisar
 *  @param beginDate NSDate fecha inicial
 *  @param endDate   NSDate segunda fecha
 *
 *  @return BOOL YES si está entre las dos fechas. NO en caso contrario
 */
+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate;
/**
 *  Une dos NSDate para crear uno nuevo.
 *
 *  @param fecha NSDate con el día, mes y año
 *  @param hora  NSDate con la hora
 *
 *  @return NSDate con NSDate unidos
 */
+ (NSDate*)fusionarFecha:(NSDate*)fecha conHora:(NSDate*)hora;
/**
 *  Permite revisar si dos fechas son iguales
 *
 *  @param date1 NSDate primera fecha a evaluar
 *  @param date2 NSDate segunda fecha a evaluar
 *
 *  @return BOOL. YES si son iguales. NO en caso contrario
 */
+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
@end
