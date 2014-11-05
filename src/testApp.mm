#include "testApp.h"
#include "PostInstagram.h"
#include "SaveUIImage.h"
#include "webViewController.h"
#include "scrollViewController.h"

PostInstagram *instagramViewController;
SaveUIImage *saveUIImage;
webViewController *webView;
scrollViewController *scrollView;

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
    
    camera_button.loadImage("img/SHOOT_PAGE/camera_btn_bar.png");
    camera_button.rotate90(1);
    camera_button_push.loadImage("img/SHOOT_PAGE/camera_btn_bar_touchDown.png");
    camera_button_push.rotate90(1);
    
    photo_btn[1].rotate90(1);
    photo_btn[2].rotate90(1);
    photo_btn[3].rotate90(1);
    photo_btn[4].rotate90(1);
    
    menus.loadImage("img/LOGO_PAGE/menus_color.png");
    save_menus.loadImage("img/SAVE_PAGE/save_menus.png");
    back_button.loadImage("img/GLOBAL/back_btn.png");
    shoot_jump_button.loadImage("img/SAVE_PAGE/camera_button.png");
    save_bar.loadImage("img/SAVE_PAGE/save_btn.png");
    instagram_bar.loadImage("img/SAVE_PAGE/instagram_btn.png");
    thumb_jump_button.loadImage("img/SAVE_PAGE/thumb_button.png");
    mix_bar.loadImage("img/SHOOT_PAGE/mix_btn.png");
    filter_off_button.loadImage("img/VIEW_CHECK_PAGE/filter_off_button.png");
    filter_on_button.loadImage("img/VIEW_CHECK_PAGE/filter_on_button.png");
    save_jump_button.loadImage("img/VIEW_CHECK_PAGE/share_save_btn.png");
    edit_button.loadImage("img/SHOOT_PAGE/conbra_btn.png");
    edit_button_x.loadImage("img/SHOOT_PAGE/conbri_x_btn.png");
    done_saving.loadImage("img/SAVE_PAGE/done_saving.png");
    please.loadImage("img/SAVE_PAGE/please.png");
    
    contrast.loadImage("img/SHOOT_PAGE/con.png");
    brightness.loadImage("img/SHOOT_PAGE/bri.png");
    blank_photos.loadImage("img/SHOOT_PAGE/blank_photo_white.png");
    
    //library_bar.loadImage("img/LOGO_PAGE/library_bar.png");
    //make_bar.loadImage("img/LOGO_PAGE/make_bar.png");
    mixcan_logo.loadImage("img/LOGO_PAGE/mixcan_logo.png");
    
    make_btn.loadImage("img/LOGO_PAGE/make_btn.png");
    library_btn.loadImage("img/LOGO_PAGE/library_btn.png");
    timeline_btn.loadImage("img/LOGO_PAGE/timeline_btn.png");
    home_btn.loadImage("img/home_btn.png");
    x_btn.loadImage("img/GLOBAL/x.png");
    photolib_btn.loadImage("img/VIEW_CHECK_PAGE/photo_btn.png");
    mixcan_header.loadImage("img/GLOBAL/mixcan_header.png");
    
    info.loadImage("img/LOGO_PAGE/info.png");
    
    testing.loadImage("img/testing.jpg");
    
    cancel_photo_btn.loadImage("img/SHOOT_PAGE/cancel_photo_btn.png");
    swipe_arrow.img.loadImage("img/VIEW_CHECK_PAGE/swipe_arrow.png");
    shoot_req.img.loadImage("img/SHOOT_PAGE/SHOOTx4.png");
    shoot_req.img.rotate90(1);
    edit_req.img.loadImage("img/SHOOT_PAGE/color_set.png");
    edit_req.img.rotate90(1);
    
    menus.rotate90(1);
    save_menus.rotate90(1);
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
    edit_button_x.rotate90(1);
    done_saving.rotate90(1);
    please.rotate90(1);
    contrast.rotate90(1);
    brightness.rotate90(1);
    
    make_btn.rotate90(1);
    library_btn.rotate90(1);
    timeline_btn.rotate90(1);
    home_btn.rotate90(1);
    
    blank_photos.rotate90(1);
    
    mixcan_logo.rotate90(1);
    
    x_btn.rotate90(1);
    photolib_btn.rotate90(1);
    mixcan_header.rotate90(1);
    
    info.rotate90(1);
    testing.rotate90(1);
    cancel_photo_btn.rotate90(1);
    swipe_arrow.img.rotate90(1);
    
    pos.x = 0+photo_margin;
    before_pos.x = photo_margin + square_width;
    after_pos.x = photo_margin - square_width;
    pos.y = after_pos.y = before_pos.y = ofGetWidth()-photo_margin*2-120-square_width*2;
    
    thum_width = ofGetHeight()/2-photo_margin-thum_margin/2;
    
    shoot_num = 0;
    
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
    page = FIRST_PAGE;
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
    webView = [[webViewController alloc] initWithNibName:nil bundle:nil];
    scrollView = [[scrollViewController alloc] initWithNibName:nil bundle:nil];
    
    if((ofGetHeight() == 640 && ofGetWidth() == 1136) ||(ofGetHeight() == 750 && ofGetWidth() == 1334)){
        device_number = iPhone5;
    }
    else{
        device_number = others;
    }
    
    swipe_arrow_init();
    shoot_req_init();
    edit_req_init();
    
}

//--------------------------------------------------------------
void testApp::update(){
    
#pragma mark UPDATE FIRST_PAGE
    
    if(page == FIRST_PAGE){
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
        {
            // ２回目以降の起動時
            
            page = START_PAGE;

        }
        else
        {
            // 初回起動時
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [ofxiOSGetUIWindow() addSubview:scrollView.view];
            page = START_PAGE;
        }
        
        swipe_arrow.flg = TRUE;
        shoot_req.flg = TRUE;
        edit_req.flg = TRUE;

    }
 
    
#pragma mark UPDATE START_PAGE
    if(page == START_PAGE){
        if(touchUpCheck(300,0,150,640) == TRUE){
            page = SHOOT_PAGE;
            
        }
        else if(touchUpCheck(150,0,150,640) == TRUE){
            camera.openSavedPhotos();
        }
        else if(touchUpCheck(0,0,150,640) == TRUE){
            page = WEB_PAGE;
        }
        else if(touchUpCheck(ofGetWidth()-140,ofGetHeight()-90,70,70) == TRUE){
            [ofxiOSGetUIWindow() addSubview:scrollView.view];
        }
        
        if(camera.getImageUpdated()){
            select_image.setFromPixels(camera.getPixels(), camera.getWidth(), camera.getHeight(), OF_IMAGE_COLOR_ALPHA);
            //camera.imageUpdated = false;
            select_image.rotate90(1);
            camera.close();
            slide_y = ofGetWidth()/2-square_width;
            page = SELECT_PAGE;
        }
    }

#pragma mark UPDATE SHOOT_PAGE
    
    else if(page == SHOOT_PAGE){
        
        //もどるボタン
        if(touchUpCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            page = START_PAGE;
            mix_btn_flg = FALSE;
            conbri_flg = FALSE;
            shoot_num = 0;
        }
        
        //写真リセットボタン
        if(stock_image[1].bAllocated() != FALSE && stock_image[4].bAllocated() != TRUE){ //写真があれば
            if(touchUpCheck(ofGetWidth()-140,ofGetHeight()-20-150,80,150)){
                if(stock_image[3].bAllocated() == TRUE) stock_image[3].clear();
                else if(stock_image[2].bAllocated() == TRUE) stock_image[2].clear();
                else if(stock_image[1].bAllocated() == TRUE) stock_image[1].clear();
            }
        }
        
        //撮影ボタン
        if(touchUpCheck(150/2-130/2,640/2-130/2,130,130) == TRUE &&
            mix_btn_flg == FALSE){
            if(stock_image[1].bAllocated() == FALSE){
                stock_image[1] = videoPixels;
                flash_flg[1] = TRUE;
                flash[1] = 255;
                shoot_num = 1;
            }
            else if(stock_image[2].bAllocated() == FALSE){
                stock_image[2] = videoPixels;
                flash_flg[2] = TRUE;
                flash[2] = 255;
                shoot_num = 2;
            }
            else if(stock_image[3].bAllocated() == FALSE){
                stock_image[3] = videoPixels;
                flash_flg[3] = TRUE;
                flash[3] = 255;
                shoot_num = 3;
            }
            else if(stock_image[4].bAllocated() == FALSE){
                stock_image[4] = videoPixels;
                flash_flg[4] = TRUE;
                flash[4] = 255;
                shoot_num = 4;
            }
            else{
                shoot_num = 0;
            }
            
            shoot_flg = TRUE;

        }
        
        
        //コントラスト、明るさ調整モード
        if(touchUpCheck(20,470,80,150) == TRUE && mix_btn_flg == FALSE){
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
        //unsigned char *cdata = testing.getPixels(),
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
            if(touchUpCheck(0,0,150,640) == TRUE){
                
                stripe_image_flg = TRUE;
                page = VIEW_CHECK_PAGE;
                mix_btn_flg = FALSE;
                conbri_flg = FALSE;
                slide_y = ofGetWidth()/2-square_width;
                shoot_num = 0;
            }
        }
        
        //MIXボタン出現
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE && stripe_image_flg == FALSE){
            
            mix_btn_flg = TRUE;
            
        }
        
        //SHOOT表示動く / edit表示動く
        if(shoot_req.flg == TRUE){
        shoot_req.pos.y = shoot_req.pos.y - (shoot_req.pos.y - shoot_req.d_pos.y)/3;
        edit_req.pos.y = edit_req.pos.y - (edit_req.pos.y - edit_req.d_pos.y)/3;
            if(shoot_req.pos.y < shoot_req.d_pos.y+100){
                //やじるしが移動したらアルファが減ってゆく
                shoot_req.alph -= 5;
                edit_req.alph -= 5;
                if(shoot_req.alph < 0){
                    shoot_req.flg = FALSE;
                }
            }
        }
        
        if(stock_image[1].bAllocated() == TRUE || conbri_flg == TRUE) shoot_req.flg = FALSE;
    }
    
#pragma mark UPDATE VIEW_CHECK_PAGE
    
    else if(page == VIEW_CHECK_PAGE){
        
        //MIX加工
        if(stripe_image_flg == true){
        
            for(int layer_num=-1; layer_num<(square_width/slice_height); layer_num+=flames){
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
        
        //スワイプ表示動く
        swipe_arrow.pos.y = swipe_arrow.pos.y - (swipe_arrow.pos.y - swipe_arrow.d_pos.y)/20;
        if(swipe_arrow.pos.y < swipe_arrow.d_pos.y+100){
            //やじるしが移動したらアルファが減ってゆく
            if(swipe_arrow.alph > 100){
                swipe_arrow.alph -= 5;
            }
        }
        
        //スライド操作
        //touchDownしたとき
        if(slide_flg == FALSE && touchDownCheck(slide_y,pos.x,600,600) == TRUE){
            slide_span_y = touch_down_point.x-slide_y;
            slide_flg = TRUE;
            if(swipe_arrow.flg == TRUE){
                swipe_arrow.flg = FALSE;
            }
            ofLogWarning("slide_flg = TRUE");
        }
        //moveしたとき
        if(slide_flg == TRUE && moveCheck(slide_y,pos.x,600,600) == TRUE){
            slide_y = touch_move.y - slide_span_y;
            ofLogWarning("moving");
            past_touch_move.y = touch_move.y;
            slide_move_flg = TRUE;
        }
        //touchUpしたとき
        if(touchUpCheck(slide_y,pos.x,600,600) == TRUE && slide_move_flg == TRUE){
            speed = touch_up_point.x - past_touch_move.y;
            friction = 0.85;
            accel_flg = TRUE;
            ofLogWarning("accel_flg = TRUE");
            ofLog(OF_LOG_NOTICE, "touch_up_point.x = %f | past_touch_move.x = %f",touch_up_point.x,past_touch_move.y);
        }
        
        if(accel_flg == TRUE && slide_move_flg == TRUE){
            speed *= friction;
            slide_y += speed;
            ofLogVerbose() << "slide_y is moving";
            ofLogWarning("slide_y is moving");
            if(speed < 1 && speed > -1){
                accel_flg = FALSE;
                slide_move_flg = FALSE;
                ofLogVerbose() << "accel_flg = FALSE";
                ofLogWarning("accel_flg = FALSE");
            }
        }
        
        //スライド限界
        if(slide_y < 150-600) slide_y = 150-600;
        if(device_number == iPhone5 && slide_y > 1136-200) slide_y = 1136-200;
        else if(device_number == others && slide_y > 960-200) slide_y = 960-200;
        
        //もどるボタン
        if(touchUpCheck(ofGetWidth()-140,20,80,150) == TRUE){
            for(int i=1; i<5; i++){
                stock_image[i].clear();
            }
            mix_btn_flg = FALSE;
            page = SHOOT_PAGE;
            accel_flg = FALSE;
            
            swipe_arrow_init();
            
        }
        
        //ストライプON / OFF ボタン
        if(touchUpCheck(ofGetWidth()/2+square_width-80,20,80,80) == TRUE){
            if(filter_flg == TRUE) filter_flg = FALSE;
        }
        //フィルター動かすと出現
        if(filter_flg == FALSE && move_flg == TRUE){
            filter_flg = TRUE;
        }
        
        //セーブボタン
        if(touchUpCheck(0,0,80,640) == TRUE && accel_flg != TRUE){
            page = SAVE_PAGE;
            d_stripe_img_pos.y = pos.y;
            stripe_img_pos.y = slide_y;
            save_flg = FALSE;
            instagram_flg = FALSE;
            none_instagram_flg = FALSE;
            accel_flg = FALSE;
        }
        
}
    
#pragma mark UPDATE SAVE_PAGE
    
    else if(page == SAVE_PAGE){
        
        stripe_img_pos.y = stripe_img_pos.y - (stripe_img_pos.y - d_stripe_img_pos.y)/4;
        
        //もどるボタン
        if(touchUpCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = VIEW_CHECK_PAGE;
            save_flg = FALSE;
            instagram_flg = FALSE;
            none_instagram_flg = FALSE;
            slide_y = ofGetWidth()/2-square_width;
        }
        
        //セーブボタン押した後（もどるボタンが現れる）
        if(save_flg == TRUE || instagram_flg == TRUE || none_instagram_flg == TRUE){
            //ファインダーにもどるボタン
            if(touchUpCheck(0,0,80,640) == TRUE){
                page = START_PAGE;
                save_flg = FALSE;
                instagram_flg = FALSE;
                none_instagram_flg = FALSE;
            }
        }
        
        //instagram_button
        if(touchUpCheck(150,0,150,640) && instagram_flg == FALSE && none_instagram_flg == FALSE){
            
            
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
                save_image[1] = img_px_edit[0];
                save_image[1].rotate90(-1);
                image = UIImageFromOFImage(save_image[1]);
                
                saveUIImage = [[SaveUIImage alloc] init];
                [saveUIImage saveImage:image];

                NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/en/app/instagram/id389801252?mt=8"];
                [[UIApplication sharedApplication] openURL:url];
                
                none_instagram_flg = TRUE;
            }
        }
        
        //セーブボタン
        else if(touchUpCheck(0,0,150,640) == TRUE
                && save_flg == FALSE){
            
            save_image[1] = img_px_edit[0];
            save_image[1].rotate90(-1);
            image = UIImageFromOFImage(save_image[1]);
                    
            saveUIImage = [[SaveUIImage alloc] init];
            [saveUIImage saveImage:image];
            
            save_flg = TRUE;

            }
        }
    
#pragma mark UPDATE SELECT_PAGE
    
    //もどるボタン
    else if(page == SELECT_PAGE){
        if(touchUpCheck(ofGetWidth()-140,20,80,150) == TRUE){
            page = START_PAGE;
            select_image.clear();
            select_number = 0;
        }
        
        //スライド操作
        //touchDownしたとき
        if(slide_flg == FALSE && touchDownCheck(slide_y,pos.x,600,600) == TRUE){
            slide_span_y = touch_down_point.x-slide_y;
            slide_flg = TRUE;
            if(swipe_arrow.flg == TRUE){
                swipe_arrow.flg = FALSE;
            }
            ofLogWarning("slide_flg = TRUE");
        }
        //moveしたとき
        if(slide_flg == TRUE && moveCheck(slide_y,pos.x,600,600) == TRUE){
            slide_y = touch_move.y - slide_span_y;
            ofLogWarning("moving");
            past_touch_move.y = touch_move.y;
            slide_move_flg = TRUE;
        }
        //touchUpしたとき
        if(touchUpCheck(slide_y,pos.x,600,600) == TRUE && slide_move_flg == TRUE){
            speed = touch_up_point.x - past_touch_move.y;
            friction = 0.85;
            accel_flg = TRUE;
            ofLogWarning("accel_flg = TRUE");
            ofLog(OF_LOG_NOTICE, "touch_up_point.x = %f | past_touch_move.x = %f",touch_up_point.x,past_touch_move.y);
        }
        
        if(accel_flg == TRUE && slide_move_flg == TRUE){
            speed *= friction;
            slide_y += speed;
            ofLogVerbose() << "slide_y is moving";
            ofLogWarning("slide_y is moving");
            if(speed < 1 && speed > -1){
                accel_flg = FALSE;
                slide_move_flg = FALSE;
                ofLogVerbose() << "accel_flg = FALSE";
                ofLogWarning("accel_flg = FALSE");
            }
        }
        
        //スライド限界
        if(slide_y < 150-600) slide_y = 150-600;
        if(device_number == iPhone5 && slide_y > 1136-200) slide_y = 1136-200;
        else if(device_number == others && slide_y > 960-200) slide_y = 960-200;
        
        //ストライプ OFF ボタン
        if(touchUpCheck(ofGetWidth()/2+square_width-80,20,80,80) == TRUE){
            if(filter_flg == TRUE) filter_flg = FALSE;
        }
        //フィルター動かすと出現
        if(filter_flg == FALSE && move_flg == TRUE){
            filter_flg = TRUE;
        }
        
        //フォトライブラリボタン
        if(touchUpCheck(0,0,80,640) == TRUE){
            camera.openSavedPhotos();
        }
        
        if(camera.getImageUpdated()){
            select_image.setFromPixels(camera.getPixels(), camera.getWidth(), camera.getHeight(), OF_IMAGE_COLOR_ALPHA);
            //camera.setImageUpdated = false;
            select_image.rotate90(1);
            camera.close();
        }
        
    }
    
#pragma mark UPDATE WEB_PAGE
    
    else if(page == WEB_PAGE){
        //Add webView Setup
        
        [ofxiOSGetUIWindow() addSubview:webView.view];
        
        
        //もどるボタン(HOME)
        if(touchUpCheck(0,0,80,640) == TRUE){
            [webView test];
            page = START_PAGE;
            home_flg = FALSE;
        }
        else if(touchUpCheck(0,0,150,640) == TRUE){
            home_flg = TRUE;
        }
    }
    
    //タッチ関数をリセットする
    touch_up_point.x = -100;
    touch_up_point.y = -100;
    touch_move.x = -100;
    touch_move.y = -100;
}

//--------------------------------------------------------------
void testApp::draw(){
    
    ofBackground(255,255,255);
    ofSetColor(255,255,255);
    
#pragma mark - DRAW START_PAGE

    if(page == START_PAGE){
        
        mixcan_logo.draw(camera_bar_p.y+600,camera_bar_p.x,81,600);
        //make_bar.draw(camera_bar_p.y+150,camera_bar_p.x,81,600);
        //library_bar.draw(camera_bar_p.y,camera_bar_p.x,81,600);
        
        /*make_btn.draw(300,0,150,640);
        library_btn.draw(150,0,150,640);
        timeline_btn.draw(0,0,150,640);*/
        
        //メニューボタン描画（３つあわせて）
        menus.draw(0,0,450,640);
        //hover処理（1ボタンづつ）
        touchDownColor(300,0,150,640);
        touchDownColor(150,0,150,640);
        touchDownColor(0,0,150,640);
        
        info.draw(ofGetWidth()-140,ofGetHeight()-90,70,70);
    }

#pragma mark DRAW SHOOT_PAGE
    
    if(page == SHOOT_PAGE){
        
        if(shoot_flg == TRUE){
            ofColor(0,0,0);
            ofRect(pos.y,pos.x,square_width*2,square_width*2);
            ofColor(255,255,255);
            shoot_flg = FALSE;
        }
               
        for(int i=1; i<5; i++){
            el_x[i] = el_x[i] - (el_x[i]-el_dx[i])/2;
        }
        
        if(conbri_flg == FALSE && mix_btn_flg == FALSE){
            
            if(touchDownCheck(150/2-130/2,640/2-130/2,130,130) == TRUE){
                camera_button_push.draw(0,0,150,640);
            }
            else{
                camera_button.draw(0,0,150,640);
            }
            
            drawCheck(20,470,80,150,edit_button,50);
        }
        
        //撮影サムネイル
        blank_photos.draw(pos.y+600-ofGetHeight()/4,0,ofGetHeight()/4,ofGetHeight());
                          
        if(stock_image[1].bAllocated() == TRUE) stock_image[1].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*0,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[2].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*1,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[3].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*2,ofGetHeight()/4,ofGetHeight()/4);
        if(stock_image[1].bAllocated() == TRUE) stock_image[4].draw(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*3,ofGetHeight()/4,ofGetHeight()/4);
        
        for(int i=1;i<5;i++){
            if(flash_flg[i] == TRUE){
                flash[i]-=100;
                if(flash[i]<=50){
                    flash[i] = 0;
                    flash_flg[i] = FALSE;
                }
            }
            ofSetColor(255,255,255,flash[i]);
            ofRect(pos.y+600-ofGetHeight()/4,ofGetHeight()/4*(i-1),ofGetHeight()/4,ofGetHeight()/4);
        }
        
        if(conbri_flg == TRUE){
            
            ofSetColor(255,255,255,50);
            camera_button.draw(-1,0,150,640);
            
            ofSetColor(255,255,255,255);
            edit_button_x.draw(20,470,80,150);
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
        
        ofSetColor(255,255,255);
        if(device_number == iPhone5){
            videoTexture.draw(cam_pos.y,pos.x,square_width*2,square_width*2);
            ofSetColor(255,255,255,flash[shoot_num]);
            ofRect(cam_pos.y,pos.x,square_width*2,square_width*2);
        }
        else {
            videoTexture.draw(cam_pos.y,pos.x+square_width*0.25,square_width*1.5,square_width*1.5);
            ofSetColor(255,255,255,flash[shoot_num]);
            ofRect(cam_pos.y,pos.x,square_width*2,square_width*2);
        }
        ofSetColor(255,255,255);
        if(conbri_flg == FALSE){
            if(device_number == iPhone5) cam_pos.y = cam_pos.y - (cam_pos.y - (pos.y-ofGetHeight()/4-20))/1.6;
            else cam_pos.y = cam_pos.y - (cam_pos.y - (pos.y-ofGetHeight()/4-20+150))/1.6;
        }
        else if(conbri_flg == TRUE) cam_pos.y = cam_pos.y - (cam_pos.y - 380)/1.6;
        
        //MIXボタン
        if(stock_image[1].bAllocated() == TRUE && stock_image[2].bAllocated() == TRUE
           && stock_image[3].bAllocated() == TRUE && stock_image[4].bAllocated() == TRUE){
            drawCheck(0,0,150,640,mix_bar);
        }
        
        if(shoot_req.flg == TRUE){
            ofSetColor(255,255,255,shoot_req.alph);
            shoot_req.img.draw(shoot_req.pos.y,shoot_req.pos.x,shoot_req.height,shoot_req.width);
            edit_req.img.draw(edit_req.pos.y,edit_req.pos.x,edit_req.height,edit_req.width);
        }
        
    }
    
#pragma mark DRAW VIEW_CHECK_PAGE
    
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
        drawCheck(0,0,80,640,save_jump_button);
        
        //スワイプ奨励ボタン
        if(swipe_arrow.flg == TRUE){
            ofSetColor(255,255,255,swipe_arrow.alph);
            swipe_arrow.img.draw(swipe_arrow.pos.y,swipe_arrow.pos.x,263,194);
        }
        
    }
    
#pragma mark DRAW SAVE_PAGE
    
    else if(page == SAVE_PAGE){
        
        stripe_image_tx.draw(stripe_img_pos.y,pos.x,square_width*2,square_width*2);
        
        //まだボタンを押していない状態
        if(save_flg == FALSE && instagram_flg == FALSE && none_instagram_flg == FALSE){
            
            //save_menus（ボタンx2)
            save_menus.draw(0,0,300,640);
            
            //saveボタン（大）
            touchDownColor(0,0,150,640);
            
            //instagramボタン
            touchDownColor(150,0,150,640);
        }
        
        //いずれかの処理をした後、HOMEボタンを表示
        if(save_flg == TRUE || instagram_flg == TRUE || none_instagram_flg == TRUE){
            
            drawCheck(0,0,80,640,home_btn);
        }
        
        if(save_flg == TRUE){
            if(device_number == iPhone5) done_saving.draw(200,(640-245)/2,50,245);
            else done_saving.draw(130,(640-245)/2,50,245);
        }
        
        /*if(none_instagram_flg == TRUE){
            if(device_number == iPhone5) please.draw(200,(640-600)/2,50,600);
            else please.draw(130,(640-600)/2,50,600);
        }*/
        
        
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
                ofRect(ofGetWidth()/2-square_width+(i*slice_height*2),pos.x,slice_height*2*(flames-1),square_width*2);
            }
        }
        
        //ストライプOFFボタン
        if(move_flg == FALSE){
            ofSetColor(255,255,255,100);
            if(filter_flg == TRUE) x_btn.draw(ofGetWidth()/2+square_width-80,20,80,80);
        }
        
        ofSetColor(255,255,255,255);
        drawCheck(-1,0,80,640,photolib_btn);

    }
    
#pragma mark DRAW WEB_PAGE
    
    if(page == WEB_PAGE){
       home_btn.draw(0,0,80,640);
       touchDownColor(0,0,80,640);
    }

    
    if(page != START_PAGE && page != WEB_PAGE){
        //もどるボタン
        ofSetColor(255,255,255);
        mixcan_header.draw(pos.y+600,0,160,640);
        drawCheck(ofGetWidth()-140,20,80,150,back_button,50);
    }
    
    //cancelボタン(SHOOT_PAGEのみ）
    if(page == SHOOT_PAGE &&
       stock_image[1].bAllocated() != FALSE &&
       stock_image[4].bAllocated() != TRUE ){
        drawCheck(ofGetWidth()-140,ofGetHeight()-150-20,80,150,cancel_photo_btn,50);
    }
}


//タッチ検定
bool testApp::touchUpCheck(int x,int y,int w,int h){
    if(touch_up_point.x > x && touch_up_point.x < x+w && touch_up_point.y >y && touch_up_point.y < y+h){
        return TRUE;
    }
    else return FALSE;
}

bool testApp::touchDownCheck(int x,int y,int w,int h){
    if(touch_down_point.x > x && touch_down_point.x < x+w && touch_down_point.y >y && touch_down_point.y < y+h){
        return TRUE;
    }
    else return FALSE;
}

void testApp::touchDownColor(int x,int y,int w,int h){
    if(touchDownCheck(x,y,w,h)== TRUE){
        ofSetColor(0,0,0,20);
        ofRect(x,y,w,h);
    }
}

void testApp::drawCheck(int x,int y,int w,int h,ofImage img){
    img.draw(x,y,w,h);
    if(touchDownCheck(x,y,w,h)== TRUE){
        ofSetColor(0,0,0,20);
        ofRect(x,y,w,h);
    }
}

void testApp::drawCheck(int x,int y,int w,int h,ofImage img,ofImage img_hover){
    if(touchDownCheck(x,y,w,h)== TRUE){
        img_hover.draw(x,y,w,h);
    }
    else{
        img.draw(x,y,w,h);
    }
}

void testApp::drawCheck(int x,int y,int w,int h,ofImage img,int alpha){
    if(touchDownCheck(x,y,w,h)== TRUE){
        ofSetColor(255,255,255,alpha);
        img.draw(x,y,w,h);
    }
    else{
        ofSetColor(255,255,255,255);
        img.draw(x,y,w,h);
    }
}

bool testApp::moveCheck(int x,int y,int w,int h){
    if(touch_move.y > x && touch_move.y < x+w && touch_move.x >y && touch_move.x < y+h){
        return TRUE;
    }
    else return FALSE;
}

//--

void testApp::swipe_arrow_init(){
    
    swipe_arrow.pos.x = ofGetHeight()/2+60;
    swipe_arrow.pos.y = ofGetWidth()/2-square_width;
    swipe_arrow.pos_set.y = ofGetWidth()/2-square_width;
    swipe_arrow.d_pos.y = ofGetWidth()/2-square_width-150;
    swipe_arrow.alph = 255;
    
}

void testApp::shoot_req_init(){
    //初期の幅
    shoot_req.height = shoot_req.img.getWidth();
    //初期の高さ
    shoot_req.width = shoot_req.img.getHeight();
    //初期のx位置
    shoot_req.pos.x = ofGetHeight()/2-shoot_req.width/2;
    //初期の高さ
    shoot_req.pos.y = 150;
    //目標の高さ
    shoot_req.d_pos.y = 170;
    //alph
    shoot_req.alph = 255;
}

void testApp::edit_req_init(){
    //初期の幅
    edit_req.height = edit_req.img.getWidth();
    //初期の高さ
    edit_req.width = edit_req.img.getHeight();
    //初期のx位置
    edit_req.pos.x = 470+150/2 - edit_req.width/2;
    //初期の高さ
    edit_req.pos.y = 100;
    //目標の高さ
    edit_req.d_pos.y = 120;
    //alph
    edit_req.alph = 255;
}


void testApp::indicator_init(struct indicator indi){
    
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
    touch_down_point.x = touch.x;
    touch_down_point.y = touch.y;
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
    touch_y = touch.x;
    
    //past_touch_move.x = touch_move.x;
    //past_touch_move.y = touch_move.y;
    
    touch_move.x = touch.y;
    touch_move.y = touch.x;
    
    move_flg = TRUE;
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
    
    touch_up_point.x = touch.x;
    touch_up_point.y = touch.y;
    
    touch_down_point.x = -100;
    touch_down_point.y = -100;
    
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

