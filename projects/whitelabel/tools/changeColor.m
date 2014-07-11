function changeColor

	% Read an image 
	imageRGB= im2double(imread('blubb.png'));

	% Color which will be changed 
	% purpleRGB=[0.74 0.52 0.239]; 
	% New color 
	yellowRGB=[1 1 0];

	% Convert the image to HSV space 
	imageHSV=rgb2hsv(imageRGB); 
	purpleHSV=[0.92974 0 0.80952];
	%rgb2hsv(purpleRGB); 
	yellowHSV=rgb2hsv(yellowRGB);

	% Split in Hue Saturation and Value 
	imageHue=imageHSV(:,:,1); 
	imageSaturation=imageHSV(:,:,2); 
	imageValue=imageHSV(:,:,3);

	% Calculate the difference between the colors 
	diffH=abs(imageHue-purpleHSV(1)); 
	diffS=abs(imageSaturation-purpleHSV(2)); 
	diffV=abs(imageValue-purpleHSV(3)); 
	diff=diffH+diffS*2+diffV; 
	diff=min(diff,1); 
	diff=imfilter(diff,fspecial('gaussian',[10 10],2));

	% Change the selected area to the new color 
	imageHue=imageHue.*diff+(1-diff)*yellowHSV(1); 
	diff=diff.^(1/2); 
	imageValue=imageValue.*diff+(1-diff)*yellowHSV(2); 
	imageSaturation=imageSaturation.*diff+(1-diff)*yellowHSV(3);

	% Combine the Hue Saturation and value to one matrix 
	imageHSV(:,:,1)=imageHue; 
	imageHSV(:,:,2)=imageSaturation; 
	imageHSV(:,:,3)=imageValue;

	% Go back from HSV to RGB 
	newimageRGB=hsv2rgb(imageHSV);

	imwrite (newimageRGB, "my_output_image2.png");
endfunction