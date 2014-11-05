#import <Foundation/Foundation.h>
#import <Social/Social.h>

#include "testApp.h"

@interface DCSocial : NSObject

#pragma mark - public method
+ (void)postToFacebook:(id)delegate text:(NSString *)text imageName:(NSString *)imageName url:(NSString *)url;
+ (void)postToTwitter:(id)delegate text:(NSString *)text imageName:(NSString *)imageName url:(NSString *)url;
+ (void)postToLine:(NSString *)imageName;
+ (void)socialShare:(id)delegate shareText:(NSString *)shareText shareImage:(UIImage *)shareImage;

@end