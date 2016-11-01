//  
//  Copyright (c) 2014 Mobile Warsaw All rights reserved.
//  


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageResizer : NSObject
- (UIImage *)resizeImage:(UIImage *)image toBoundBothDimensionsTo:(CGFloat)maxImageDimension;
@end
