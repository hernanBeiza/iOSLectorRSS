//
//  Macros.h
//  LosQuiltros
//
//  Created by Hernán Beiza on 3/10/15.
//  Copyright (c) 2015 Hernán Beiza. All rights reserved.
//

#ifndef LosQuiltros_Macros_h
#define LosQuiltros_Macros_h

#define DebugStatus 1  // {1: YES, otro valor NO }

#ifdef DebugStatus

#if DebugStatus == 1

#define DBLog(fmt,...) NSLog(@"\n <%@ - %@> %@",[self class], NSStringFromSelector(_cmd),[NSString stringWithFormat:(fmt), ##__VA_ARGS__]);

#else

#define DBLog(...)

#endif

#else

#define DBLog(...)

#endif


#endif
