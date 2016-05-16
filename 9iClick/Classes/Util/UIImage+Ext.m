//
//  UIImage+Ext.m
//  Steward
//
//  Created by Jerry on 15/8/13.
//  Copyright (c) 2015年 ChengpinKuaipai. All rights reserved.
//

#import "UIImage+Ext.h"
#import <Accelerate/Accelerate.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>

@implementation UIImage (Ext)
- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
- (UIImage *)normalizedImage {
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}
+(UIImage*)roundRect:(CGRect)rect;
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ref, [UIColor lightGrayColor].CGColor);
    CGContextAddEllipseInRect(ref, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2));
    CGContextSetFillColorWithColor(ref, [UIColor blackColor].CGColor);
    CGContextStrokePath(ref);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
+(UIImage*)trueRound:(CGRect)rect;
{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref=UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(ref, [UIColor lightGrayColor].CGColor);
    CGContextAddEllipseInRect(ref, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2));
    CGContextSetFillColorWithColor(ref, [UIColor blackColor].CGColor);
    CGContextStrokePath(ref);
    CGContextAddEllipseInRect(ref, CGRectMake(3, 3, rect.size.width-6, rect.size.height-6));
    CGContextSetRGBFillColor(ref, 103/255.0, 203/255.0, 250/255.0, 1);
    CGContextFillPath(ref);
    
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
    
    
    
}



+(UIImage*)seletedUIImageSize:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctf, CGRectMake(0, 0, size.width, size.height));
    CGContextSetRGBFillColor(ctf, 103/255.0, 203/255.0, 250/255.0, 1);
    CGContextFillPath(ctf);
    CGContextSetStrokeColorWithColor(ctf, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(ctf, 2, size.height/2+2);
    CGContextAddLineToPoint(ctf, size.width/2, size.height-5);
    CGContextAddLineToPoint(ctf, size.width-4, 5);
    CGContextSetLineWidth(ctf, 2);
    
    CGContextStrokePath(ctf);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
+(UIImage*)NOSeletedUIImageSzie:(CGSize)size;
{
    UIGraphicsBeginImageContext(size);
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctf, CGRectMake(0, 0, size.width, size.height));
    CGContextSetRGBFillColor(ctf, 247/255.0, 247/255.0, 247/255.0, 0.6);
    CGContextFillPath(ctf);
    CGContextSetStrokeColorWithColor(ctf, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(ctf, 2, size.height/2+2);
    CGContextAddLineToPoint(ctf, size.width/2, size.height-5);
    CGContextAddLineToPoint(ctf, size.width-4, 5);
    CGContextSetLineWidth(ctf, 2);
    CGContextStrokePath(ctf);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}
+(UIImage*)triangle:(CGRect)rect;
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctf, rect.size.width/2.0, 0);
    CGContextAddLineToPoint(ctf, 0, rect.size.height);
    CGContextAddLineToPoint(ctf, rect.size.width, rect.size.height);
    CGContextClosePath(ctf);
    CGContextSetRGBFillColor(ctf, 103/255.0, 203/255.0, 250/255.0, 1);
    CGContextFillPath(ctf);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(UIImage*)selectImageRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextAddRect(ctf, rect);
    CGContextSetStrokeColorWithColor(ctf, [UIColor lightGrayColor].CGColor);
    CGContextSetFillColorWithColor(ctf, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(ctf, 3);
    CGContextStrokePath(ctf);
    //CGContextSetRGBStrokeColor(ctf, 148, 182, 160, 1);
    CGContextSetStrokeColorWithColor(ctf, [UIColor colorWithRed:148.0/255.0f green:182/255.0f blue:72/255.0f alpha:1].CGColor);
    CGContextMoveToPoint(ctf, 2, rect.size.height/2+2);
    CGContextAddLineToPoint(ctf, rect.size.width/2, rect.size.height-5);
    CGContextAddLineToPoint(ctf, rect.size.width-4, 5);
    CGContextSetLineWidth(ctf, 3);
    CGContextStrokePath(ctf);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(UIImage*)cancelSelectImage:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextAddRect(ctf, rect);
    CGContextSetFillColorWithColor(ctf, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(ctf, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(ctf, 3);
    CGContextStrokePath(ctf);
    UIImage*image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    
}

/** 根据传入参数的颜色创建相应颜色的图片 */
+ (instancetype)imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [color set];
    UIRectFill((CGRect){{0, 0}, size});
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

/** 获取拉伸不变形的图片 */
+ (UIImage *)middleStretchableImageWithKey:(NSString *)key {
    UIImage *image = [UIImage imageNamed:key];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}

/** 根据图片名称创建图片 */
+ (UIImage *)imageContentFileWithName:(NSString *)imageName
{
    NSString* type = @"png";
    if(1)
    {
        type = [imageName pathExtension];
        imageName = [imageName stringByDeletingPathExtension];
    }
    
    return [self imageContentFileWithName:imageName ofType:type];
}

/** 根据mainbundle路径中的图片名称创建图片 */
+ (UIImage *)imageContentFileWithName:(NSString *)imageName ofType:(NSString *)type
{
    if([UIScreen mainScreen].scale>=2)
    {
        if(![imageName hasSuffix:@"@2x"])
        {
            imageName = [imageName stringByAppendingString:@"@2x"];
        }
        NSData *imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:type]];
        
        return [UIImage imageWithData2:imageData scale:2];
    }
    else{
        
        return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:type]];
    }
}

+ (UIImage *)imageWithData2:(NSData *)data scale:(CGFloat)scale
{
    if (!iOS7) {
        return [UIImage imageWithData:data scale:scale];
    }
    return [UIImage imageWithCGImage:[UIImage imageWithData:data].CGImage scale:scale orientation:UIImageOrientationUp];
}

/** 根据size缩放图片 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 根据rect缩放图片 */
+ (UIImage *)imageWithImage:(UIImage *)image cutToRect:(CGRect)newRect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, newRect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    
    return smallImage;
}

/** 等比例缩放图片 */
+ (UIImage *)imageWithImage:(UIImage *)image ratioToSize:(CGSize)newSize
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    float verticalRadio = newSize.height/height;
    float horizontalRadio = newSize.width/width;
    float radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    width = width*radio;
    height = height*radio;
    
    return [self imageWithImage:image scaledToSize:CGSizeMake(width,height)];
}

/** 按最短边等比压缩 */
+ (UIImage *)imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize
{
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    if(width < newSize.width && height < newSize.height)
    {
        return image;
    }
    else
    {
        return [self imageWithImage:image ratioToSize:newSize];
    }
}

/** 添加圆角 */
+ (UIImage *)imageWithImage:(UIImage *)image roundRect:(CGSize)size
{
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, (uint32_t)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, 5, 5);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage* image2 =  [UIImage imageWithCGImage:imageMasked];
    CGContextRelease(context);
    CGImageRelease(imageMasked);
    CGColorSpaceRelease(colorSpace);
    return image2;
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw,fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);                // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);   // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);     // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);      // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);    // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

/** 根据色值改变图片的暗度 */
+ (UIImage *)imageWithImage:(UIImage *)image darkValue:(float)darkValue
{
    return [UIImage imageWithImage:image pixelOperationBlock:^(UInt8 *redRef, UInt8 *greenRef, UInt8 *blueRef) {
        *redRef = *redRef * darkValue;
        *greenRef = *greenRef * darkValue;
        *blueRef = *blueRef * darkValue;
    }];
}

+ (UIImage *)imageWithImage:(UIImage *)image pixelOperationBlock:(void(^)(UInt8 *redRef, UInt8 *greenRef, UInt8 *blueRef))block
{
    if(block == nil)
        return image;
    
    CGImageRef  imageRef = image.CGImage;
    if(imageRef == NULL)
        return nil;
    
    size_t width  = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef   data = CGDataProviderCopyData(dataProvider);
    UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
    NSUInteger  x, y;
    for (y = 0; y < height; y++) {
        for (x = 0; x < width; x++) {
            UInt8*  tmp;
            tmp = buffer + y * bytesPerRow + x * 4;
            
            UInt8 red,green,blue;
            red = *(tmp + 0);
            green = *(tmp + 1);
            blue = *(tmp + 2);
            
            block(&red,&green,&blue);
            
            *(tmp + 0) = red;
            *(tmp + 1) = green;
            *(tmp + 2) = blue;
        }
    }
    
    CFDataRef   effectedData;
    effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
    CGDataProviderRef   effectedDataProvider;
    effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
    CGImageRef  effectedCgImage;
    UIImage*    effectedImage;
    effectedCgImage = CGImageCreate(
                                    width, height,
                                    bitsPerComponent, bitsPerPixel, bytesPerRow,
                                    colorSpace, bitmapInfo, effectedDataProvider,
                                    NULL, shouldInterpolate, intent);
    effectedImage = [UIImage imageWithCGImage:effectedCgImage];
    
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    
    return effectedImage;
}

/** 根据灰度级别改变图片的灰度 */
+ (UIImage *)imageWithImage:(UIImage *)image grayLevelType:(UIImageGrayLevelType)type{
    return [UIImage imageWithImage:image pixelOperationBlock:^(UInt8 *redRef, UInt8 *greenRef, UInt8 *blueRef) {
        
        UInt8 red = * redRef , green = * greenRef , blue = * blueRef;
        switch (type) {
            case 0:
                *redRef = red * 0.5;
                *greenRef = green * 0.5;
                *blueRef = blue * 0.5;
                break;
            case 1:
            {
                UInt8 brightness = (77 * red + 28 * green + 151 * blue) / 256;
                *redRef = brightness;
                *greenRef = brightness;
                *blueRef = brightness;
            }
                break;
            case 2:
                *redRef = red;
                *greenRef = green * 0.7;
                *blueRef = blue * 0.4;
                break;
                
            case 3:
                *redRef = 255 - red;
                *greenRef = 255 - green;
                *blueRef = 255 - blue;
                break;
        }
    }];
}

/** 获取网络图片的大小 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [self downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}

//讨厌警告
-(id)diskImageDataBySearchingAllPathsForKey:(id)key{return nil;}

// PNG
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

// GIF得到的是第一张图片的大小
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}

// JPG
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur
{
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (UIImage*)gaussBlur:(CGFloat)blurLevel andImage:(UIImage*)originImage

{
    
    blurLevel = MIN(1.0,MAX(0.0, blurLevel));
    
    //int boxSize = (int)(blurLevel * 0.1 * MIN(self.size.width, self.size.height));
    
    int boxSize = 20;//模糊度。
    
    boxSize = boxSize - (boxSize % 2) + 1;
    
    NSData *imageData = UIImageJPEGRepresentation(originImage, 1);
    UIImage *tmpImage = [UIImage imageWithData:imageData];
    CGImageRef img = tmpImage.CGImage;
    
    // 图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    // 像素缓存
    void *pixelBuffer;
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    // 宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    // 像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    NSInteger windowR = boxSize / 2;
    
    CGFloat sig2 = windowR / 3.0;
    
    if(windowR>0){ sig2 = -1/(2*sig2*sig2); }
    
    int16_t *kernel = (int16_t*)malloc(boxSize*sizeof(int16_t));
    
    int32_t  sum = 0;
    
    for(NSInteger i=0; i<boxSize; ++i){
        
        kernel[i] = 255*exp(sig2*(i-windowR)*(i-windowR));
        
        sum += kernel[i];
        
    }
    
    free(kernel);
    
    // convolution
    
    error = vImageConvolve_ARGB8888(&inBuffer, &outBuffer,NULL, 0, 0, kernel, boxSize, 1, sum, NULL, kvImageEdgeExtend);
    
    error = vImageConvolve_ARGB8888(&outBuffer, &inBuffer,NULL, 0, 0, kernel, 1, boxSize, sum, NULL, kvImageEdgeExtend);
    
    outBuffer = inBuffer;
    
    if (error) {
        
        //NSLog(@"error from convolution %ld", error);
        
    }
    
    CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             
                                             outBuffer.width,
                                             
                                             outBuffer.height,
                                             
                                             8,
                                             
                                             outBuffer.rowBytes,
                                             
                                             colorSpace,
                                             
                                             kCGBitmapAlphaInfoMask &kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef =CGBitmapContextCreateImage(ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    
    CGContextRelease(ctx);
    
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
    
}

#pragma mark - 设置图片透明度
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 根据颜色返回图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark - 保存视频第一帧图片
+ (void)saveImage:(UIImage *)image withName:(NSString *)imageName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 创建缓存目录
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *cachePath = LLVideoImages;
        if (![fileManager fileExistsAtPath:cachePath]) {
            [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:NULL];
        }
    });
    
    // 拼接文件全路径
    NSString *imageFullPath = [NSString stringWithFormat:@"%@/%@.png", LLVideoImages, LLSubStringQiniu(imageName)];
    CLog(@"缓存图片路径:%@", imageFullPath);
    
    // 保存图片到文件
    NSData *imageData = UIImagePNGRepresentation(image);
    [imageData writeToFile:imageFullPath atomically:YES];
}

#pragma mark - 读取视频第一帧图片
+ (UIImage *)readImage:(NSString *)imageName
{
    // 拼接文件全路径
    NSString *imageFullPath = [NSString stringWithFormat:@"%@/%@.png", LLVideoImages, LLSubStringQiniu(imageName)];
    CLog(@"读取缓存图片路径:%@", imageFullPath);
    
    // 读取图片文件
    UIImage *image = [UIImage imageWithContentsOfFile:imageFullPath];
    
    return image;
}

#pragma mark - 取出视频第一毫秒的图片
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&thumbnailImageGenerationError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", thumbnailImageGenerationError);
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

+ (instancetype)resizableImageWithName:(NSString *)imageNmae
{
    return [self resizableImageWithName:imageNmae leftRatio:0.5 topRatio:0.5];
}

+ (instancetype)resizableImageWithName:(NSString *)imageNmae leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio
{
    // 1.创建图片
    UIImage *image = [UIImage imageNamed:imageNmae];
    CGSize imageSize = image.size;
    // 2.设置拉伸不变形
    image = [image stretchableImageWithLeftCapWidth:imageSize.width * leftRatio topCapHeight:imageSize.height * topRatio];
    // 3.返回图片
    return image;
}

@end
