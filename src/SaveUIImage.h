//
//  SaveUIImage.h
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/04/29.
//
//

#import <Foundation/Foundation.h>
#include "testApp.h"

@interface SaveUIImage : NSObject{
     testApp *myApp;
     UIImage * _img;
}

-(void)saveImage:(UIImage*)img;

@end
