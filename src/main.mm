#include "ofMain.h"
#include "testApp.h"
#include "Globals.h"

int main(){
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
		if ([[UIScreen mainScreen] scale] > 1)
			isRetina = true;
	}
	
	if ([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)])
		if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
			isiPad = true;
	
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale > 1)
	{
		isRetina = true;
		isiPad = true;
		
	}
	
	[pool release];
	
	int width;
	int height;
	
	if (isRetina && isiPad){
		width = 1536;
		height = 2048;
	}
	else if (!isRetina && !isiPad){
		width = 320;
		height = 480;
	}
	else if (isRetina && !isiPad){
		width = 640;
		height = 960;
	}
	else if (!isRetina && isiPad){
		width = 768;
		height = 1024;
	}
	
	if ([ [ UIScreen mainScreen ] bounds ].size.height == 568){
		iphone5 = true;
		width = 640;
		height = 1136;
		
	}else{iphone5=false;
		
	}
	
	printf("size:%d,%d\n", width, height);
	
	ofAppiOSWindow * iOSWindow = new ofAppiOSWindow();
	ofSetupOpenGL(iOSWindow, width, height, OF_FULLSCREEN);
	iOSWindow->enableRetina();
	
	//ofSetupOpenGL(1024, 768, OF_FULLSCREEN);
	ofRunApp(new testApp);
}
