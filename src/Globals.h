//
//  Global.h
//  TouchAndAccelExample
//
//  Created by BABA TETSUAKI on 2012/10/06.
//
//

BOOL isRetina,isiPad,playingVideo,playercreated,iphone5;



class universalimage : public ofImage{
public:
	
	void loaduniversal(string url){
		
		string temp = url;
		
		if(isiPad&&isRetina){
			url.insert(url.size()-4,"_hd");
			ofImage::loadImage(url);
		}
		if(!isiPad&&!isRetina){
			url.insert(url.size()-4,"_3g");
			ofImage::loadImage(url);
		}
		if(isiPad&&!isRetina){
			url.insert(url.size()-4,"_hd");
			ofImage::loadImage(url);
			
		}
		
		if(!isAllocated())ofImage::loadImage(temp);
		
		// if(!isiPad&&isRetina)loadImage(..);
		
	}
	
	
};

