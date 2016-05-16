//
//  UIImage+Ext.h
//  Steward
//
//  Created by Jerry on 15/8/13.
//  Copyright (c) 2015年 ChengpinKuaipai. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 视频每一帧缓存目录 */
#define LLVideoImages [LLCustomCachesPath stringByAppendingPathComponent:@"videosImage"]
/** 截取七牛视频URL中的文件名 */
#define LLSubStringQiniu(imgUrlString) [imgUrlString substringFromIndex:[imgUrlString rangeOfString:@"http://aivideos.qiniudn.com/"].length]

#define LLCachesPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"]

#define LLCustomCachesPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"3ikids"]

typedef enum : NSUInteger {
    UIImageGrayLevelTypeHalfGray    = 0,
    UIImageGrayLevelTypeGrayLevel   = 1,
    UIImageGrayLevelTypeDarkBrown   = 2,
    UIImageGrayLevelTypeInverse     = 3
} UIImageGrayLevelType;

@interface UIImage (Ext)

- (UIImage *)fixOrientation;
/**
 *  图片旋转
 *
 
 */
- (UIImage *)normalizedImage;
/**
 *  空心圆
 
 */
+(UIImage*)roundRect:(CGRect)rect;
/**
 *  实心圆
 
 */
+(UIImage*)trueRound:(CGRect)Rect;
/**
 *  创建一个三角
 *
 *
 */
+(UIImage*)triangle:(CGRect)rect;



/**
 *  图片选中时的小图标
 *
 */
+(UIImage*)seletedUIImageSize:(CGSize)size;
/**
 *  未选中时的小图标
 *
 
 */
+(UIImage*)NOSeletedUIImageSzie:(CGSize)size;
/**
 *  通讯录选中的图片
 *
 *  @return
 */
+(UIImage*)selectImageRect:(CGRect)rect;
/**
 *  通讯录取消选中图片
 *
 
 */
+(UIImage*)cancelSelectImage:(CGRect)rect;
/**
 *  创建纯色的图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (instancetype)imageWithColor:(UIColor *)color withSize:(CGSize)size;

/**
 *  获取拉伸不变形的图片
 */
+ (UIImage *)middleStretchableImageWithKey:(NSString *)key;

/**
 *  根据图片名称创建图片
 */
+ (UIImage*)imageContentFileWithName:(NSString*)imageName;

/**
 *  根据mainbundle路径中的图片名称创建图片
 *
 *  @param imageName 图片名称
 *  @param type      图片类型
 *
 *  @return 图片
 */
+ (UIImage*)imageContentFileWithName:(NSString*)imageName ofType:(NSString*)type;
/**
 *  @2x
 */
+ (UIImage *)imageWithData2:(NSData *)data scale:(CGFloat)scale;

/**
 *  根据size缩放图片
 *
 *  @param image   原始图片
 *  @param newSize 缩放尺寸
 *
 *  @return 图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

/**
 *  根据rect剪切图片
 *
 *  @param image   原始图片
 *  @param newRect rect
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage*)image cutToRect:(CGRect)newRect;

/**
 *  等比例缩放图片
 *
 *  @param image   原始图片
 *  @param newSize 缩放尺寸
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage *)image ratioToSize:(CGSize)newSize;

/**
 *  按最短边 等比压缩
 *
 *  @param image   原始图片
 *  @param newSize 缩放尺寸
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize;

/**
 *  添加圆角
 *
 *  @param image 原始图片
 *  @param size  圆角大小
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage*)image roundRect:(CGSize)size;


/**
 *  根据色值改变图片的暗度
 *
 *  @param image     原始图片
 *  @param darkValue 色值 变暗多少 0.0 - 1.0
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage*)image darkValue:(float)darkValue;

/**
 *  根据灰度级别改变图片的灰度
 *
 *  @param image 原始图片
 *  @param type  图片处理 0 半灰色  1 灰度   2 深棕色    3 反色
 *
 *  @return 图片
 */
+ (UIImage*)imageWithImage:(UIImage*)image grayLevelType:(UIImageGrayLevelType)type;

/**
 *  设置图片透明度
 *
 *  @param alpha 透明度
 *  @param image 传入处理图片
 *
 *  @return 图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 *  根据颜色返回图片
 *
 *  @param color 图片颜色
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
/**
 *  获取网络图片的Size,先通过文件头来获取图片大小,支持文件头大小的格式:jpg\gif\png)。
 *
 *  @param imageURL 图片的网络地址
 *
 *  @return size
 */
+ (CGSize)downloadImageSizeWithURL:(id)imageURL;

/**
 *  保存图片
 *
 *  @param image     图片
 *  @param imageName 图片名
 */
+ (void)saveImage:(UIImage *)image withName:(NSString *)imageName;

/**
 *  读取视频第一帧图片
 *
 *  @param imageName 图片名
 *
 *  @return UIImage
 */
+ (UIImage *)readImage:(NSString *)imageName;

/**
 *  取出视频第一毫秒的图片
 *
 *  @param videoURL 视频地址
 *  @param time     毫秒
 *
 *  @return <#return value description#>
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

//加模糊效果，image是图片，blur是模糊度
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

- (UIImage*)gaussBlur:(CGFloat)blurLevel andImage:(UIImage*)originImage;

+ (instancetype)resizableImageWithName:(NSString *)imageNmae;
+ (instancetype)resizableImageWithName:(NSString *)imageNmae leftRatio:(CGFloat)leftRatio topRatio:(CGFloat)topRatio;

@end
