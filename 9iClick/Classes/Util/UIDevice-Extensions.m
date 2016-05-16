//
//  UIDevice-Extensions.m
//  the9edu-uidevice
//
//  Created by 九城培训中心 on 11-6-15.
//  Copyright 2011 the9. All rights reserved.
//

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import "UIDevice-Extensions.h"



@implementation UIDevice (Hardware)

#pragma mark sysctlbyname utils
- (NSString *) getSysInfoByName:(char *)typeSpecifier
{
	size_t size;
    
	sysctlbyname(typeSpecifier, NULL, &size, NULL, 0);
    char answer[size];
	
	sysctlbyname(typeSpecifier, answer, &size, NULL, 0);
	NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
	
	return results;
}


- (NSString *) platform
{
//	return [self getSysInfoByName:"hw.machine"];
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6S Plus";

    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


- (NSString *) hwmodel
{
	return [self getSysInfoByName:"hw.model"];
}


#pragma mark sysctl utils
- (NSUInteger) getSysInfo: (uint) typeSpecifier
{
	size_t size = sizeof(int);
	int results;
	int mib[2] = {CTL_HW, typeSpecifier};
	sysctl(mib, 2, &results, &size, NULL, 0);
	return (NSUInteger) results;
}


- (NSUInteger) cpuFrequency
{
	return [self getSysInfo:HW_CPU_FREQ];
}


- (NSUInteger) busFrequency
{
	return [self getSysInfo:HW_BUS_FREQ];
}

- (NSUInteger) totalMemory
{
	return [self getSysInfo:HW_PHYSMEM];
}


- (NSUInteger) userMemory
{
	return [self getSysInfo:HW_USERMEM];
}


- (NSUInteger) maxSocketBufferSize
{
	return [self getSysInfo:KIPC_MAXSOCKBUF];
}



#pragma mark file system
- (NSNumber *) totalDiskSpace
{
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemSize];
}


- (NSNumber *) freeDiskSpace
{
	NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
	return [fattributes objectForKey:NSFileSystemFreeSize];
}


static const char* device_string_names[UIDeviceMAX] = 
{
	"Unknown iOS device",
	
	"iPhone Simulator",
	"iPhone Simulator",
	"iPad Simulator",
	
	"iPhone 1G",
	"iPhone 3G",
	"iPhone 3GS",
	"iPhone 4",
	"iPhone 5",
	
	"iPod touch 1G",
	"iPod touch 2G",
	"iPod touch 3G",
	"iPod touch 4G",
	
	"iPad 1G",
	"iPad 2G",
	
	"Unknown iPhone",
	"Unknown iPod",
	"Unknown iPad",
	"iFPGA",
};


#pragma mark platform type and name utils
- (NSUInteger) platformType
{
	NSString *platform = [self platform];
	
	// if ([platform isEqualToString:@"XX"])			
	//	return UIDeviceUnknown;
	
	if ([platform isEqualToString:@"iFPGA"])		
		return UIDeviceIFPGA;
	
	if ([platform isEqualToString:@"iPhone1,1"])	
		return UIDevice1GiPhone;
	
	if ([platform isEqualToString:@"iPhone1,2"])	
		return UIDevice3GiPhone;
	
	if ([platform hasPrefix:@"iPhone2"])	
		return UIDevice3GSiPhone;
	
	if ([platform hasPrefix:@"iPhone3"])			
		return UIDevice4iPhone;
	
	if ([platform hasPrefix:@"iPhone4"])			
		return UIDevice5iPhone;
	
	if ([platform isEqualToString:@"iPod1,1"])   
		return UIDevice1GiPod;
	
	if ([platform isEqualToString:@"iPod2,1"])   
		return UIDevice2GiPod;
	
	if ([platform isEqualToString:@"iPod3,1"])   
		return UIDevice3GiPod;
	
	if ([platform isEqualToString:@"iPod4,1"])   
		return UIDevice4GiPod;
	
	if ([platform isEqualToString:@"iPad1,1"])   
		return UIDevice1GiPad;
	
	if ([platform isEqualToString:@"iPad2,1"])   
		return UIDevice2GiPad;
	
	// MISSING A SOLUTION HERE TO DATE TO DIFFERENTIATE iPAD and iPAD 3G.
	
	if ([platform hasPrefix:@"iPhone"]) 
		return UIDeviceUnknowniPhone;
	
	if ([platform hasPrefix:@"iPod"]) 
		return UIDeviceUnknowniPod;
	
	if ([platform hasPrefix:@"iPad"]) 
		return UIDeviceUnknowniPad;
	
	if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
	{
		if ([[UIScreen mainScreen] bounds].size.width < 768)
			return UIDeviceiPhoneSimulatoriPhone;
		else 
			return UIDeviceiPhoneSimulatoriPad;
		
		return UIDeviceiPhoneSimulator;
	}
	return UIDeviceUnknown;
}


- (NSString *) platformString
{
	NSUInteger type = [self platformType];
	return [NSString stringWithUTF8String:device_string_names[type]];
}


#pragma mark MAC addy
// Return the local MAC addy
- (NSString *) macaddress
{
	int					mib[6];
	size_t				len;
	char				*buf;
	unsigned char		*ptr;
	struct if_msghdr	*ifm;
	struct sockaddr_dl	*sdl;
	
	mib[0] = CTL_NET;
	mib[1] = AF_ROUTE;
	mib[2] = 0;
	mib[3] = AF_LINK;
	mib[4] = NET_RT_IFLIST;
	
	if ((mib[5] = if_nametoindex("en0")) == 0)
	{
		printf("Error: if_nametoindex error\n");
		return NULL;
	}
	
	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0)
	{
		printf("Error: sysctl, take 1\n");
		return NULL;
	}
	
	if ((buf = malloc(len)) == NULL) 
	{
		printf("Could not allocate memory. error!\n");
		return NULL;
	}
	
	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) 
	{
		printf("Error: sysctl, take 2");
		return NULL;
	}
	
	ifm = (struct if_msghdr *)buf;
	sdl = (struct sockaddr_dl *)(ifm + 1);
	ptr = (unsigned char *)LLADDR(sdl);
	// NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
	free(buf);
	return [outstring uppercaseString];
}


- (NSString *) platformCode
{
	switch ([self platformType])
	{
		case UIDevice1GiPhone: 
			return @"M68";
		case UIDevice3GiPhone: 
			return @"N82";
		case UIDevice3GSiPhone:	
			return @"N88";
		case UIDevice4iPhone: 
			return @"N89";
		case UIDevice5iPhone: 
			return @"Unknown iPhone";
		case UIDeviceUnknowniPhone: 
			return @"Unknown iPhone";
		case UIDevice1GiPod: 
			return @"N45";
		case UIDevice2GiPod: 
			return @"N72";
		case UIDevice3GiPod:
			return @"N18"; 
		case UIDevice4GiPod: 
			return @"N80";
		case UIDeviceUnknowniPod: 
			return @"Unknown iPod";
		case UIDevice1GiPad: 
			return @"K48";
		case UIDevice2GiPad: 
			return @"Unknown iPad";
		case UIDeviceUnknowniPad: 
			return @"Unknown iPad";
		case UIDeviceiPhoneSimulator: 
			return @"iPhone Simulator";
		default: 
			return @"Unknown iOS device";
	}
}


@end

