//
//  UploadDocViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 9/26/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "UploadDocViewController.h"
#import "PDFImageConverter.h"
@interface UploadDocViewController ()

@end

@implementation UploadDocViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"Upload Documents", @"Upload Documents");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    imagechecker=1;

    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,640)];
    // Do any additional setup after loading the view from its nib.
    
//    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
//                                   initWithTarget:self action:@selector(handlePinch:)];
//    pgr.delegate = (id)self;
//    [_imageview addGestureRecognizer:pgr];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _ssnstring = [defaults objectForKey:@"ssn"];
  

}

- (void)usecamaction
{
    //handle pinch...
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        
        
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.showsCameraControls=YES;
        
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        // imagePicker.cameraCaptureMode=YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        _newMedia = YES;
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // [self.popoverController dismissPopoverAnimated:true];
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"dict%@",info);
        _imagepreview.image=nil;
        
        
        
        _imagepreview.image =image;
        _imageview_iphone.image=image;
         [self.navigationController dismissViewControllerAnimated: YES completion: nil];
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    
    
    
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)prevewbtn:(id)sender {
    
    imagechecker=2;
    [self usecamaction];
    
   }

- (IBAction)uploadbtn:(id)sender {
    
    if (imagechecker==1) {
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Image not available to upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];

    }
    else{
    
    UIImage *Photo =_imagepreview.image;
  //  NSData *data = UIImagePNGRepresentation(imagename);
    
    // NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    CGSize pageSize = CGSizeMake(602, 668);
    CGRect imageBoundsRect =CGRectMake(10, 0, 602, 668);
//    CGSize pageSize = CGSizeMake(700, 1004);
//    CGRect imageBoundsRect =CGRectMake(200, 200, 700, 700);
    
    
    NSData *pdfData = [PDFImageConverter convertImageToPDF:Photo
                                            withResolution:50 maxBoundsRect: imageBoundsRect pageSize: pageSize];
    
    
    NSString*filename=[NSString stringWithFormat:@"%@_%@.pdf",_docnametxt.text,_ssnstring];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:filename];
    NSLog(@"path%@",path);
   
    [pdfData writeToFile:path atomically:NO];

    NSLog(@"data%@",pdfData);

    NSData*data= [NSData dataWithContentsOfFile:path];
    
    
  _encodedstring = [data base64EncodedString];
    
    if ([_docnametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Document Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        _uploadbtnlbl.enabled=NO;
    [self UploadDocs];
    }

    }
    
}

/*webservice*/

-(void)UploadDocs{
 
    newx=1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {

    recordResults = FALSE;
    NSString *soapMessage;
    
       
        
      
    NSString *imagename=[NSString stringWithFormat:@"%@_%@.pdf",_docnametxt.text,_ssnstring];
    
     
        
    // NSString *cmpnyname=@"arvin";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UploadDocsHR xmlns=\"http://ios.kontract360.com/\">\n"
                   
                   "<f>%@</f>\n"
                   "<fileName>%@</fileName>\n"
                   "<docName>%@</docName>\n"
                   "<appid>%d</appid>\n"
                   "</UploadDocsHR>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_encodedstring,imagename,_docnametxt.text,_applicantid];
          NSLog(@"soapmsg%@",soapMessage);
    	   

    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UploadDocsHR" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    }
else
    {
          newx=1;
        recordResults = FALSE;
        NSString *soapMessage;
        
        
        NSString *imagename=[NSString stringWithFormat:@"%@_%@.pdf",_docnameText_iphone.text,_ssnstring];
        
        
        // NSString *cmpnyname=@"arvin";
        
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<UploadDocs xmlns=\"http://ios.kontract360.com/\">\n"
                       
                       "<f>%@</f>\n"
                       "<fileName>%@</fileName>\n"
                       "<docName>%@</docName>\n"
                       "<appid>%d</appid>\n"
                       "</UploadDocs>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_encodedstring,imagename,_docnameText_iphone.text,_applicantid];
        NSLog(@"soapmsg%@",soapMessage);
        
        
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
         // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue:@"http://ios.kontract360.com/UploadDocs" forHTTPHeaderField:@"Soapaction"];
        
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        if( theConnection )
        {
            _webData = [NSMutableData data];
        }
        else
        {
            ////NSLog(@"theConnection is NULL");
        }

    }
    
}
-(void)selectdocs
{
      newx=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   "<soap:Body>\n"
                   "<SelectDocs xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</SelectDocs>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectDocs" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}




#pragma mark - Connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"ERROR with the Connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [Alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [_webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml===== %@",theXML);
		
	if( _xmlParser )
	{
		
	}
	
    
    if (newx==1) {
        _docnametxt.text=@"";
    //_imagepreview.image=[UIImage imageNamed:@"logo.png"];
        
        _imagepreview.image=[UIImage imageNamed:@"mNoImage"];
        imagechecker=1;
        _uploadbtnlbl.enabled=YES;

    }
    else{
        
    }
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
        }

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
       if([elementName isEqualToString:@"UploadDocsResult"])
    {
               if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
        
    
    if([elementName isEqualToString:@"RESULT"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        
        
		[_soapResults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"RESULT"])
    {
        
        recordResults = FALSE;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        _soapResults=nil;
        
    }
   }
-(IBAction)previewbtn_iphone:(id)sender
{
    [self usecamaction];
 
}
-(IBAction)uploadbtn_iphone:(id)sender
{
    UIImage *imagename =_imageview_iphone.image;
        
    
    
    CGSize pageSize = CGSizeMake(320,568);
    CGRect imageBoundsRect =CGRectMake(100, 100, 320, 568);
    
    
    NSData *pdfData = [PDFImageConverter convertImageToPDF:imagename
                                            withResolution:50 maxBoundsRect: imageBoundsRect pageSize: pageSize];
    
    
    NSString*filename=[NSString stringWithFormat:@"%@_%@.pdf",_docnameText_iphone.text,_ssnstring];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:filename];
    NSLog(@"path%@",path);
    [pdfData writeToFile:path atomically:NO];
    
    NSLog(@"data%@",pdfData);
    NSData*data= [NSData dataWithContentsOfFile:path];
    
    
    _encodedstring = [data base64EncodedString];
    [self UploadDocs];

}


- (IBAction)closebtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
  }

-(IBAction)returnkey:(id)sender{
    [sender resignFirstResponder];
}
@end
