#include "testApp.h"
#include "PostInstagram.h"
#include "SaveUIImage.h"
#include "webViewController.h"

PostInstagram *instagramViewController;
SaveUIImage *saveUIImage;
webViewController *webView;

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
    camera_button.loadImage("img/SHOOT_PAGE/camera_btn_bar.png");
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
    save_bar.loadImage("img/SAVE_PAGE/save_btn.png");
    instagram_bar.loadImage("img/SAVE_PAGE/instagram_btn.png");
    thumb_jump_button.loadImage("img/SAVE_PAGE/thumb_button.png");
    mix_bar.loadImage("img/SHOOT_PAGE/mix_btn.png");
    filter_off_button.loadImage("img/VIEW_CHECK_PAGE/filter_off_button.png");
    filter_on_button.loadImage("img/VIEW_CHECK_PAGE/filter_on_button.png");
    save_jump_button.loadImage("img/VIEW_CHECK_PAGE/mix_btn_orange.png");
    edit_button.loadImage("img/SHOOT_PAGE/edit_button.png");
    edit_button_black.loadImage("img/SHOOT_PAGE/effect_x_btn.png");
    done_saving.loadImage("img/SAVE_PAGE/done_saving.png");
    
    contrast.loadImage("img/SHOOT_PAGE/con.png");
    brightness.loadImage("img/SHOOT_PAGE/bri.png");
    blank_photos.loadImage("img/SHOOT_PAGE/blank_photo_white.png");
    
    //library_bar.loadImage("img/LOGO_PAGE/library_bar.png");
    //make_bar.loadImage("img/LOGO_PAGE/make_bar.png");
    mixcan_logo.loadImage("img/LOGO_PAGE/mixcan_logo.png");
    
    make_btn.loadImage("img/LOGO_PAGE/make_btn.png");
    library_btn.loadImage("img/LOGO_PAGE/library_btn.png");
    timeline_btn.loadImage("img/LOGO_PAGE/timeline_btn.png");
    home_btn.loadImage("img/WEB_PAGE/home_btn.png");
    x_btn.loadImage("img/GLOBAL/x.png");
    photolib_btn.loadImage("img/VIEW_CHECK_PAGE/photo_btn.png");
    
    back_button.rotate90(1);
    shoot_jump_button.rotate90(1);
    save_bar.rotate90(1);
    instagram_bar.rotate90(1);
    thumb_jump_button.rotate90(1);
    mix_bar.rotate90(1);
    filter_off_button.rotate90(1);
    filter_on_button.rotate90(1);
    save_jump_button.rotate90(1);
    edit_button.rotate90(1);
    edit_button_black.rotate90(1);
    done_saving.rotate90(1);
    contrast.rotate90(1);
    brightness.rotate90(1);
    
    make_btn.rotate90(1);
    library_btn.rotate90(1);
    timeline_btn.rotate90(1);
    home_btn.rotate90(1);
    
    blank_photos.rotate90(1);
    
    //library_bar.rotate90(1);
    //make_bar.rotate90(1);
    mixcan_logo.rotate90(1);
    
    x_btn.rotate90(1);
    photolib_btn.rotate90(1);
    
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
    videoImagePre.allocate(camWidth,camHeight,OF_IMAGE_COLOR);
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
    conbri_flg = FALSE;
    
    camera_button_p.y = 70;
    
    photo_switch_x[1] = ofGetHeight()/2 - (ofGetHeight()-photo_margin-40 - ofGetHeight()/2)/2;
    photo_switch_x[2] = ofGetHeight()/2;
    photo_switch_x[3] = ofGetHeight()/2 + (ofGetHeight()-photo_margin-40 - ofGetHeight()/2)/2;
    photo_switch_x[4] = ofGetHeight()-photo_margin-40;
    
    library_btn_touch = FALSE;
    home_flg = FALSE;
    
    shoot_flg = FALSE;
    
    //Add webview setup
    webView = [[webViewController alloc] initWithNibName:@"webViewController" bundle:nil];
}

//--------------------------------------------------------------
void testApp::update(){
    
    if(page == START_PAGE){
        if(touchCheck(300,0,150,640) == TRUE){
            page = SHOOT_PAGE;
            
        }
        else if(touchCheck(150,0,150,640) == TRUE){
            camera.openSavedPhotos();
        }
        else if(touchCheck(0,0,150,640) == TRUE){
            page = WEB_PAGE;
        }
        
        if(camera.imageUpdated){
            select_image.setFromPixels(camera.pixels, camera.width, camera.height, OF_IMAGE_COLOR_ALPHA);
            camera.imageUpdated = false;
            select_image.rotate90(1);
            camera.close();
            page = SELECT_PAGE;
        }
    }
    
    else if(page == SHOOT_PAGE){
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            page = START_PAGE;
            mix_btn_flg = FALSE;
            conbri_flg = FALSE;
        }
        
        //撮影ボタン
        if(touchCheck(150/2-130/2,640/2-130/2,130,130) == TRUE &&
            mix_btn_flg == FALSE){
            if(stock_image[1].bAllocated() == FALSE)  stock_image[1] = videoPixels;
            else if(stock_image[2].bAllocated() == FALSE)  stock_image[2] = videoPixels;
            else if(stock_image[3].bAllocated() == FALSE)  stock_image[3] = videoPixels;
            else if(stock_image[4].bAllocated() == FALSE)  stock_image[4] = videoPixels;
            
            shoot_flg = TRUE;

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
        
        //コントラスト、明るさ調整モード
        if(touchCheck(20,470,80,150) == TRUE && mix_btn_flg == FALSE){
            if(conbri_flg == TRUE) conbri_flg = FALSE;
            else if(conbri_flg == FALSE) conbri_flg = TRUE;
        }
        
        if(conbri_flg == TRUE){
            //コントラスト調節
            if(moveCheck(120+115,100,115,500) == TRUE){
                thr = (touch_move.x-100)*255/500;
            }
            else if(moveCheck(120,100,115,500) == TRUE){
                bri = (touch_move.x-100)*255/500;
            }
            
        }
        
        
        ivGrabber.update();
        unsigned char *cdata = ivGrabber.getPixels(),
        *idata_p = videoImagePre.getPixels(),
        *idata = videoImage.getPixels();
        
        for(int k=0; k<camWidth*camHeight*3; k++){
            
            //明るさ
            if(cdata[k]+bri > 255) idata_p[k] = 255;
            else if(cdata[k] + bri < 0) idata_p[k] = 0;
            else idata_p[k] = cdata[k]+bri;

            //コントラスト
            if(idata_p[k] < thr) idata[k] = 0;
            else if(idata_p[k] > (255-thr)) idata[k] = 255;
            else idata[k] = (idata_p[k]-thr)*(256.0/(256.0-thr*2));
        }
        
        videoImage.setImageType(OF_IMAGE_GRAYSCALE);
        videoImage.setImageType(OF_IMAGE_COLOR);
        videoPixels = videoImage;
        videoPixels.crop(camWidth/2-square_width/2,camHeight/2-square_width/2,square_width,square_width);
    
        videoTexture.loadData(videoPixels);
        
        //MIXボタン押す
        if(mix_btn_flg == TRUE){
            if(touchCheck(0,0,150,640) == TRUE){
                
                stripe_image_flg = TRUE;
                page = VIEW_CHECK_PAGE;
                mix_btn_flg = FALSE;
                conbri_flg = FALSE;
            }
        }
        
        //MIXボタン出現
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE && stripe_image_flg == FALSE){
            
            mix_btn_flg = TRUE;
            
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
        
        //スライド操作
        if(slide_flg == FALSE && touchCheck(slide_y,pos.x,600,600) == TRUE){
            slide_span_y = touch_point.x-slide_y;
            slide_flg = TRUE;
        }
        
        if(slide_flg == TRUE && moveCheck(slide_y,pos.x,600,600) == TRUE){
            slide_y = touch_move.y - slide_span_y;
        }
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            mix_btn_flg = FALSE;
            page = SHOOT_PAGE;
        }
        
        //ストライプON / OFF ボタン
        if(touchCheck(ofGetWidth()/2+square_width-80,20,80,80) == TRUE){
            if(filter_flg == TRUE) filter_flg = FALSE;
        }
        //フィルター動かすと出現
        if(filter_flg == FALSE && move_flg == TRUE){
            filter_flg = TRUE;
        }
        
        //セーブボタン
        if(touchCheck(0,0,80,640) == TRUE){
            page = SAVE_PAGE;
            d_stripe_img_pos.y = pos.y;
            stripe_img_pos.y = slide_y;
        }
    }
    
    else if(page == SAVE_PAGE){
        
        stripe_img_pos.y = stripe_img_pos.y - (stripe_img_pos.y - d_stripe_img_pos.y)/4;
        
        //もどるボタン
        if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = VIEW_CHECK_PAGE;
            save_flg = FALSE;
            instagram_flg = FALSE;
        }
        
        //セーブボタン押した後（もどるボタンが現れる）
        if(save_flg == TRUE || instagram_flg == TRUE){
            //ファインダーにもどるボタン
            if(touchCheck(0,0,80,640) == TRUE){
                page = START_PAGE;
                save_flg = FALSE;
                instagram_flg = FALSE;
            }
        }

        
        //instagram_button
        if(touchCheck(150,0,150,640) && instagram_flg == FALSE){
            
            
        if ([PostInstagram canInstagramOpen]){
                save_image[1] = img_px_edit[0];
                //INSTAGRAM に投稿部分 START
                        
                save_image[1].rotate90(-1);
                        
                image = UIImageFromOFImage(save_image[1]);
                        
                instagramViewController = [[PostInstagram alloc] init];
                [instagramViewController setImage:image];
                [ofxiOSGetUIWindow() addSubview:instagramViewController.view];
                [ofxiOSGetViewController() addChildViewController:instagramViewController];
                
                instagram_flg = TRUE;
                }
                else{
                    // Instagramがインストールされていない
                }
                //INSTAGRAM に投稿部分 END
        }
        
        //セーブボタン
        else if(touchCheck(0,0,150,640) == TRUE
                && save_flg == FALSE && save_page_flg == FALSE){
            
            save_image[1] = img_px_edit[0];
            save_image[1].rotate90(-1);
            image = UIImageFromOFImage(save_image[1]);
                    
            saveUIImage = [[SaveUIImage alloc] init];
            [saveUIImage saveImage:image];
            
            save_flg = TRUE;

            }
        }
    
    /*else if(page == THUMBNAIL_PAGE){
        
     
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
     
    }*/

    //もどるボタン
        else if(page == SELECT_PAGE){
            if(touchCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = START_PAGE;
            select_image.clear();
            select_number = 0;
            }
            
            //スライド操作
            if(slide_flg == FALSE && touchCheck(slide_y,pos.x,600,600) == TRUE){
                slide_span_y = touch_point.x-slide_y;
                slide_flg = TRUE;
            }
            
            if(slide_flg == TRUE && moveCheck(slide_y,pos.x,600,600) == TRUE){
                slide_y = touch_move.y - slide_span_y;
            }

        
            //ストライプ OFF ボタン
            if(touchCheck(ofGetWidth()/2+square_width-80,20,80,80) == TRUE){
                if(filter_flg == TRUE) filter_flg = FALSE;
            }
            //フィルター動かすと出現
            if(filter_flg == FALSE && move_flg == TRUE){
                filter_flg = TRUE;
            }
            
            //フォトライブラリボタン
            if(touchCheck(0,0,80,640) == TRUE){
                camera.openSavedPhotos();
            }
            
            if(camera.imageUpdated){
                select_image.setFromPixels(camera.pixels, camera.width, camera.height, OF_IMAGE_COLOR_ALPHA);
                camera.imageUpdated = false;
                select_image.rotate90(1);
                camera.close();
            }

        }
    
        else if(page == WEB_PAGE){
            //Add webView Setup
            
            [ofxiOSGetUIWindow() addSubview:webView.view];

            
            //もどるボタン
            if(touchCheck(0,0,80,640) == TRUE && home_flg == TRUE){
                [webView test];
                page = START_PAGE;
                home_flg = FALSE;
            }
            else if(touchCheck(0,0,150,640) == TRUE){
                home_flg = TRUE;
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
        //make_bar.draw(camera_bar_p.y+150,camera_bar_p.x,81,600);
        //library_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
        
        make_btn.draw(300,0,150,640);
        library_btn.draw(150,0,150,640);
        timeline_btn.draw(0,0,150,640);
    }
    
    if(page == SHOOT_PAGE){
        
        if(shoot_flg == TRUE){
            ofColor(0,0,0);
            ofRect(pos.y,pos.x,square_width*2,square_width*2);
            ofColor(255,255,255);
            shoot_flg = FALSE;
        }
        
        
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
        
        if(conbri_flg == FALSE && mix_btn_flg == FALSE){
            
            /*
            ofSetColor(100,100,100);
            ofEllipse(camera_button_p.y+10,ofGetHeight()/2-el_x[1]-10,20,20);
            ofEllipse(camera_button_p.y+10,ofGetHeight()/2-el_x[2]-10,20,20);
            ofEllipse(camera_button_p.y+10,ofGetHeight()/2-el_x[3]-10,20,20);
            ofEllipse(camera_button_p.y+10,ofGetHeight()/2-el_x[4]-10,20,20);
            ofSetColor(255,255,255);
            */
        
            //camera_button.setAnchorPoint(camera_button.width/2,camera_button.width/2);
            camera_button.draw(-1,0,150,640);
            
            edit_button.draw(20,470,80,150);
        }
        
        //撮影サムネイル
        blank_photos.draw(pos.y+600-ofGetHeight()/4,0,ofGetHeight()/4,ofGetHeight());
                          
        if(stock_image[1].bAllocated() == TRUE) stock_image[1].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*0,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[2].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*1,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[3].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*2,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[4].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*3,ofGetHeight()/4,ofGetHeight()/4);
        
        if(conbri_flg == TRUE){
            
            ofSetColor(255,255,255,50);
            camera_button.draw(-1,0,150,640);
            
            ofSetColor(255,255,255,255);
            edit_button_black.draw(20,470,80,150);
            ofSetColor(116,116,116);
            ofRect(110,0,250,640);
            ofSetColor(255,255,255);
            ofSetLineWidth(5);
            
            ofLine(120+115+58,100,120+115+58,600);
            ofLine(120+58,100,120+58,600);
            
            ofEllipse(120+115+58,100+thr*500/255,20,20);
            ofEllipse(120+58,100+bri*500/255,20,20);
            
            contrast.draw(120+115+58-20,40,40,40);
            brightness.draw(120+58-20,40,40,40);
            
            
        }
        
        videoTexture.draw(cam_pos.y,pos.x,square_width*2,square_width*2);
        
        if(conbri_flg == FALSE) cam_pos.y = cam_pos.y - (cam_pos.y - (pos.y-ofGetHeight()/4-20))/1.6;
        else if(conbri_flg == TRUE) cam_pos.y = cam_pos.y - (cam_pos.y - 380)/1.6;
        
        
        
        //MIXボタン
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE){
            //ofFill();
            //ofSetColor(255,100,100);
            mix_bar.draw(0,0,150,640);
        }
        
    }
    else if(page == VIEW_CHECK_PAGE){
        stripe_image_tx.draw(slide_y,pos.x,square_width*2,square_width*2);
        
        //フィルター
        if(filter_flg == TRUE){
            for(int i=0; i<square_width/slice_height; i+=flames){
                ofSetColor(0,0,0);
                //ofRect(touch_y-(i*slice_height),0,slice_height*(flames-1),camHeight);
                ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
            }
        }
        
        
        //ストライプON/OFFボタン
        if(move_flg == FALSE){
            ofSetColor(255,255,255,100);
            if(filter_flg == TRUE) x_btn.draw(ofGetWidth()/2+square_width-80,20,80,80);
            ofSetColor(255,255,255,255);
        }
        
        //saveボタン
        ofSetColor(255,255,255);
        save_jump_button.draw(0,0,80,640);
        
        //save_image[1].draw(0,0,square_width,square_width);
        //save_image_tx[2].draw(0,square_width,square_width,square_width);
    }
    
    else if(page == SAVE_PAGE){
        
        stripe_image_tx.draw(stripe_img_pos.y,pos.x,square_width*2,square_width*2);
        
        if(save_flg == FALSE && instagram_flg == FALSE){
            //saveボタン（大）
            save_bar.draw(0,0,150,640);
            
            //instagramボタン
            instagram_bar.draw(150,0,150,640);
        }
        
        if(save_flg == TRUE || instagram_flg == TRUE){
            
            home_btn.draw(0,0,80,640);
        }
        
        if(save_flg == TRUE){
            done_saving.draw(200,(640-245)/2,50,245);
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
        select_image.draw(slide_y,pos.x,square_width*2,square_width*2);
        
        //フィルター
        if(filter_flg == TRUE){
            for(int i=0; i<square_width/slice_height; i+=flames){
                ofSetColor(0,0,0);
                //ofRect(touch_y-(i*slice_height),0,slice_height*(flames-1),camHeight);
                ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
            }
        }
        
        //ストライプOFFボタン
        if(move_flg == FALSE){
            ofSetColor(255,255,255,100);
            if(filter_flg == TRUE) x_btn.draw(ofGetWidth()/2+square_width-80,20,80,80);
        }
        
        ofSetColor(255,255,255,255);
        photolib_btn.draw(-1,0,80,640);

    }
    
    if(page == WEB_PAGE){
       home_btn.draw(0,0,80,640);
    }

    
    if(page != START_PAGE && page != WEB_PAGE){
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

//-------------//UIImageFromOFImage//------------------------------------------

 UIImage * testApp::UIImageFromOFImage(ofImage & img){
    int width = img.width;
    int height =img.height;
    
    int nrOfColorComponents = 1;
    
    if (img.type == OF_IMAGE_GRAYSCALE) nrOfColorComponents = 1;
    else if (img.type == OF_IMAGE_COLOR) nrOfColorComponents = 3;
    else if (img.type == OF_IMAGE_COLOR_ALPHA) nrOfColorComponents = 4;
    
    int bitsPerColorComponent = 8;
    int rawImageDataLength = width * height * nrOfColorComponents;
    BOOL interpolateAndSmoothPixels = NO;
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    CGDataProviderRef dataProviderRef;
    CGColorSpaceRef colorSpaceRef;
    CGImageRef imageRef;
    GLubyte *rawImageDataBuffer = img.getPixels();
    dataProviderRef = CGDataProviderCreateWithData(NULL, rawImageDataBuffer, rawImageDataLength, nil);
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    imageRef = CGImageCreate(width, height, bitsPerColorComponent, bitsPerColorComponent * nrOfColorComponents, width * nrOfColorComponents, colorSpaceRef, bitmapInfo, dataProviderRef, NULL, interpolateAndSmoothPixels, renderingIntent);
    UIImage * uimg = [UIImage imageWithCGImage:imageRef];
    return uimg;
    
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
    
    move_flg = TRUE;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
    if(page == SHOOT_PAGE && stock_image[4].bAllocated() == FALSE){
        camera_button_flg = FALSE;
    }
    slide_flg = FALSE;
    
    move_flg = FALSE;
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

