#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    ofEnableSmoothing();
    
    ofSetOrientation(OF_ORIENTATION_90_RIGHT);//Set iOS to Orientation Landscape Right
    //ofSetFrameRate(30);
    
    camWidth =  480;
    camHeight = 360;
    square_width = 300;
    size_m = 0.8;
    photo_margin = (ofGetHeight()-square_width*2)/2;
    thr = 100;
    
    photo_btn[1].loadImage("shoot01.png");
    photo_btn[2].loadImage("shoot02.png");
    photo_btn[3].loadImage("shoot03.png");
    photo_btn[4].loadImage("shoot04.png");
    
    photo_btn[1].rotate90(1);
    photo_btn[2].rotate90(1);
    photo_btn[3].rotate90(1);
    photo_btn[4].rotate90(1);
    
    pos.x = 0+photo_margin;
    before_pos.x = photo_margin + square_width;
    after_pos.x = photo_margin - square_width;
    pos.y = after_pos.y = before_pos.y = ofGetWidth()-square_width*2-photo_margin*2;
    
    //ひとつのスライスの大きさ
    slice_height = 1;
    
    //square_width = ofGetWidth();
    flames = 4;
    ivGrabber.initGrabber(camWidth,camHeight,OF_PIXELS_BGRA);
    videoImage.allocate(camWidth,camHeight,OF_IMAGE_COLOR);
    videoPixels.allocate(camWidth,camHeight,OF_IMAGE_COLOR);
    videoTexture.allocate(square_width,square_width,GL_RGB);
    
    flg = false;
    
    for(int i=0; i<7; i++){
        img_px_edit[i].allocate(square_width,square_width,OF_IMAGE_COLOR);
        stock_image[i].allocate(square_width,square_width,OF_IMAGE_COLOR);
        stock_image[i].clear();
    }
    
    img_px_edit[0].allocate(square_width,square_width,OF_IMAGE_COLOR);
    
    touch_num = 0;
    stripe_image_flg = false;
    stripe_image_tx.allocate(square_width,square_width,GL_RGB);
}

//--------------------------------------------------------------
void testApp::update(){
    if(touch_num < 6){
    
    ivGrabber.update();
    unsigned char *cdata = ivGrabber.getPixels(),
    *idata = videoImage.getPixels();
    
    for(int k=0; k<camWidth*camHeight*3; k++){
        if(cdata[k] < thr) idata[k] = 0;
        else idata[k] = 255;
        //idata[k] = cdata[k];
    }
        
    videoImage.setImageType(OF_IMAGE_GRAYSCALE);
    videoImage.setImageType(OF_IMAGE_COLOR);
    videoPixels = videoImage;
    videoPixels.crop(camWidth/2-square_width/2,camHeight/2-square_width/2,square_width,square_width);
    
    videoTexture.loadData(videoPixels);
    
    }
    
    if(stripe_image_flg == true){
        
        for(int layer_num=1; layer_num<(square_width/slice_height); layer_num+=flames){
            for(int img_num =1; img_num<=flames; img_num++){
                
                //加工用に画像をコピー
                img_px_edit[img_num] = stock_image[img_num];
                
                //画像をスライス幅に切り取り
                img_px_edit[img_num].crop(slice_height*(layer_num+img_num),0,slice_height,square_width);
                
                //切り取った画像をペーストしてゆく
                img_px_edit[img_num].pasteInto(img_px_edit[0],slice_height*(layer_num+img_num),0);
            }
        }
        stripe_image_tx.loadData(img_px_edit[0]);
        stripe_image_flg = false;
    }
}

//--------------------------------------------------------------
void testApp::draw(){
    ofBackground(185,194,170);
    ofSetColor(255,255,255);
    if(touch_num<6){
        videoTexture.draw(pos.y,pos.x,square_width*2,square_width*2);
        
        photo_btn[1].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*0+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[2].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*1+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[3].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*2+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[4].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*3+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
    
        stock_image[1].draw(ofGetHeight()/4,ofGetHeight()/4*0,ofGetHeight()/4,ofGetHeight()/4);
        stock_image[2].draw(ofGetHeight()/4,ofGetHeight()/4*1,ofGetHeight()/4,ofGetHeight()/4);
        stock_image[3].draw(ofGetHeight()/4,ofGetHeight()/4*2,ofGetHeight()/4,ofGetHeight()/4);
        stock_image[4].draw(ofGetHeight()/4,ofGetHeight()/4*3,ofGetHeight()/4,ofGetHeight()/4);
        
        ofLine(200,20,200,700);
        ofEllipse(200,20+thr*255/700,10,10);
    }
    else if(touch_num >= 6){
        stripe_image_tx.draw(touch_y,pos.x,square_width*2,square_width*2);
        
        //フィルター
        for(int i=0; i<square_width/slice_height; i+=flames){
            ofSetColor(0,0,0);
            //ofRect(touch_y-(i*slice_height),0,slice_height*(flames-1),camHeight);
            ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
        }
    }
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    touch_y = touch.x;
    thr = touch.y*255/320;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    if(touch_num <5){
      stock_image[touch_num] = videoPixels;
        touch_num++;
    }
    else if(touch_num == 5){
        stripe_image_flg = true;
        touch_num++;
    }
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    for(int i=1; i<5; i++){
        stock_image[i].clear();
    }
    touch_num = 1;
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){

}

//--------------------------------------------------------------
void testApp::gotFocus(){

}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){

}

