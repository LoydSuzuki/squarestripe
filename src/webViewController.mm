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
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myApp = (testApp*)ofGetAppPtr();
    // Stringオブジェクトをつくります
    NSString* urlString = @"http://scanimatecam.lomo.jp/";
    // これを使って、URLオブジェクトをつくります
    NSURL* googleURL = [NSURL URLWithString: urlString];
    // さらにこれを使って、Requestオブジェクトをつくります
    NSURLRequest* myRequest = [NSURLRequest requestWithURL: googleURL];
    // これを、myFirstWebViewのloadRequestメソッドに渡します
    [self->myWebView loadRequest:myRequest];
}

// ページ読込開始時にインジケータをくるくるさせる
-(void)webViewDidStartLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

// ページ読込完了時にインジケータを非表示にする
-(void)webViewDidFinishLoad:(UIWebView*)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeViewer{
    
}

-(void)test{
    [myWebView reload];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
     self->myWebView.delegate = nil;
}

- (void)dealloc {
    
    [myWebView release];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [super dealloc];
}

- (void)viewDidUnload {
    [self setMyWebView:nil];
    [myWebView release];
    myWebView = nil;
    [super viewDidUnload];
}

@end
