//
//  SaveUIImage.m
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/04/29.
//
//

#import "SaveUIImage.h"

@implementation SaveUIImage
-(void)saveImage:(UIImage*)img
{
    _img = img;
    UIImageWriteToSavedPhotosAlbum(_img, self, @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:), nil);
}
-(void)viewDidLoad
{
    // 追加
    myApp = (testApp*)ofGetAppPtr();
}

- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo
{
    NSLog(@"ここでインジケータでもだそうか！");
    
    if(_error){//エラーのとき
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"画像の保存に失敗しました。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil
                              ];
        
        [alert show];
        [alert release];
        
    }else{//保存できたとき
        return;
    }
}


@end
