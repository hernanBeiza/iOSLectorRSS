//
//  UIDevice+Hardware.m
//  Doggis
//
//  Created by Hernán Beiza on 10/4/13.
//  Copyright (c) 2013 Geofaro. All rights reserved.
//

#import "UIDevice+Hardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (Hardware)

/*
 Platforms
 iPhone1,1 -> iPhone 1G
 iPhone1,2 -> iPhone 3G
 iPod1,1   -> iPod touch 1G
 iPod2,1   -> iPod touch 2G
 */
/*
 @"i386"      on the simulator
 @"iPod1,1"   on iPod Touch
 @"iPod2,1"   on iPod Touch Second Generation
 @"iPod3,1"   on iPod Touch Third Generation
 @"iPod4,1"   on iPod Touch Fourth Generation
 @"iPhone1,1" on iPhone
 @"iPhone1,2" on iPhone 3G
 @"iPhone2,1" on iPhone 3GS
 @"iPad1,1"   on iPad
 @"iPad2,1"   on iPad 2
 @"iPad3,1"   on iPad 3 (aka new iPad)
 @"iPhone3,1" on iPhone 4
 @"iPhone4,1" on iPhone 4S
 @"iPhone5,1" on iPhone 5
 @"iPhone5,2" on iPhone 5
 @"iPhone5,3" on iPhone 5c (GSM)
 @"iPhone5,4" on iPhone 5c
 @"iPhone6,1" on iPhone 5s
 @"iPhone6,2" on iPhone 5s
 @"iPhone7,2" on iPhone 6
 @"iPhone7,1" on iPhone 6 Plus
*/
/*
 if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
 if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
 if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
 if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
 if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
 if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
 if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
 if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
 if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
 if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
 if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
 if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
 if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
 if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
 if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
 if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
 if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
 if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
 if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
 if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
 if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
 if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
 if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
 if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
 if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
 if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
 if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
 if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
 if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
 if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
 if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
 if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
 if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
 if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
 if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
 if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
 if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
 if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
 if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
 if ([platform isEqualToString:@"i386"])         return @"Simulator";
 if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
 return platform;
 */

- (NSString *) platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

@end