//
//  LoginViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/16/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Login", @"Login");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //_ssntxtfld.text=@"";
    //_passwordtxtfld.text=@"";
  
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
   self.navigationController.navigationBar.hidden=YES;
    
   // self.navigationItem.hidesBackButton=YES;
   [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processLogout:) name:@"logout" object:nil];
 
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationItem.hidesBackButton=YES;

_homestring=@"";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _ssntxtfld.text=@"";
    _passwordtxtfld.text=@"";
    _SSNtxtfld_iphone.text=@"";
    _passwordtxtfld_iphone.text=@"";
    _homestring=@"";
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)processLogout:(NSNotification *)aNotification{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[NSUserDefaults standardUserDefaults]
}

- (IBAction)cancelbtn_iphone:(id)sender {
    _homestring=@"";
    _SSNtxtfld_iphone.text=@"";
    _passwordtxtfld_iphone.text=@"";

}

- (IBAction)homebtn:(id)sender {
    _homestring=@"home";
    [self.navigationController popToRootViewControllerAnimated:YES];

}

#pragma mark - Textfield Delegate
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        ssnstring=_ssntxtfld.text;
        if (textField==_ssntxtfld) {
            Validation *val2=[[Validation alloc]init];
            int value1=[val2 isssnformat:_ssntxtfld.text];
            ssnstring=_ssntxtfld.text;
            if(value1==0)
            {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }

          else  if([_ssntxtfld.text isEqualToString:@""])
            {
                if ([_homestring isEqualToString:@""]) {
                    
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                }
                else
                {
                    
                }

               
                
            }
            
            
             else  if ([ssnstring length]<9) {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
                
                
            }
            else
            {
                ssnstring=_ssntxtfld.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[ssnstring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[ssnstring substringWithRange:NSMakeRange(6, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[ssnstring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                
                if ([resultString length]==11) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connectstring=resultString;
                    }
                    
                }
                if ([resultString length]<9)
                {
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }

                
                
                
                if ([resultString length]==9){
                    
                    
                    
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                    NSLog(@"%@",substring3);
                    _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectstring);
                    _ssntxtfld.text=_connectstring;
                    
                }
                
                
                
                
                
                else if ([resultString length]>=10)  {
                    
                    
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
            }
            
        }
    }
    
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        ssnstring=_SSNtxtfld_iphone.text;
        if (textField==_SSNtxtfld_iphone) {
            
           
                Validation *val2=[[Validation alloc]init];
                int value1=[val2 isssnformat:_SSNtxtfld_iphone.text];
                ssnstring=_SSNtxtfld_iphone.text;
                if(value1==0)
                {
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }

           else if([_SSNtxtfld_iphone.text isEqualToString:@""])
            {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
            
          else  if ([ssnstring length]<9) {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
                
                
            }
            
            else
            {
                ssnstring=_SSNtxtfld_iphone.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[ssnstring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[ssnstring substringWithRange:NSMakeRange(6, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[ssnstring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                
                if ([resultString length]==11) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connectstring=resultString;
                    }
                    
                }
                if ([resultString length]<9)
                {
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }
                

                
                
                if ([resultString length]==9){
                    
                    
                    
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                    NSLog(@"%@",substring3);
                    _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectstring);
                    _SSNtxtfld_iphone.text=_connectstring;
                    
                }
                
                
                
                
                
                else if ([resultString length]>=10){
                    
                    
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                
            }
        }
        
    }
    return YES;

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
       if ([alertView.message isEqualToString:@"Invalid SSN"]) {
        _ssntxtfld.text=@"";
        _SSNtxtfld_iphone.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Password does not match"]) {
        _passwordtxtfld.text=@"";
        _passwordtxtfld_iphone.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid SSN/Password"]) {
        _SSNtxtfld_iphone.text=@"";
        _ssntxtfld.text=@"";
        _passwordtxtfld.text=@"";
        _passwordtxtfld_iphone.text=@"";
        
        
    }
    
    
    
}






#pragma mark - webservice
/*webservices*/

-(void)GetApplicantId1{
    
    
    NSLog(@"length%d",[_connectstring length]);
      recordResults = FALSE;
    NSString *soapMessage;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_connectstring forKey:@"ssn"];
    [defaults synchronize];
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
         
                
         soapMessage = [NSString stringWithFormat:
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                        
                        
                        "<soap:Body>\n"
                        
                        "<GetApplicantId1 xmlns=\"http://ios.kontract360.com/\">\n"
                        "<ApplicantSSN>%@</ApplicantSSN>\n"
                         "<Password>%@</Password>\n"
                        "</GetApplicantId1>\n"
                        "</soap:Body>\n"
                        "</soap:Envelope>\n",_connectstring,_passwordtxtfld.text];
         NSLog(@"soapmsg%@",soapMessage);
         
         
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
         // NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
         
         NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
         
         NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
         
         [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
         
         [theRequest addValue: @"http://ios.kontract360.com/GetApplicantId1" forHTTPHeaderField:@"Soapaction"];
         
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
    
     else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
         
         soapMessage = [NSString stringWithFormat:
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                        
                        
                        "<soap:Body>\n"
                        
                        "<GetApplicantId1 xmlns=\"http://ios.kontract360.com/\">\n"
                        "<ApplicantSSN>%@</ApplicantSSN>\n"
                        "<Password>%@</Password>\n"
                        "</GetApplicantId1>\n"
                        "</soap:Body>\n"
                        "</soap:Envelope>\n",_connectstring,_passwordtxtfld_iphone.text];
         NSLog(@"soapmsg%@",soapMessage);
         //  NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
         
         
       NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
          // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
         
         NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
         
         NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
         
         [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
         
         [theRequest addValue:@"http://ios.kontract360.com/GetApplicantId1" forHTTPHeaderField:@"Soapaction"];
         
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
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
    
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"GetApplicantId1Response"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    
    if([elementName isEqualToString:@"applicant_Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"result"])
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
    if([elementName isEqualToString:@"applicant_Id"])
    {
        
        recordResults = FALSE;
        Applicantid=[_soapResults integerValue];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_soapResults forKey:@"app"];
        [defaults synchronize];

              
//        if (!self.firstVCtrl) {
//            _firstVCtrl=[[JobsiteViewController alloc]initWithNibName:@"JobsiteViewController" bundle:nil];
//        }
//       // _firstVCtrl.Applicantid=Applicantid;
//        [self.navigationController pushViewController:_firstVCtrl animated:YES];
        
        
        
/*Code for tabbarcontroller*/
        
        
         if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        _tabbarcntrl=[[UITabBarController alloc]init];
         _tabbarcntrl.tabBar.barTintColor=[UIColor colorWithRed:0/255.0f green:104/255.0f blue:139.0/255.0f alpha:1.0f];
            // _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
             
              [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
              // _tabbarcntrl.tabBar.barTintColor=[UIColor blueColor];
             
        
             
             [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica Neue" size:14.0f], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];
//                  [[UITabBarItem appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica Neue" size:12.0f], NSFontAttributeName,  [UIColor yellowColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
            
             
//             [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                [UIFont fontWithName:@"Helvetica Neue" size:15.0f], UITextAttributeFont,
//                                                                [UIColor blueColor], UITextAttributeTextColor,
//                                                                nil, UITextAttributeTextShadowColor,
//                                                                [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
//                                                                nil] forState:UIControlStateNormal];
//             
//             [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                [UIFont fontWithName:@"Helvetica Neue" size:15.0f], UITextAttributeFont,
//                                                                [UIColor blackColor], UITextAttributeTextColor,
//                                                                nil, UITextAttributeTextShadowColor,
//                                                                [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
//                                                                nil] forState:UIControlStateHighlighted];
//
             
          
             
    
    BasicdetailsViewController *viewController2 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController" bundle:nil];
            UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
        viewController2.Applicantid=Applicantid;
             viewController2.Availablityresult=_Availablityresult;
    EducationViewController *viewController3 = [[EducationViewController alloc] initWithNibName:@"EducationViewController" bundle:nil];
        UINavigationController *navedu=[[UINavigationController alloc]initWithRootViewController:viewController3];
        viewController3.Applicantid=Applicantid;
              viewController3.Availablityresult=_Availablityresult;
             
        
        JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController" bundle:nil];
              UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
        viewController1.Applicantid=Applicantid;
              viewController1.Availablityresult=_Availablityresult;
             
         NewMedicalViewController *viewController4 = [[ NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController" bundle:nil];
            UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController4];
        viewController4.Applicantid=Applicantid;
              viewController4.Availablityresult=_Availablityresult;
             
        EmployeeViewController*viewcontroller5=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController" bundle:nil];
            UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller5];
        viewcontroller5.Applicantid=Applicantid;
              viewcontroller5.Availablityresult=_Availablityresult;
             
        CourseDrugViewController*viewcontroller6=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController" bundle:nil];
             UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
        viewcontroller6.Applicantid=Applicantid;
              //viewcontroller6.Availablityresult=_Availablityresult;
        RaceViewController*viewcontroller7=[[RaceViewController alloc]initWithNibName:@"RaceViewController" bundle:nil];
            UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
             
             viewcontroller7.applicantId=Applicantid;
              viewcontroller7.Availablityresult=_Availablityresult;
             DocumentsViewController*viewcontroller8=[[DocumentsViewController alloc]initWithNibName:@"DocumentsViewController" bundle:nil];
            viewcontroller8.applicantid=Applicantid;
           
            UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
        NSArray *controllers = [NSArray arrayWithObjects:jobnav,basicnav,navedu,mednav,empnav,racenav,docnav,nil];
              //NSArray *controllers = [NSArray arrayWithObjects: viewController1,viewController2,viewController3,viewController4,viewcontroller5,viewcontroller6,viewcontroller7,viewcontroller8,nil];
        self.tabbarcntrl.viewControllers = controllers;
        
                  [self.navigationController pushViewController:_tabbarcntrl animated:YES];
        
         }
        
         else {
             _tabbarcntrl=[[UITabBarController alloc]init];
             //_tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
           
   
             
             BasicdetailsViewController *viewController3 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController_iphone" bundle:nil];
             UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController3];
             viewController3.Applicantid=Applicantid;
             
             UploadImageViewController*viewController2=[[UploadImageViewController alloc]initWithNibName:@"UploadImageViewController" bundle:nil];
             UINavigationController *uploadnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
             viewController2.Applicantid=Applicantid;
             EducationViewController *viewController4 = [[EducationViewController alloc] initWithNibName:@"EducationViewController_iphone" bundle:nil];
             UINavigationController *navedu=[[UINavigationController alloc]initWithRootViewController:viewController4];
             viewController4.Applicantid=Applicantid;
             JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController_iphone" bundle:nil];
             UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
             viewController1.Applicantid=Applicantid;
             NewMedicalViewController *viewController5 = [[ NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController_iphone" bundle:nil];
             UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController5];

             viewController5.Applicantid=Applicantid;
             EmployeeViewController*viewcontroller6=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController_iphone" bundle:nil];
              UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
             viewcontroller6.Applicantid=Applicantid;
             CourseDrugViewController*viewcontroller7=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController_iphone" bundle:nil];
              UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
             viewcontroller7.Applicantid=Applicantid;
             RaceViewController*viewcontroller8=[[RaceViewController alloc]initWithNibName:@"RaceViewController_iphone" bundle:nil];
             UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
             viewcontroller8.applicantId=Applicantid;
            ShowDocViewController *viewcontroller9=[[ShowDocViewController alloc]initWithNibName:@"ShowDocViewController" bundle:nil];
            viewcontroller9.applicantid=Applicantid;
             UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller9];
             NSArray *controllers = [NSArray arrayWithObjects:jobnav,uploadnav,basicnav,navedu,mednav,empnav,racenav,docnav,nil];
             self.tabbarcntrl.viewControllers = controllers;
             
             
             [self.navigationController pushViewController:_tabbarcntrl animated:YES];

             
         }
        
        
        
        _soapResults = nil;
    }
    
    
    if([elementName isEqualToString:@"result"])
    {
         recordResults = FALSE;
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    _soapResults=nil;

}
#pragma mark -Ipad Action
- (IBAction)loginbtn:(id)sender {
    
    Validation *val=[[Validation alloc]init];
    int value1=[val isBlank:_ssntxtfld.text];
    int value3=[val isssnformat:_ssntxtfld.text];
    int value2=[val isBlank:_passwordtxtfld.text];
    if (value1==0||value2==0) {
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Social Security Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        else if(value2==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        else if(value3==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
    }
    else
    {

    
    ssnstring=_ssntxtfld.text;

        
        if([_ssntxtfld.text isEqualToString:@""])
        {
            _connectstring=_ssntxtfld.text;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
   // NSLog (@"ssnstring length %d", [ssnstring length]);

    
      else if ([ssnstring length]<9) {
             _connectstring=_ssntxtfld.text;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
            
            [alert show];
            
            
            
        }
        else
        {
            ssnstring=_ssntxtfld.text;
            
            
            //checking a particular charector
            // NSString *connectstring;
            NSString*new=[ssnstring substringWithRange:NSMakeRange(3, 1)];
            NSString*new1=[ssnstring substringWithRange:NSMakeRange(6, 1)];
            
            
            
            NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
            NSString *resultString = [[ssnstring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
            NSLog (@"Result: %@", resultString);
            
            if ([resultString length]==11) {
                
                
                
                
                
                
                if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                    _connectstring=resultString;
                }
                
                
            }
            if ([resultString length]<9)
            {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }

            
                
            else if ([resultString length]==9) {
                    
                    
                    
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                    NSLog(@"%@",substring3);
                    _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectstring);
                    _ssntxtfld.text=_connectstring;
                [self GetApplicantId1];

                }
                
            
            
            
            
            else   if ([resultString length]==10)  {
                
                 _connectstring=_ssntxtfld.text;
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
           
        
//      else
//      {
//          
//          [self GetApplicantId1];
//      }

        }
    
    }

        }

- (IBAction)cancelbtn:(id)sender {
    _ssntxtfld.text=@"";
    _passwordtxtfld.text=@"";
}

#pragma mark -Iphone Actions


- (IBAction)loginbtn_iphone:(id)sender {
    
    Validation *val=[[Validation alloc]init];
    int value1=[val isBlank:_SSNtxtfld_iphone.text];
    int value3=[val isssnformat:_SSNtxtfld_iphone.text];
    int value2=[val isBlank:_passwordtxtfld_iphone.text];
    if (value1==0||value2==0) {
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Social Security Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        else if(value2==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        else if(value3==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
    }

    else
    {
    ssnstring=_SSNtxtfld_iphone.text;
    
    
    if([ssnstring isEqualToString:@""])
    {_connectstring=_SSNtxtfld_iphone.text;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
        
        [alert show];
        
    }
    //NSLog (@"ssnstring length %d", [ssnstring length]);
    
    
     else if ([ssnstring length]<9) {
        _connectstring=_SSNtxtfld_iphone.text;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
        
        [alert show];
        
        
        
    }
    else         {
        ssnstring=_SSNtxtfld_iphone.text;
        
        
        //checking a particular charector
        // NSString *connectstring;
        NSString*new=[ssnstring substringWithRange:NSMakeRange(3, 1)];
        NSString*new1=[ssnstring substringWithRange:NSMakeRange(6, 1)];
        
        
        
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *resultString = [[ssnstring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        NSLog (@"Result: %@", resultString);
        
        if ([resultString length]==11) {
            
            
            
            
            
            
            if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                _connectstring=resultString;
            }
            
            
        }
        if ([resultString length]<9)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        

        
        
       else if ([resultString length]==9) {
            
            
            
            
            NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
            NSLog(@"%@",subString);
            NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
            NSLog(@"%@",substring2);
            NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
            NSLog(@"%@",substring3);
            _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
            NSLog(@"%@",_connectstring);
            _ssntxtfld.text=_connectstring;
           [self GetApplicantId1];
            
        }
        
        
        
        
        
        else   if ([resultString length]==10)  {
            
            
            _connectstring=_SSNtxtfld_iphone.text;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
    }

       
    
}
}
-(IBAction)textfldshouldreturn:(id)sender
{
    [sender resignFirstResponder];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField==_passwordtxtfld)
    {
    NSUInteger newLength = [_passwordtxtfld.text length] + [string length] - range.length;
    return (newLength > 25) ? NO : YES;
    }
    if(textField==_passwordtxtfld_iphone)
    {
        NSUInteger newLength = [_passwordtxtfld_iphone.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if (textField==_ssntxtfld) {
        NSUInteger newLength = [_ssntxtfld.text length] + [string length] - range.length;
        return (newLength > 11) ? NO : YES;
 
    }
    if (textField==_SSNtxtfld_iphone) {
        NSUInteger newLength = [_SSNtxtfld_iphone.text length] + [string length] - range.length;
        return (newLength > 11) ? NO : YES;
        
    }

    return YES;
}

- (IBAction)logoutbtn:(id)sender {
    
 [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
