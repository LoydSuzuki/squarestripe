#pragma once

#import <Foundation/Foundation.h>
#import <Social/Social.h>

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

#define LOGO_PAGE 1
#define START_PAGE 2
#define SHOOT_PAGE 3
#define VIEW_CHECK_PAGE 4
#define SAVE_PAGE 5
#define THUMBNAIL_PAGE 6
#define SELECT_PAGE 7
#define VIEW_PAGE 8
#define WEB_PAGE 9

class testApp : public ofxiOSApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
	
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
        bool touchCheck(int x,int y,int w,int h);
        bool  moveCheck(int x,int y,int w,int h);
        UIImage * UIImageFromOFImage(ofImage & img);
        void saveUIImageToRoll(UIImage & img);
    
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
        /*void ofxiOSScreenGrab(id delegate) {
            CGRect rect = [[UIScreen mainScreen] bounds];
            int width = rect.size.width*2; //CHA-CHA-CHA-CHANGESSS
            int height =  rect.size.height*2; //CHA-CHA-CHA-CHANGESSS
            NSInteger myDataLength = width * height * 4;
        }*/
    
        
    ofVideoGrabber ivGrabber;
    ofxiOSImagePicker camera;
    ofImage image_for_save;
    unsigned char *    videoChar;
    ofPixels           videoPixels;
    ofImage            videoImage;
    ofImage            videoImagePre;
    ofTexture          videoTexture;
    float              camWidth;
    float              camHeight;
    float              size_m;
    
    ofPoint pos;
    ofPoint after_pos;
    ofPoint before_pos;
    ofPoint touch_point;
    ofPoint touch_move;
    ofPoint stripe_img_pos;
    ofPoint d_stripe_img_pos;
    
    ofPoint cam_pos;
    
    int photo_margin;
    int thum_margin;
    int thum_width;
    
    ofImage camera_button;
    ofPoint camera_button_p;
    ofImage camera_bar;
    ofPoint camera_bar_p;
    
    ofImage back_button;
    ofImage shoot_jump_button;
    ofImage save_bar;
    ofImage instagram_bar;
    ofImage thumb_jump_button;
    ofImage mix_bar;
    ofImage filter_off_button;
    ofImage filter_on_button;
    ofImage save_jump_button;
    ofImage edit_button;
    ofImage edit_button_black;
    ofImage done_saving;
    ofImage x_btn;
    ofImage photolib_btn;
    ofImage mixcan_header;
    
    ofImage contrast;
    ofImage brightness;
    
    ofImage instagram_test;
    
    //ofImage library_bar;
    //ofImage make_bar;
    ofImage make_btn;
    ofImage library_btn;
    ofImage timeline_btn;
    ofImage home_btn;
    ofImage mixcan_logo;
    ofImage blank_photos;
    
    ofImage info;
    
    int shoot_num;
    
    ofImage stock_image[6];
    ofImage stripe_image;
    ofImage photo_btn[5];
    
    UIImage *image;
    UIWebView * myWebView;
    
    int thr;
    int bri;
    ofPixels img_px[7];
    ofPixels img_px_edit[7];
    ofTexture img_tx;
    ofTexture stripe_image_tx;
    ofPixels save_image_px[21];
    ofImage save_image[21];
    ofImage select_image;
    int select_number;
    bool stripe_image_flg;
    bool library_btn_touch;
    float slice_height;
    float square_width;
    int flames;
    
    bool flg;
    
    ofPoint touchLoc[6];
    int touch_num;
    int touch_y;
    
    int slide_y;
    int slide_span_y;
    
    int page;//ページの種類を指定
    bool back_flg;//「もどる」ボタンが押されたときのフラグ
    bool filter_flg;
    bool mix_btn_flg;
    bool shoot_btn_flg[5];
    bool save_flg;
    bool instagram_flg;
    bool camera_button_flg;
    bool slide_flg;
    
    bool save_page_flg;
    
    bool conbri_flg;
    bool home_flg;
    
    bool shoot_flg;
    bool move_flg;
    
    bool photo_flg[5];
    bool photo_past_flg[5];
    
    int photo_switch_x[5];
    
    int el_dx[5];
    int el_x[5];
    
};


