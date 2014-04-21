#pragma once

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"

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

        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    ofVideoGrabber ivGrabber;
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
    int photo_margin;
    
    ofImage stock_image[6];
    ofImage stripe_image;
    ofImage photo_btn[5];
    int thr;
    ofPixels img_px[7];
    ofPixels img_px_edit[7];
    ofTexture img_tx;
    ofTexture stripe_image_tx;
    bool stripe_image_flg;
    float slice_height;
    float square_width;
    int flames;
    
    bool flg;
    
    ofPoint touchLoc[6];
    int touch_num;
    int touch_y;
};


