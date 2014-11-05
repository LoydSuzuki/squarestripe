//
//  PostInstagram.m
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/04/25.
//
//

#import "PostInstagram.h"

@interface PostInstagram()
- (void)closeView;
@end

@implementation PostInstagram

+ (BOOL)canInstagramOpen{
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    if ([[UIApplication sharedApplication] canOpenURL:instagramURL]) {
        return YES;
    }
    return NO;
}

- (void)openInstagram {
    
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    self.interactionController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.interactionController.UTI = @"com.instagram.exclusivegram";
    self.interactionController.delegate = self;
    self.interactionController.annotation = [NSDictionary dictionaryWithObject:@"UPLOAD FROM #mixcan_TL http://mixcan.net/" forKey:@"InstagramCaption"];
    
    BOOL present = [self.interactionController presentOpenInMenuFromRect:self.view.frame
                                                                  inView:self.view
                                                                animated:YES];
    if (!present) {
        [self closeView];
    }
}

- (void)setImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/image.igo"];
    [imageData writeToFile:filePath atomically:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self openInstagram];
}

-(void)viewDidLoad
{
    // 追加
    myApp = (testApp*)ofGetAppPtr();
}

- (void)closeView
{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
     self.interactionController.delegate = nil;
}

#pragma mark - UIDocumentInteractionControllerDelegate

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
        willBeginSendingToApplication:(NSString *)application
{
    
}

- (void)documentInteractionController:(UIDocumentInteractionController *)controller
           didEndSendingToApplication:(NSString *)application
{
    [self closeView];
}

- (void) documentInteractionControllerDidDismissOpenInMenu: (UIDocumentInteractionController *) controller
{
    // キャンセルで閉じたとき
    [self closeView];
}
@end