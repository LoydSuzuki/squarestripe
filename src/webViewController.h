//
//  webViewController.h
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/05/19.
//
//

#import <UIKit/UIKit.h>
#include "testApp.h"

@interface webViewController : UIViewController{
    testApp *myApp;
    IBOutlet UIWebView *myWebView;
}
- (void)closeViewer;
- (void)test;

//change0520
//@property (retain, nonatomic) IBOutlet UIWebView *myWebView;


@end
