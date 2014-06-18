//
//  webViewController.m
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/05/19.
//
//

#import "webViewController.h"

@implementation webViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if(screenSize.size.height == 568){
        nibNameOrNil = @"webViewController_4_0";
    }
    else{
        nibNameOrNil = @"webViewController_other";
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
    //キャッシュ容量を0に
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myApp = (testApp*)ofGetAppPtr();
    // Stringオブジェクトをつくります
    NSString* urlString = @"http://google.com/";
    // これを使って、URLオブジェクトをつくります
    NSURL* googleURL = [NSURL URLWithString: urlString];
    // さらにこれを使って、Requestオブジェクトをつくります
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: googleURL];
    // これを、myFirstWebViewのloadRequestメソッドに渡します
    [self->myWebView loadRequest:myRequest];
    
    
    // キャッシュを削除する。
   // [[NSURLCache sharedURLCache] removeAllCachedResponses];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeViewer{
    
}

-(void)test{
    
    //リロード
    [myWebView reload];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
     self->myWebView.delegate = nil;
}

- (void)dealloc{
    
    [myWebView release];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super dealloc];
}

- (void)viewDidUnload {
//    [self setMyWebView:nil];
    [myWebView release];
    myWebView = nil;
    [super viewDidUnload];
}

@end
