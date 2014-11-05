//
//  scrollViewController.m
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/05/29.
//
//

#import "scrollViewController.h"

@interface scrollViewController ()

@end

@implementation scrollViewController

@synthesize scrollView;
@synthesize pageControl;
@synthesize backBtn;
@synthesize pageNumber;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    pageNumber = 0;
    
    CGRect screenSize = [UIScreen mainScreen].bounds;
    if(screenSize.size.height == 568){
        nibNameOrNil = @"scrollViewController_4_0";
    }
    else{
        nibNameOrNil = @"scrollViewController_3_5";
    }
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.userInteractionEnabled = YES;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(1600, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    
    scrollView.delegate = self;
    
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageNumber = 0;

    
    CGRect screenSize = [UIScreen mainScreen].bounds;
    //iPhone5の場合
    if(screenSize.size.height == 568){

        CGRect rect = CGRectMake(0,0,1600,568);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        imageView.image = [UIImage imageNamed:@"img/tutorial_3200_1136.png"];
        
        // UIScrollViewのインスタンスに画像を貼付ける
        [scrollView addSubview:imageView];
        
        // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
        scrollView.contentSize = imageView.bounds.size;
        
    }
    //その他
    else{
        
        CGRect rect = CGRectMake(0,0,1600,480);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        imageView.image =[UIImage imageNamed:@"img/tutorial_3200_960.png"];
        
        // UIScrollViewのインスタンスに画像を貼付ける
        [scrollView addSubview:imageView];
        
        // UIScrollViewのコンテンツサイズを画像のサイズに合わせる
        scrollView.contentSize = imageView.bounds.size;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [scrollView release];
    [pageControl release];
    [backBtn release];
    [super dealloc];
}

- (IBAction)changePage:(id)sender {
    NSLog(@"paging");
    
    pageNumber +=1;
    if(pageNumber > 4){
        pageNumber = 0;
    }
    
    pageControl.currentPage = pageNumber;
    
    [scrollView setContentOffset:CGPointMake(320*pageControl.currentPage,0) animated:YES];
    
    NSLog(@"page %d",pageControl.currentPage);
}

- (IBAction)backToMenu:(id)sender {
    NSLog(@"back to menu");
    pageControl.currentPage = 0;
    pageNumber = 0;
    [scrollView setContentOffset:CGPointMake(320*pageControl.currentPage,0) animated:YES];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

#pragma mark - View change flick
    
- (void)scrollViewDidScroll:(UIScrollView *)sender {
        NSLog(@"swipe %f, %f" ,scrollView.contentOffset.x, scrollView.frame.size.width);
        CGFloat pageWidth = scrollView.frame.size.width;
        pageControl.currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
}

- (void)viewDidUnload {
    [scrollView release];
    scrollView = nil;
    [pageControl release];
    pageControl = nil;
    [self setScrollView:nil];
    [self setPageControl:nil];
    [backBtn release];
    backBtn = nil;
    [self setBackBtn:nil];
    [super viewDidUnload];
}

@end
