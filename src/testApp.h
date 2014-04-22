#pragma once

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
    ofImage image_for_save;
    unsigned char *    videoChar;
    ofPixels           videoPixels;
    ofImage            videoImage;
    ofTexture          videoTexture;
    float              camWidth;
    float              camHeight;
    float              size_m;
    
    ofPoint pos;
    ofPoint after_pos;
    ofPoint before_pos;
    ofPoint touch_point;
    int photo_margin;
    int thum_margin;
    int thum_width;
    
    ofImage stock_image[6];
    ofImage stripe_image;
    ofImage photo_btn[5];
    int thr;
    ofPixels img_px[7];
    ofPixels img_px_edit[7];
    ofTexture img_tx;
    ofTexture stripe_image_tx;
    ofPixels save_image_px[21];
    ofImage save_image[21];
    ofImage select_image;
    int select_number;
    bool stripe_image_flg;
    float slice_height;
    float square_width;
    int flames;
    
    bool flg;
    
    ofPoint touchLoc[6];
    int touch_num;
    int touch_y;
    
    int page;//ページの種類を指定
    bool back_flg;//「もどる」ボタンが押されたときのフラグ
    bool filter_flg;
    bool mix_btn_flg;
    bool shoot_btn_flg[5];
    bool save_flg;
    
};


