#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    //なめらかにする
    ofEnableSmoothing();
    
    ofSetOrientation(OF_ORIENTATION_90_RIGHT);//Set iOS to Orientation Landscape Right
    //ofSetFrameRate(30);
    
    camWidth =  480;
    camHeight = 360;
    square_width = 300;
    size_m = 0.8;
    photo_margin = (ofGetHeight()-square_width*2)/2;
    thum_margin = 20;
    thr = 0;
    
    camera_bar.loadImage("img/SHOOT_PAGE/camera_bar.png");
    camera_bar.rotate90(1);
    camera_button.loadImage("img/SHOOT_PAGE/camera_button_2.png");
    camera_button.rotate90(1);
    
    photo_btn[1].loadImage("shoot01.png");
    photo_btn[2].loadImage("shoot02.png");
    photo_btn[3].loadImage("shoot03.png");
    photo_btn[4].loadImage("shoot04.png");
    
    photo_btn[1].rotate90(1);
    photo_btn[2].rotate90(1);
    photo_btn[3].rotate90(1);
    photo_btn[4].rotate90(1);
    
    back_button.loadImage("img/GLOBAL/back_button.png");
    shoot_jump_button.loadImage("img/SAVE_PAGE/camera_button.png");
    save_bar.loadImage("img/SAVE_PAGE/save_button.png");
    thumb_jump_button.loadImage("img/SAVE_PAGE/thumb_button.png");
    mix_bar.loadImage("img/SHOOT_PAGE/mix_button.png");
    filter_off_button.loadImage("img/VIEW_CHECK_PAGE/filter_off_button.png");
    filter_on_button.loadImage("img/VIEW_CHECK_PAGE/filter_on_button.png");
    save_jump_button.loadImage("img/VIEW_CHECK_PAGE/save_button.png");
    
    library_bar.loadImage("img/LOGO_PAGE/library_bar.png");
    make_bar.loadImage("img/LOGO_PAGE/make_bar.png");
    mixcan_logo.loadImage("img/LOGO_PAGE/mixcan_logo.png");
    
    back_button.rotate90(1);
    shoot_jump_button.rotate90(1);
    save_bar.rotate90(1);
    thumb_jump_button.rotate90(1);
    mix_bar.rotate90(1);
    filter_off_button.rotate90(1);
    filter_on_button.rotate90(1);
    save_jump_button.rotate90(1);
    
    library_bar.rotate90(1);
    make_bar.rotate90(1);
    mixcan_logo.rotate90(1);
    
    pos.x = 0+photo_margin;
    before_pos.x = photo_margin + square_width;
    after_pos.x = photo_margin - square_width;
    pos.y = after_pos.y = before_pos.y = ofGetWidth()-photo_margin*2-120-square_width*2;
    
    thum_width = ofGetHeight()/2-photo_margin-thum_margin/2;
    
    shoot_num = 1;
    
    //ひとつのスライスの大きさ
    slice_height = 1;
    
    //square_width = ofGetWidth();
    flames = 4;
    ivGrabber.initGrabber(camWidth,camHeight,OF_PIXELS_BGRA);
    videoImage.allocate(camWidth,camHeight,OF_IMAGE_COLOR);
    videoPixels.allocate(camWidth,camHeight,OF_IMAGE_COLOR);
    videoTexture.allocate(square_width,square_width,GL_RGB);
    
    flg = false;
    filter_flg = TRUE;
    
    for(int i=0; i<7; i++){
        img_px_edit[i].allocate(square_width,square_width,OF_IMAGE_COLOR);
        //stock_image[i].allocate(square_width,square_width,OF_IMAGE_COLOR);
        stock_image[i].clear();
    }
    
    img_px_edit[0].allocate(square_width,square_width,OF_IMAGE_COLOR);
    
    touch_num = 0;
    page = START_PAGE;
    stripe_image_flg = false;
    stripe_image_tx.allocate(square_width,square_width,GL_RGB);
    
    camera_bar_p.x = photo_margin;
    camera_bar_p.y = 100;
    camera_button_flg = FALSE;
    
    camera_button_p.y = 70;
    
    photo_switch_x[1] = ofGetHeight()/2 - (ofGetHeight()-photo_margin-40 - ofGetHeight()/2)/2;
    photo_switch_x[2] = ofGetHeight()/2;
    photo_switch_x[3] = ofGetHeight()/2 + (ofGetHeight()-photo_margin-40 - ofGetHeight()/2)/2;
    photo_switch_x[4] = ofGetHeight()-photo_margin-40;
}

//--------------------------------------------------------------
void testApp::update(){
    
    if(page == START_PAGE){
        if(touchCheck(camera_bar_p.y,camera_bar_p.x,81,600) == TRUE){
            page = THUMBNAIL_PAGE;
        }
        else if(touchCheck(camera_bar_p.y+150,camera_bar_p.x,81,600) == TRUE){
            page = SHOOT_PAGE;
        }
    }
    
    else if(page == SHOOT_PAGE){
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            page = START_PAGE;
        }
        
        //撮影ボタン
        if(touchCheck(camera_button_p.y-camera_button.width/2,ofGetHeight()/2-camera_button.width/2,100,100) == TRUE){
            if(stock_image[1].bAllocated() == FALSE)  stock_image[1] = videoPixels;
            else if(stock_image[2].bAllocated() == FALSE)  stock_image[2] = videoPixels;
            else if(stock_image[3].bAllocated() == FALSE)  stock_image[3] = videoPixels;
            else if(stock_image[4].bAllocated() == FALSE)  stock_image[4] = videoPixels;
        }
        
        /*
        //camera_buttonに触れる
        if(touchCheck(camera_bar_p.y,camera_bar_p.x,80,80) == TRUE){
            camera_button_flg = TRUE;
        }
        
        if(camera_button_flg == FALSE){
            camera_button_p.x = camera_button_p.x - float((camera_button_p.x-camera_bar_p.x+5)/5);
            camera_button_p.y = camera_bar_p.y+5;
            
            for(int i=0; i<5; i++){
                photo_flg[i] = FALSE;
                photo_past_flg[i] = FALSE;
                stock_image[i].clear();
            }
        }
        
        else if(camera_button_flg == TRUE){
            if(touch_move.x < camera_bar_p.x+600-40-35){
                camera_button_p.x = touch_move.x;
            }
        }
        
        if(camera_button_p.x > photo_switch_x[4]-50){
            photo_flg[4] = TRUE;
        }
        else if(camera_button_p.x > photo_switch_x[3]-40){
            photo_flg[3] = TRUE;
        }
        else if(camera_button_p.x > photo_switch_x[2]-40){
            photo_flg[2] = TRUE;
        }
        else if(camera_button_p.x > photo_switch_x[1]-40){
            photo_flg[1] = TRUE;
        }
        
        for(int i=0; i<5; i++){
            if(photo_flg[i] == TRUE && photo_past_flg[i] == FALSE){
                stock_image[i] = videoPixels;
                photo_past_flg[i] = TRUE;
            }
        }
        */
        
        
        //コントラスト調節 画面上のみ反応
        if(moveCheck(pos.y,pos.x,square_width,square_width) == TRUE){
            thr = touch_move.x*255/600;
            bri = (touch_move.y-pos.y)*255/600;
        }
        
        ivGrabber.update();
        unsigned char *cdata = ivGrabber.getPixels(),
        *idata = videoImage.getPixels();
        
        //コントラスト
        for(int k=0; k<camWidth*camHeight*3; k++){
            if(cdata[k]+bri > 255) cdata[k] = 255;
            else if(cdata[k] + bri < 0) cdata[k] = 0;
            else cdata[k] = cdata[k]+bri;
            if(cdata[k] < thr) idata[k] = 0;
            else if(cdata[k] > (255-thr)) idata[k] = 255;
            else idata[k] = (cdata[k]-thr)*(256.0/(256.0-thr*2));
        }
        
        videoImage.setImageType(OF_IMAGE_GRAYSCALE);
        videoImage.setImageType(OF_IMAGE_COLOR);
        videoPixels = videoImage;
        videoPixels.crop(camWidth/2-square_width/2,camHeight/2-square_width/2,square_width,square_width);
    
        videoTexture.loadData(videoPixels);
        
        /*
        if(touchCheck((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*0+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5) == TRUE){
            shoot_btn_flg[1] = TRUE;
        }
        else if(touchCheck((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*1+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5) == TRUE){
            shoot_btn_flg[2] = TRUE;
        }
        else if(touchCheck((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*2+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5) == TRUE){
            shoot_btn_flg[3] = TRUE;
        }
        else if(touchCheck((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*3+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5) == TRUE){
            shoot_btn_flg[4] = TRUE;
        }
        
        if(shoot_btn_flg[1] == TRUE){
            stock_image[1] = videoPixels;
            shoot_btn_flg[1] = FALSE;
        }
        if(shoot_btn_flg[2] == TRUE){
            stock_image[2] = videoPixels;
            shoot_btn_flg[2] = FALSE;
        }

        if(shoot_btn_flg[3] == TRUE){
            stock_image[3] = videoPixels;
            shoot_btn_flg[3] = FALSE;
        }

        if(shoot_btn_flg[4] == TRUE){
            stock_image[4] = videoPixels;
            shoot_btn_flg[4] = FALSE;
        }
         */
        
        //MIXボタン出現
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE){
            mix_btn_flg = TRUE;
            
            //MIXボタンにタッチ
            if(touchCheck(camera_bar_p.y,pos.x,100,square_width*2) == TRUE){
                stripe_image_flg = TRUE;
                page = VIEW_CHECK_PAGE;
                
            }
        }
    }
    
    else if(page == VIEW_CHECK_PAGE){
        
        //MIX加工
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
            //image_for_save.saveImage(ofxiOSGetDocumentsDirectory()+"MIX.jpg");
            //ofxiOSScreenGrab(NULL);
            stripe_image_flg = false;
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
        }
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            page = SHOOT_PAGE;
        }
        
        //ストライプON / OFF ボタン
        if(touchCheck(20,20,80,150) == TRUE){
            if(filter_flg == TRUE) filter_flg = FALSE;
            else if(filter_flg == FALSE) filter_flg = TRUE;
        }
        
        //セーブボタン
        if(touchCheck(20,ofGetHeight()-20-150,80,150) == TRUE){
            page = SAVE_PAGE;
        }
    }
    
    else if(page == SAVE_PAGE){
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = VIEW_CHECK_PAGE;
            save_flg = FALSE;
        }
        
        //セーブボタン
        else if(touchCheck(camera_bar_p.y,pos.x,100,square_width*2) == TRUE
                && save_flg == FALSE){
            for(int num=1; num<21; num++){
                if(save_image[num].bAllocated() == FALSE){
                    save_image[num] = img_px_edit[0];
                    break;
                }
                else if(save_image[20].bAllocated() == TRUE){
                    /*満杯です*/
                }
            }
            save_flg = TRUE;
        }
        
        //セーブボタン押した後（もどるボタンが現れる）
        if(save_flg == TRUE){
            //ファインダーにもどるボタン
            if(touchCheck(20,20,80,150) == TRUE){
                page = SHOOT_PAGE;
                save_flg = FALSE;
            }
            //サムネイルにもどるボタン
            else if(touchCheck(20,ofGetHeight()-20-150,80,150) == TRUE){
                page = THUMBNAIL_PAGE;
                save_flg = FALSE;
            }
        }
    }
    
    else if(page == THUMBNAIL_PAGE){
        
        for(int num=1; num<21; num++){
            if(save_image[num].bAllocated() == TRUE){
                if(num%2 == 1){
                    if(touchCheck(pos.y -(thum_width+thum_margin)*(num/2-1), pos.x, thum_width, thum_width) == TRUE){
                        select_image = save_image[num];
                        select_number = num;
                        page = SELECT_PAGE;
                    }
                }
                else if(num%2 == 0){
                    if(touchCheck(pos.y -(thum_width+thum_margin)*(num/2-2), pos.x+thum_width+thum_margin, thum_width, thum_width) == TRUE){
                        select_image = save_image[num];
                        select_number = num;
                        page = SELECT_PAGE;
                    }
                }
            }
        }
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = START_PAGE;
        }
    }
    
    else if(page == SELECT_PAGE){
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = THUMBNAIL_PAGE;
            select_image.clear();
            select_number = 0;
        }
        
        //ストライプON / OFF ボタン
        if(touchCheck(20,20,80,150) == TRUE){
            if(filter_flg == TRUE) filter_flg = FALSE;
            else if(filter_flg == FALSE) filter_flg = TRUE;
        }
    }
    
    //タッチ関数をリセットする
    touch_point.x = -100;
    touch_point.y = -100;
    touch_move.x = -100;
    touch_move.y = -100;
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofBackground(255,255,255);
    ofSetColor(255,255,255);
    
    if(page == START_PAGE){
        
        mixcan_logo.draw(camera_bar_p.y+600,camera_bar_p.x,81,600);

        make_bar.draw(camera_bar_p.y+150,camera_bar_p.x,81,600);
        library_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
    }
    
    if(page == SHOOT_PAGE){
        videoTexture.draw(pos.y,pos.x,square_width*2,square_width*2);
        
        if(stock_image[1].bAllocated() == FALSE){
            el_dx[1] = 100;
            el_dx[2] = 150;
            el_dx[3] = 200;
            el_dx[4] = 250;
        }
        else if(stock_image[2].bAllocated() == FALSE){
            el_dx[1] = 0;
            el_dx[2] = 100;
            el_dx[3] = 150;
            el_dx[4] = 200;
        }
        else if(stock_image[3].bAllocated() == FALSE){
            el_dx[1] = 0;
            el_dx[2] = 0;
            el_dx[3] = 100;
            el_dx[4] = 150;
        }
        else if(stock_image[4].bAllocated() == FALSE){
            el_dx[1] = 0;
            el_dx[2] = 0;
            el_dx[3] = 0;
            el_dx[4] = 100;
        }
        
        else if(stock_image[4].bAllocated() == TRUE){
            el_dx[1] = 0;
            el_dx[2] = 0;
            el_dx[3] = 0;
            el_dx[4] = 0;
            
        }
        
        for(int i=1; i<5; i++){
            el_x[i] = el_x[i] - (el_x[i]-el_dx[i])/2;
        }
        
        ofSetColor(100,100,100);
        ofEllipse(camera_button_p.y+10,ofGetHeight()/2+el_x[1]-10,20,20);
        ofEllipse(camera_button_p.y+10,ofGetHeight()/2+el_x[2]-10,20,20);
        ofEllipse(camera_button_p.y+10,ofGetHeight()/2+el_x[3]-10,20,20);
        ofEllipse(camera_button_p.y+10,ofGetHeight()/2+el_x[4]-10,20,20);
        ofSetColor(255,255,255);
        
        
        camera_button.setAnchorPoint(camera_button.width/2,camera_button.width/2);
        camera_button.draw(camera_button_p.y+10,ofGetHeight()/2,100,100);
        
        /*
        //カメラバー
        camera_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
        
        ofSetColor(100,100,100);
        ofEllipse(camera_bar_p.y+40,photo_switch_x[1]-5,10,10);
        ofEllipse(camera_bar_p.y+40,photo_switch_x[2]-5,10,10);
        ofEllipse(camera_bar_p.y+40,photo_switch_x[3]-5,10,10);
        ofEllipse(camera_bar_p.y+40,photo_switch_x[4]-5,10,10);
        
        ofSetColor(255,255,255);
        camera_button.draw(camera_button_p.y,camera_button_p.x,70,70);
        */
        
        //撮影ボタン
        /*photo_btn[1].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*0+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[2].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*1+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[3].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*2+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);
        photo_btn[4].draw((ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/4*3+(ofGetHeight()/4-ofGetHeight()/5)/2,ofGetHeight()/5,ofGetHeight()/5);*/
        
        //撮影サムネイル
        if(stock_image[1].bAllocated() == TRUE) stock_image[1].draw(pos.y-10-ofGetHeight()/4,ofGetHeight()/4*0,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[2].draw(pos.y-10-ofGetHeight()/4,ofGetHeight()/4*1,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[3].draw(pos.y-10-ofGetHeight()/4,ofGetHeight()/4*2,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[4].draw(pos.y-10-ofGetHeight()/4,ofGetHeight()/4*3,ofGetHeight()/4,ofGetHeight()/4);
        
        
        //コントラストバー
        ofNoFill();
        ofRect(pos.y,20,30,600);
        ofFill();
        ofRect(pos.y,20+thr*600/200,30,10);
        
        //MIXボタン
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE){
            //ofFill();
            //ofSetColor(255,100,100);
            mix_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
        }
        
    }
    else if(page == VIEW_CHECK_PAGE){
        stripe_image_tx.draw(touch_y,pos.x,square_width*2,square_width*2);
        
        //フィルター
        if(filter_flg == TRUE){
            for(int i=0; i<square_width/slice_height; i+=flames){
                ofSetColor(0,0,0);
                //ofRect(touch_y-(i*slice_height),0,slice_height*(flames-1),camHeight);
                ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
            }
        }
        
        //ストライプON/OFFボタン
        ofSetColor(255,255,255);
        if(filter_flg == TRUE) filter_on_button.draw(20,20,80,150);
        else if(filter_flg == FALSE) filter_off_button.draw(20,20,80,150);
        
        //saveボタン
        ofSetColor(255,255,255);
        save_jump_button.draw(20,ofGetHeight()-20-150,80,150);
        
        //save_image[1].draw(0,0,square_width,square_width);
        //save_image_tx[2].draw(0,square_width,square_width,square_width);
    }
    
    else if(page == SAVE_PAGE){
        
        stripe_image_tx.draw(pos.y,pos.x,square_width*2,square_width*2);
        
        if(save_flg == FALSE){
            //saveボタン（大）
            save_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
        }
        
        if(save_flg == TRUE){
            //撮影にもどるボタン
            //ofSetColor(100,255,100);
            shoot_jump_button.draw(20,20,80,150);
        
            //サムネイル行きボタン
            //ofSetColor(100,255,100);
            thumb_jump_button.draw(20,ofGetHeight()-20-150,80,150);
        }
    }
    
    else if(page == THUMBNAIL_PAGE){
        for(int num=1; num<21; num++){
            if(save_image[num].bAllocated() == TRUE){
                if(num%2 == 1){
                    save_image[num].draw(pos.y -(thum_width+thum_margin)*(num/2-1), pos.x, thum_width, thum_width);
                }
                else if(num%2 == 0){
                    save_image[num].draw(pos.y -(thum_width+thum_margin)*(num/2-2), pos.x+thum_width+thum_margin, thum_width, thum_width);
                }
            }
        }
    }
    
    else if(page == SELECT_PAGE){
        select_image.draw(touch_y,pos.x,square_width*2,square_width*2);
        
        //フィルター
        if(filter_flg == TRUE){
            for(int i=0; i<square_width/slice_height; i+=flames){
                ofSetColor(0,0,0);
                //ofRect(touch_y-(i*slice_height),0,slice_height*(flames-1),camHeight);
                ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
            }
        }
        
        //ストライプON/OFFボタン
        ofSetColor(255,255,255);
        if(filter_flg == TRUE) filter_on_button.draw(20,20,80,150);
        else if(filter_flg == FALSE) filter_off_button.draw(20,20,80,150);
    }

    
    if(page != START_PAGE){
        //もどるボタン
        ofSetColor(255,255,255);
        back_button.draw(ofGetWidth()-140,20,80,150);
    }
}


//タッチ検定
bool testApp::touchCheck(int x,int y,int w,int h){
    if(touch_point.x > x && touch_point.x < x+w && touch_point.y >y && touch_point.y < y+h){
        return TRUE;
    }
    else return FALSE;
}

bool testApp::moveCheck(int x,int y,int w,int h){
    if(touch_move.y > x && touch_move.y < x+w && touch_move.x >y && touch_move.x < y+h){
        return TRUE;
    }
    else return FALSE;
}


//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
    
    touch_point.x = touch.x;
    touch_point.y = touch.y;
    
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    touch_y = touch.x;
    
    touch_move.x = touch.y;
    touch_move.y = touch.x;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
    if(page == SHOOT_PAGE && stock_image[4].bAllocated() == FALSE){
        camera_button_flg = FALSE;
    }
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
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

