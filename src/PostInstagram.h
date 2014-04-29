//
//  PostInstagram.h
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/04/25.
//
//

#import <Foundation/Foundation.h>

#include "testApp.h"

@interface PostInstagram : UIViewController <UIDocumentInteractionControllerDelegate>
{
    testApp *myApp;
    UIDocumentInteractionController *interactionCotroller;
}

+ (BOOL)canInstagramOpen;
- (void)setImage:(UIImage *)image;

@property (nonatomic,retain) UIDocumentInteractionController *interactionController;

@end