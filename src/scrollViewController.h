//
//  scrollViewController.h
//  emptyExample
//
//  Created by Tatsuhiko Suzuki on 2014/05/29.
//
//

#import <UIKit/UIKit.h>

@interface scrollViewController : UIViewController<UIScrollViewDelegate>{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIButton *backBtn;
    int pageNumber;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;
@property (retain, nonatomic) IBOutlet UIButton *backBtn;
@property (assign, nonatomic) int pageNumber;

- (IBAction)changePage:(id)sender;
- (IBAction)backToMenu:(id)sender;

@end
