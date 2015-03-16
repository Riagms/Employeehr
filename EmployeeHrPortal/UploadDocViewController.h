//
//  UploadDocViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 9/26/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Base64.h"
@class PDFImageConverter;

@interface UploadDocViewController : UIViewController<UIImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    BOOL  recordResults;
    NSInteger newx,imagechecker;
}
@property (readwrite)NSInteger applicantid;

@property (strong, nonatomic) IBOutlet UIImageView *imagepreview;

@property (strong, nonatomic)NSString*encodedstring;
/*xmlparse*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;

@property (strong, nonatomic) IBOutlet UITextField *docnametxt;


@property (strong, nonatomic) NSString*ssnstring;
@property (nonatomic) BOOL newMedia;

- (IBAction)prevewbtn:(id)sender;

- (IBAction)uploadbtn:(id)sender;

-(IBAction)previewbtn_iphone:(id)sender;
-(IBAction)uploadbtn_iphone:(id)sender;
@property(strong,nonatomic)IBOutlet UIImageView *imageview_iphone;
@property(strong,nonatomic)IBOutlet UITextField *docnameText_iphone;
//-(IBAction)textfieldreturn_iphone:(id)sender;
@property(strong,nonatomic)IBOutlet UIScrollView *scroll_iphone;
- (IBAction)closebtn:(id)sender;
@property (nonatomic) UIImagePickerController *imagePickerController;
-(IBAction)returnkey:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *uploadbtnlbl;


@end
