//
//  RegisterViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/16/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "RegisterViewController.h"


@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
     _homestring=@"";
    _Ssntxtfld.text=@"";
    _passwdtxtfld.text=@"";
    _confirmpasswrd.text=@"";
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    self.navigationController.navigationBar.hidden=YES;
    
    // self.navigationItem.hidesBackButton=YES;
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processLogout:) name:@"logout" object:nil];
    
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationItem.hidesBackButton=YES;
}
-(void)viewWillAppear:(BOOL)animated{
     _homestring=@"";
    [super viewWillAppear:animated];
   // NSTimer *timer;
    //timer=[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(Checknetavailabilty) userInfo:nil repeats:YES];
    //[self Checknetavailabilty];
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        [self createandcheckdatabaseforipad];
        //[self FetchuserdetailsfromDBforipad];

        
    }
    else{
          [self createandcheckdatabaseforiphone];
    }
    
}

//-(void)Checknetavailabilty{
//    /* for checking Connectivity*/
//    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
//    _Availablityresult = [[NSString alloc] init];
//    _Availablityresult = ( URLString != NULL ) ? @"Yes" : @"No";
//    NSLog(@"Internet connection availability : %@", _Availablityresult);
//    if ([_Availablityresult isEqualToString:@"Yes"]) {
//        //[self FetchuserdetailsfromDBforipad];
//        
//        if ([_sqliteArray count]>0) {
//            //[self SynManpowertoserver];
//        }
//        else{
//            //[self Selectallmanpower];
//        }
//        
//        
//    }
//    else if([_Availablityresult isEqualToString:@"No"]){
//      //  [self createandcheckdatabase];
//        //  [self FetchuserdetailsfromDB];
//        
//        
//    }
//    
//    
//    
//}
//
-(void)processLogout:(NSNotification *)aNotification{
    [self.navigationController popToRootViewControllerAnimated:YES];
    //[NSUserDefaults standardUserDefaults]
}

- (IBAction)cancelbtn_iphone:(id)sender {
     _homestring=@"";
    _Ssntxtfld_iphone.text=@"";
    _passwdtxtfld_iphone.text=@"";
    _confirmpasswrd_iphone.text=@"";
}

- (IBAction)cancelbtn:(id)sender {
    _Ssntxtfld.text=@"";
    _passwdtxtfld.text=@"";
    _confirmpasswrd.text=@"";
   // [self FetchuserdetailsfromDBforipad];
}

- (IBAction)homebtn:(id)sender {
    _homestring=@"home";
    alertbool=false;
    [_Ssntxtfld resignFirstResponder];
   
        [self.navigationController popToRootViewControllerAnimated:YES];

   
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continuebtn:(id)sender {
    
    Validation *val2=[[Validation alloc]init];
    int value1=[val2 isBlank:_Ssntxtfld.text];
    int value2=[val2 isBlank:_passwdtxtfld.text];
    int value3=[val2 isBlank:_confirmpasswrd.text];
    int value4=[val2 isssnformat:_Ssntxtfld.text];
    if (value1==0||value2==0||value3==0) {
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Social Security Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        
        
        else if(value2==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
        
        }
        else if(value3==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Confirm your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
            
        }
        else if(value4==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
        }

        
    }
    else if([_passwdtxtfld.text length]<8)
    {
       
        
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter atleast 5 charactors" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
    }
        

    
    else
    {
        ssnstring=_Ssntxtfld.text;
        
        
        if([_Ssntxtfld.text isEqualToString:@""])
        {
            _connectstring=_Ssntxtfld.text;
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
        // NSLog (@"ssnstring length %d", [ssnstring length]);
        
        
        else if ([ssnstring length]<9) {
            _connectstring=_Ssntxtfld.text;
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
            
            
        }

    
    else
    {
        
            ssnstring=_Ssntxtfld.text;
            
            
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
            
            
            if ([resultString length]==9) {
                
                
                
                
                NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                NSLog(@"%@",subString);
                NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                NSLog(@"%@",substring2);
                NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                NSLog(@"%@",substring3);
                _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                NSLog(@"%@",_connectstring);
                _Ssntxtfld.text=_connectstring;
                if ([_passwdtxtfld.text isEqualToString:_confirmpasswrd.text]) {
                    if ([_Availablityresult isEqualToString:@"Yes"]) {
                        
                        [self GetApplicantId2];
                        
                        
                    }
                    else if([_Availablityresult isEqualToString:@"No"]){
                        
                        [self savedatatoDBforipad];
                        [self FetchuserdetailsfromDBforipad];
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }
                else{
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password does not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    
                }

                
            }
            
            
            
            
            
            else   if ([resultString length]>=10)  {
                
                _connectstring=_Ssntxtfld.text;
                
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
    }
    
                
        
                
  
        
    
    

    
    
    
    
            }
    
    
    
    
    
    
    
    
 }

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

    if (textField==_Ssntxtfld)
    {
         ssnstring=_Ssntxtfld.text;
        Validation *val2=[[Validation alloc]init];
        int value1=[val2 isssnformat:_Ssntxtfld.text];
        ssnstring=_Ssntxtfld.text;
        if(value1==0)
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
        
        
        else if([_Ssntxtfld.text isEqualToString:@""])
        {
            if ([_homestring isEqualToString:@""]) {
                
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            }
            else
            {
                
            }
           
           
            
        }
        // NSLog (@"ssnstring length %d", [ssnstring length]);
        
        
        else if ([ssnstring length]<9) {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
            
            
        }
        else         {
            ssnstring=_Ssntxtfld.text;
            
            
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

            
            if ([resultString length]==9) {
                
                
                
                
                NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                NSLog(@"%@",subString);
                NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                NSLog(@"%@",substring2);
                NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                NSLog(@"%@",substring3);
                _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                NSLog(@"%@",_connectstring);
                _Ssntxtfld.text=_connectstring;
                
            }
            
            
            
            
            
            else   if ([resultString length]>=10)  {
                
                
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }

    }
    }
//    if (textField==_passwdtxtfld)
//        {
//            
//            if([_passwdtxtfld.text length]<5)
//            {
//                
//                
//                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password strenth is too week" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
//                
//                [alert show];
//                
//            }
//
//        }
       
    }
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        ssnstring=_Ssntxtfld_iphone.text;
        if (textField==_Ssntxtfld_iphone) {
            
            Validation *val2=[[Validation alloc]init];
            int value1=[val2 isssnformat:_Ssntxtfld_iphone.text];
            ssnstring=_Ssntxtfld_iphone.text;
            if(value1==0)
            {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
 
            
            
           else if([ssnstring isEqualToString:@""])
            {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
           // NSLog (@"ssnstring length %d", [ssnstring length]);
            
            
          else if ([ssnstring length]<9) {
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
                
                
            }
            else         {
                ssnstring=_Ssntxtfld_iphone.text;
                
                
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
                
                
                if ([resultString length]==9) {
                    
                    
                    
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
                    NSLog(@"%@",substring3);
                    _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectstring);
                    _Ssntxtfld_iphone.text=_connectstring;
                    
                }
                
                
                
                
                
                else   if ([resultString length]>=10)  {
                    
                    
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
            }
            
        }
//        if (textField==_passwdtxtfld_iphone)
//        {
//            
//            if([_passwdtxtfld_iphone.text length]<5)
//            {
//                
//                
//                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password strenth is too week" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
//                
//                [alert show];
//                
//            }
//        }
        

    }

   }





#pragma mark - webservice
/*webservices*/

-(void)GetApplicantId{
    webtype=2;
//    ssnstring=_Ssntxtfld.text;
//    NSString *subString = [ssnstring substringWithRange:NSMakeRange(0,3)];
//    NSLog(@"%@",subString);
//    NSString *substring2=[ssnstring substringWithRange:NSMakeRange(3,2)];
//    NSLog(@"%@",substring2);
//    NSString *substring3=[ssnstring substringWithRange:NSMakeRange(5,4)];
//    NSLog(@"%@",substring3);
//    NSString *connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
//    NSLog(@"%@",connectstring);

    recordResults = FALSE;
    NSString *soapMessage;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_connectstring forKey:@"ssn"];
        [defaults synchronize];

    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GetApplicantId xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantSSN>%@</ApplicantSSN>\n"
                   "<Password>%@</Password>\n"
                   "</GetApplicantId>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_connectstring,_confirmpasswrd.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
 NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://ios.kontract360.com/GetApplicantId" forHTTPHeaderField:@"Soapaction"];
    
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
 else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
 {
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     [defaults setObject:_connectstring forKey:@"ssn"];
     [defaults synchronize];
     soapMessage = [NSString stringWithFormat:
                    
                    @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                    
                    
                    "<soap:Body>\n"
                    
                    "<GetApplicantId xmlns=\"http://ios.kontract360.com/\">\n"
                    "<ApplicantSSN>%@</ApplicantSSN>\n"
                    "<Password>%@</Password>\n"
                    "</GetApplicantId>\n"
                    "</soap:Body>\n"
                    "</soap:Envelope>\n",_connectstring,_confirmpasswrd_iphone.text];
     NSLog(@"soapmsg%@",soapMessage);
     
     
   NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
      // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     
     NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
     
     NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
     
     [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
     
     [theRequest addValue:@"http://ios.kontract360.com/GetApplicantId" forHTTPHeaderField:@"Soapaction"];
     
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

-(void)GetApplicantId2{
    webtype=1;
//    ssnstring=_Ssntxtfld.text;
//    NSString *subString = [ssnstring substringWithRange:NSMakeRange(0,3)];
//    NSLog(@"%@",subString);
//    NSString *substring2=[ssnstring substringWithRange:NSMakeRange(3,2)];
//    NSLog(@"%@",substring2);
//    NSString *substring3=[ssnstring substringWithRange:NSMakeRange(5,4)];
//    NSLog(@"%@",substring3);
//    NSString *connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
//    NSLog(@"%@",connectstring);

    recordResults = FALSE;
    NSString *soapMessage;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<GetApplicantId2 xmlns=\"http://ios.kontract360.com/\">\n"
                       "<Applicantssn>%@</Applicantssn>\n"
                       
                       "</GetApplicantId2>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_connectstring];
        NSLog(@"soapmsg%@",soapMessage);
        
        
       NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        // NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue: @"http://ios.kontract360.com/GetApplicantId2" forHTTPHeaderField:@"Soapaction"];
        
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
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<GetApplicantId2 xmlns=\"http://ios.kontract360.com/\">\n"
                       "<Applicantssn>%@</Applicantssn>\n"
                      
                       "</GetApplicantId2>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_connectstring];
        NSLog(@"soapmsg%@",soapMessage);
        
        
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
         // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue:@"http://ios.kontract360.com/GetApplicantId2" forHTTPHeaderField:@"Soapaction"];
        
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
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"ERROR with theConenction" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
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
    
    
    if([elementName isEqualToString:@"applicant_Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"result"]){
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

        
        if (webtype==2) {
              if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
              {
                  _tabbarcntrl=[[UITabBarController alloc]init];
                 // _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
                  _tabbarcntrl.tabBar.barTintColor=[UIColor colorWithRed:0/255.0f green:104/255.0f blue:139.0/255.0f alpha:1.0f];
                  // _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
                  
                  [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
                  // _tabbarcntrl.tabBar.barTintColor=[UIColor blueColor];
                  
                  
                  
                  [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica Neue" size:14.0f], NSFontAttributeName,  [UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateHighlighted];

                  
                  BasicdetailsViewController *viewController2 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController" bundle:nil];
                  viewController2.Applicantid=Applicantid;
                  UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
                  viewController2.dirPaths=_dirPaths;
                  viewController2.docsDir=_docsDir;
                  viewController2.databasePath=_databasePath;
                   viewController2.sqlitessn=_SqlSSnstrng;
                  viewController2.Availablityresult=_Availablityresult;

                  EducationViewController *viewController3 = [[EducationViewController alloc] initWithNibName:@"EducationViewController" bundle:nil];
                    viewController3.Applicantid=Applicantid;
                   viewController3.Availablityresult=_Availablityresult;
                  UINavigationController *edunav=[[UINavigationController alloc]initWithRootViewController:viewController3];
                  JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController" bundle:nil];
                    viewController1.Applicantid=Applicantid;
                   viewController1.Availablityresult=_Availablityresult;
                  UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
                  NewMedicalViewController *viewController4 = [[NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController" bundle:nil];
                    viewController4.Applicantid=Applicantid;
                   viewController4.Availablityresult=_Availablityresult;
                  UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController4];
                  EmployeeViewController*viewcontroller5=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController" bundle:nil];
                    viewcontroller5.Applicantid=Applicantid;
                   viewcontroller5.Availablityresult=_Availablityresult;
                  UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller5];
                  CourseDrugViewController*viewcontroller6=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController" bundle:nil];
                    viewcontroller6.Applicantid=Applicantid;
                  //viewcontroller6.Availablityresult=_Availablityresult;
                  UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
                  RaceViewController*viewcontroller7=[[RaceViewController alloc]initWithNibName:@"RaceViewController" bundle:nil];
                    viewcontroller7.applicantId=Applicantid;
                   viewcontroller7.Availablityresult=_Availablityresult;
                  UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
                  DocumentsViewController*viewcontroller8=[[DocumentsViewController alloc]initWithNibName:@"DocumentsViewController" bundle:nil];
                 
                  UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
                  viewcontroller8.applicantid=Applicantid;
                   //viewcontroller8.Availablityresult=_Availablityresult;
                  NSArray *controllers = [NSArray arrayWithObjects:jobnav,basicnav,edunav,mednav,empnav,coursenav,racenav,docnav,nil];
                  self.tabbarcntrl.viewControllers = controllers;
                  
                  
                  [self.navigationController pushViewController:_tabbarcntrl animated:YES];
                  

              }
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
            {
                _tabbarcntrl=[[UITabBarController alloc]init];
                _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
                BasicdetailsViewController *viewController3 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController_iphone" bundle:nil];
                  viewController3.Applicantid=Applicantid;
                //viewController3.newEmplyhrListDB=_newEmplyhrListDB;
                viewController3.dirPaths=_dirPaths;
                viewController3.docsDir=_docsDir;
                viewController3.databasePath=_databasePath;
                 viewController3.sqlitessn=_SqlSSnstrng;
                viewController3.Availablityresult=_Availablityresult;

                  UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController3];
                UploadImageViewController*viewController2=[[UploadImageViewController alloc]initWithNibName:@"UploadImageViewController" bundle:nil];
                  viewController2.Applicantid=Applicantid;
                
                
                UINavigationController *uploadnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
                EducationViewController *viewController4 = [[EducationViewController alloc] initWithNibName:@"EducationViewController_iphone" bundle:nil];
                  viewController4.Applicantid=Applicantid;
                 viewController4.Availablityresult=_Availablityresult;
                UINavigationController *edunav=[[UINavigationController alloc]initWithRootViewController:viewController4];
                JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController_iphone" bundle:nil];
                  viewController1.Applicantid=Applicantid;
                 viewController1.Availablityresult=_Availablityresult;
                UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
                NewMedicalViewController *viewController5 = [[ NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController_iphone" bundle:nil];
                  viewController5.Applicantid=Applicantid;
                 viewController5.Availablityresult=_Availablityresult;
                UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController5];
                EmployeeViewController*viewcontroller6=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController_iphone" bundle:nil];
                  viewcontroller6.Applicantid=Applicantid;
                 viewcontroller6.Availablityresult=_Availablityresult;
                UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
                CourseDrugViewController*viewcontroller7=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController_iphone" bundle:nil];
                  viewcontroller7.Applicantid=Applicantid;
                 //viewcontroller7.Availablityresult=_Availablityresult;
                UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
                RaceViewController*viewcontroller8=[[RaceViewController alloc]initWithNibName:@"RaceViewController_iphone" bundle:nil];
                  viewcontroller8.applicantId=Applicantid;
                 viewcontroller8.Availablityresult=_Availablityresult;
                UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
                ShowDocViewController *viewcontroller9=[[ShowDocViewController alloc]initWithNibName:@"ShowDocViewController" bundle:nil];
                UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller9];
               
                NSArray *controllers = [NSArray arrayWithObjects:jobnav,uploadnav,basicnav,edunav,mednav,empnav,racenav,docnav,nil];
                self.tabbarcntrl.viewControllers = controllers;
                
                
                [self.navigationController pushViewController:_tabbarcntrl animated:YES];
                
            }
            
        }
        
        else{
            if (Applicantid!=0){
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Already Registered" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                                  }
        }
        

_soapResults = nil;
    }

if([elementName isEqualToString:@"result"])
{
    recordResults = FALSE;
    
    [self GetApplicantId];

       _soapResults = nil;
    
}
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:@"Already Registered"]) {
        _Ssntxtfld.text=@"";
        _passwdtxtfld.text=@"";
        _confirmpasswrd.text=@"";
                //[self.navigationController popToRootViewControllerAnimated:YES];

        
    }
    if ([alertView.message isEqualToString:@"Invalid SSN"]) {
       _Ssntxtfld.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Please enter atleast 8 characters"]) {
        _passwdtxtfld.text=@"";
         _confirmpasswrd.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid SSN"]) {
        _Ssntxtfld.text=@"";
        
        
    }


    
      }


-(IBAction)continue_iphone:(id)sender
{
    Validation *val2=[[Validation alloc]init];
    int value1=[val2 isBlank:_Ssntxtfld_iphone.text];
    int value2=[val2 isBlank:_passwdtxtfld_iphone.text];
    int value3=[val2 isBlank:_passwdtxtfld_iphone.text];
    int value4=[val2 isssnformat:_Ssntxtfld_iphone.text];
    if (value1==0||value2==0||value3==0) {
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your Social Security Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        
        
        else if(value2==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
        }
        else if(value3==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please Confirm your Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
        }
        else if(value4==0)
        {
            UIAlertView *alert2=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert2 show];
            
        }
        
        
    }
    else if([_passwdtxtfld_iphone.text length]<8)
    {
        
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter atleast 8 characters" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];
        
    }


    
else
{
    
    ssnstring=_Ssntxtfld_iphone.text;
    
    
    //checking a particular charector
    // NSString *connectstring;
    if([_Ssntxtfld.text isEqualToString:@""])
    {
        _connectstring=_Ssntxtfld_iphone.text;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Enter Your SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];
        
    }
   // NSLog (@"ssnstring length %d", [ssnstring length]);
    
    
    else if ([ssnstring length]<9) {
        _connectstring=_Ssntxtfld_iphone.text;

        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];
        
        
        
    }
    else         {
        ssnstring=_Ssntxtfld_iphone.text;
        
        
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

        
        
        if ([resultString length]==9) {
            
            
            
            
            NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
            NSLog(@"%@",subString);
            NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,2)];
            NSLog(@"%@",substring2);
            NSString *substring3=[resultString  substringWithRange:NSMakeRange(5,4)];
            NSLog(@"%@",substring3);
            _connectstring=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
            NSLog(@"%@",_connectstring);
            _Ssntxtfld_iphone.text=_connectstring;
            
            if ([_passwdtxtfld_iphone.text isEqualToString:_confirmpasswrd_iphone.text]) {
                
                [self savedatatoDBforiphone];
                [self FetchuserdetailsfromDBforiphone];
                [self GetApplicantId2];
                
                
            }
            else{
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Password does not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                
            }
            

            
        }
        
        
        
        
        
        else   if ([resultString length]==10)  {
            
            _connectstring=_Ssntxtfld_iphone.text;

            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid SSN" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
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
    if(textField==_passwdtxtfld)
    {
    NSUInteger newLength = [_passwdtxtfld.text length] + [string length] - range.length;
    return (newLength > 20) ? NO : YES;
    }
    if(textField==_confirmpasswrd)
    {
        NSUInteger newLength = [_confirmpasswrd.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_passwdtxtfld_iphone)
    {
        NSUInteger newLength = [_passwdtxtfld_iphone.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_confirmpasswrd_iphone)
    {
        NSUInteger newLength = [_confirmpasswrd_iphone.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_Ssntxtfld)
    {
        NSUInteger newLength = [_Ssntxtfld.text length] + [string length] - range.length;
        return (newLength > 11) ? NO : YES;
    }
    if(textField==_Ssntxtfld_iphone)
    {
        NSUInteger newLength = [_Ssntxtfld_iphone.text length] + [string length] - range.length;
        return (newLength > 11) ? NO : YES;
    }

    return YES;

}
#pragma mark-navigation

-(void)pushtonextpage{
    
//    sqlStmnt=[NSString stringWithFormat:@"UPDATE toDoList SET Name= \"%@\",Description=\"%@\",DueDate=\"%@\",DueTime = \"%@\" WHERE ListID= %@",txtName.text, txtDescription.text,txtDueDate.text,txtDueTime.text,deOBJ1.listID];
    

    
    if ([_Availablityresult isEqualToString:@"No"]) {
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        _tabbarcntrl=[[UITabBarController alloc]init];
        _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
        
        
        NSLog(@"pkey%@",_SqlSSnstrng);
        BasicdetailsViewController *viewController2 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController" bundle:nil];
        viewController2.Applicantid=Applicantid;
        UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
        viewController2.dirPaths=_dirPaths;
        viewController2.docsDir=_docsDir;
        viewController2.databasePath=_databasePath;
         viewController2.sqlitessn=_SqlSSnstrng;
        viewController2.sqliteArray=_sqliteArray;
        viewController2.applicantssn=_applicantssn;
        viewController2.Availablityresult=_Availablityresult;
        
        EducationViewController *viewController3 = [[EducationViewController alloc] initWithNibName:@"EducationViewController" bundle:nil];
        viewController3.Applicantid=Applicantid;
        viewController3.dirPaths=_dirPaths;
        viewController3.docsDir=_docsDir;
        viewController3.databasePath=_databasePath;
        viewController3.sqlitessn=_SqlSSnstrng;
        viewController3.sqliteArray=_sqliteArray;
        viewController3.Availablityresult=_Availablityresult;
        viewController3.applicantssn=_applicantssn;


        
        UINavigationController *edunav=[[UINavigationController alloc]initWithRootViewController:viewController3];
        JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController" bundle:nil];
        viewController1.Applicantid=Applicantid;
        viewController1.dirPaths=_dirPaths;
        viewController1.docsDir=_docsDir;
        viewController1.databasePath=_databasePath;
        viewController1.sqlitessn=_SqlSSnstrng;
        viewController1.sqliteArray=_sqliteArray;
        viewController1.Availablityresult=_Availablityresult;
        

        UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
        NewMedicalViewController *viewController4 = [[NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController" bundle:nil];
        viewController4.Applicantid=Applicantid;
        viewController4.dirPaths=_dirPaths;
        viewController4.docsDir=_docsDir;
        viewController4.databasePath=_databasePath;
        viewController4.primarykey=_SqlSSnstrng;
        viewController4.sqliteArray=_sqliteArray;
        viewController4.Availablityresult=_Availablityresult;
        
        UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController4];
        EmployeeViewController*viewcontroller5=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController" bundle:nil];
        viewcontroller5.Applicantid=Applicantid;
        viewcontroller5.dirPaths=_dirPaths;
        viewcontroller5.docsDir=_docsDir;
        viewcontroller5.databasePath=_databasePath;
        viewcontroller5.sqlitessn=_SqlSSnstrng;
        viewcontroller5.sqliteArray=_sqliteArray;
        viewcontroller5.Availablityresult=_Availablityresult;
        viewcontroller5.applicantssn=_applicantssn;


        UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller5];
        CourseDrugViewController*viewcontroller6=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController" bundle:nil];
        viewcontroller6.Applicantid=Applicantid;
        UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
        RaceViewController*viewcontroller7=[[RaceViewController alloc]initWithNibName:@"RaceViewController" bundle:nil];
        viewcontroller7.applicantId=Applicantid;
       
        viewcontroller7.dirPaths=_dirPaths;
        viewcontroller7.docsDir=_docsDir;
        viewcontroller7.databasePath=_databasePath;
        viewcontroller7.sqlitessn=_SqlSSnstrng;
        viewcontroller7.sqliteArray=_sqliteArray;
        viewcontroller7.Availablityresult=_Availablityresult;
        
        UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
        DocumentsViewController*viewcontroller8=[[DocumentsViewController alloc]initWithNibName:@"DocumentsViewController" bundle:nil];
        
        UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
        viewcontroller8.applicantid=Applicantid;
        NSArray *controllers = [NSArray arrayWithObjects:jobnav,basicnav,edunav,mednav,empnav,coursenav,racenav,docnav,nil];
        self.tabbarcntrl.viewControllers = controllers;
        
        
        [self.navigationController pushViewController:_tabbarcntrl animated:YES];
        
        
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        _tabbarcntrl=[[UITabBarController alloc]init];
        _tabbarcntrl.tabBar.tintColor=[[UIColor alloc]initWithRed:0.22 green:0.33 blue:0.52 alpha:1];
        BasicdetailsViewController *viewController3 = [[BasicdetailsViewController alloc] initWithNibName:@"BasicdetailsViewController_iphone" bundle:nil];
        viewController3.Applicantid=Applicantid;
        //viewController3.newEmplyhrListDB=_newEmplyhrListDB;
        viewController3.dirPaths=_dirPaths;
        viewController3.docsDir=_docsDir;
        viewController3.databasePath=_databasePath;
        viewController3.sqlitessn=_SqlSSnstrng;
        viewController3.applicantssn=_applicantssn;
        viewController3.Availablityresult=_Availablityresult;

        
        UINavigationController *basicnav=[[UINavigationController alloc]initWithRootViewController:viewController3];
        UploadImageViewController*viewController2=[[UploadImageViewController alloc]initWithNibName:@"UploadImageViewController" bundle:nil];
        viewController2.Applicantid=Applicantid;
        
        
        UINavigationController *uploadnav=[[UINavigationController alloc]initWithRootViewController:viewController2];
        EducationViewController *viewController4 = [[EducationViewController alloc] initWithNibName:@"EducationViewController_iphone" bundle:nil];
        viewController4.Applicantid=Applicantid;
        UINavigationController *edunav=[[UINavigationController alloc]initWithRootViewController:viewController4];
        JobsiteViewController *viewController1 = [[JobsiteViewController alloc] initWithNibName:@"JobsiteViewController_iphone" bundle:nil];
        viewController1.Applicantid=Applicantid;
        UINavigationController *jobnav=[[UINavigationController alloc]initWithRootViewController:viewController1];
        NewMedicalViewController *viewController5 = [[ NewMedicalViewController alloc] initWithNibName:@"NewMedicalViewController_iphone" bundle:nil];
        viewController5.Applicantid=Applicantid;
        UINavigationController *mednav=[[UINavigationController alloc]initWithRootViewController:viewController5];
        EmployeeViewController*viewcontroller6=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController_iphone" bundle:nil];
        viewcontroller6.Applicantid=Applicantid;
        UINavigationController *empnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller6];
        CourseDrugViewController*viewcontroller7=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController_iphone" bundle:nil];
        viewcontroller7.Applicantid=Applicantid;
        UINavigationController *coursenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller7];
        RaceViewController*viewcontroller8=[[RaceViewController alloc]initWithNibName:@"RaceViewController_iphone" bundle:nil];
        viewcontroller8.applicantId=Applicantid;
        UINavigationController *racenav=[[UINavigationController alloc]initWithRootViewController:viewcontroller8];
        ShowDocViewController *viewcontroller9=[[ShowDocViewController alloc]initWithNibName:@"ShowDocViewController" bundle:nil];
        UINavigationController *docnav=[[UINavigationController alloc]initWithRootViewController:viewcontroller9];
        
        NSArray *controllers = [NSArray arrayWithObjects:jobnav,uploadnav,basicnav,edunav,mednav,empnav,racenav,docnav,nil];
        self.tabbarcntrl.viewControllers = controllers;
        
        
        [self.navigationController pushViewController:_tabbarcntrl animated:YES];
        
    }
    }
    else if([_Availablityresult isEqualToString:@"Yes"]){
     
        
        
    }


    
}
#pragma mark -Sqlite Database for ipad
-(void)createandcheckdatabaseforipad{
    _dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir=[_dirPaths objectAtIndex:0];
    /* Build the path to the database file*/
    
    _databasePath = [[NSString alloc] initWithString: [_docsDir stringByAppendingPathComponent: @"EmployeeHrList.db"]];
    //NSLog(@"Path %@",_databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_newEmplyhrListDB) == SQLITE_OK)
        { 
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS UserList (ID INTEGER PRIMARY KEY AUTOINCREMENT, SocialSecurityNO TEXT, Password TEXT,Suffix TEXT, LastName TEXT,FirstName TEXT,HomeAddress TEXT,City TEXT, State TEXT, Zip TEXT,SSN TEXT,Country TEXT,DateOfBirth TEXT, Gender TEXT, EmailID TEXT, MobileNO TEXT, HomeNO TEXT, EmergencyContactName TEXT, ContactNO TEXT, AlternateNO TEXT, LicenceNo TEXT, StateIssueingLicence TEXT, NameInLicence TEXT,EducationID TEXT,EducationName TEXT,YearsCompleted TEXT,InstitutionName TEXT,EducationCity TEXT,EducationState TEXT,CertificateID TEXT,CertificateName TEXT,CertificateDate TEXT,PreviousID TEXT,CompanyName TEXT,EmployementDate TEXT,RateOFPay TEXT,PreviousPosition TEXT,ReasonForLeaving TEXT,FileName TEXT,EncodedString TEXT,isconvictvalue TEXT,convictExplanationText TEXT,twicnumberText TEXT,agelimitvalue  TEXT ,legalrightsvalue TEXT,workedovertimevalue  TEXT,workedearliervalue TEXT,workedperiodText TEXT,workoutoftownvalue TEXT,refferbtn TEXT,refferedagencyText TEXT,IsProtectedVeteranValue TEXT,IsDisablevalue TEXT,IsVietnamEravalue TEXT,IsActiveReservistvalue TEXT,IsDisabledVeteranvalue TEXT,IsSeperatedVeteranvalue TEXT,Medication TEXT,ClimbingAbility TEXT,JobSiteID TEXT,NCER TEXT,NCERDes TEXT,BasicPlus TEXT,DateString TEXT)";
            
            
            if (sqlite3_exec(_newEmplyhrListDB, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                
                NSLog(@"Failed to create table");
                NSLog( @"Error while inserting '%s'", sqlite3_errmsg(_newEmplyhrListDB));
            }
            sqlite3_close(_newEmplyhrListDB);
            
        }
        
        else {
            NSLog( @"Failed to open/create database");
            
        }
        
    }

    
}

-(void)savedatatoDBforipad{
    
    //_SqlSSnstrng=_connectstring;
    sqlite3_stmt *statement;
    const char* dbpath=[_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*INSERTSql=[NSString stringWithFormat:@"INSERT  INTO UserList(SocialSecurityNO,Password) VALUES (\"%@\",\"%@\")",_connectstring,_confirmpasswrd.text];
        const char *insertstmt=[INSERTSql UTF8String];
        sqlite3_prepare_v2(_newEmplyhrListDB, insertstmt, -1, &statement, NULL);
        if ((sqlite3_step(statement))==SQLITE_DONE ) {
            
            NSLog( @"UserDetail's added");
          

        
        }
        
        else{
            
               NSLog( @"Failed to add userdetails");
        }
    
    
    sqlite3_finalize(statement);
    sqlite3_close(_newEmplyhrListDB);
    }
    
}

-(void)FetchuserdetailsfromDBforipad{
    NSLog(@"path%@",_databasePath);
    _dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir=[_dirPaths objectAtIndex:0];
    /* Build the path to the database file*/
    
    _databasePath = [[NSString alloc] initWithString: [_docsDir stringByAppendingPathComponent: @"EmployeeHrList.db"]];

    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt*statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)== SQLITE_OK) {
        NSString*query=[NSString stringWithFormat:@"SELECT * FROM UserList"];
        const char *query_stmt=[query UTF8String];
        
        if (sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            _sqliteArray=[[NSMutableArray alloc]init];
            while (sqlite3_step(statement)==SQLITE_ROW) {
                _userdetails=[[UserDetails alloc]init];
                const char *key=(const char *)sqlite3_column_text(statement, 0);
                    NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                _userdetails.primarykey=[pkey integerValue];
                _SqlSSnstrng=pkey;
                
                const char *username=(const char *)sqlite3_column_text(statement, 1);
                _userdetails.ssnstring=username==NULL ?nil:[[NSString alloc]initWithUTF8String:username];
                _applicantssn=_userdetails.ssnstring;
                
                const char*password=(const char *)sqlite3_column_text(statement, 2);
                _userdetails.passwordstring=password==NULL ?nil:[[NSString alloc]initWithUTF8String:password];
                
                
                [_sqliteArray addObject:_userdetails];
                
                
            }
        }
        
            sqlite3_finalize(statement);
            
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
      [self pushtonextpage];
    
}


#pragma mark -Sqlite Database for iphone
-(void)createandcheckdatabaseforiphone{
    _dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir=[_dirPaths objectAtIndex:0];
    /* Build the path to the database file*/
    
    _databasePath = [[NSString alloc] initWithString: [_docsDir stringByAppendingPathComponent: @"EmployeeHrList.db"]];
    //NSLog(@"Path %@",_databasePath);
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_newEmplyhrListDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS UserIphoneList (ID INTEGER PRIMARY KEY AUTOINCREMENT, SocialSecurityNO TEXT, Password TEXT,Suffix TEXT, LastName TEXT,FirstName TEXT,HomeAddress TEXT,City TEXT, State TEXT, Zip TEXT,SSN TEXT,Country TEXT,DateOfBirth TEXT, Gender TEXT, EmailID TEXT, MobileNO TEXT, HomeNO TEXT, EmergencyContactName TEXT, ContactNO TEXT, AlternateNO TEXT, LicenceNo TEXT, StateIssueingLicence TEXT, NameInLicence TEXT)";
            
            
            if (sqlite3_exec(_newEmplyhrListDB, sql_stmt, NULL, NULL, &errMsg)
                != SQLITE_OK)
            {
                
                NSLog(@"Failed to create table");
                NSLog( @"Error while inserting '%s'", sqlite3_errmsg(_newEmplyhrListDB));
            }
            sqlite3_close(_newEmplyhrListDB);
            
        }
        
        else {
            NSLog( @"Failed to open/create database");
            
        }
        
    }
    
    
}

-(void)savedatatoDBforiphone{
    
    //_SqlSSnstrng=_connectstring;
    sqlite3_stmt *statement;
    const char* dbpath=[_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*INSERTSql=[NSString stringWithFormat:@"INSERT  INTO UserIphoneList(SocialSecurityNO,Password) VALUES (\"%@\",\"%@\")",_connectstring,_confirmpasswrd_iphone.text];
        const char *insertstmt=[INSERTSql UTF8String];
        sqlite3_prepare_v2(_newEmplyhrListDB, insertstmt, -1, &statement, NULL);
        if ((sqlite3_step(statement))==SQLITE_DONE ) {
            
            NSLog( @"UserDetail's added");
           
            
            
        }
        
        else{
            
            NSLog( @"Failed to add userdetails");
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(_newEmplyhrListDB);
    }
    
}

-(void)FetchuserdetailsfromDBforiphone{
    NSLog(@"path%@",_databasePath);
    _dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir=[_dirPaths objectAtIndex:0];
    /* Build the path to the database file*/
    
    _databasePath = [[NSString alloc] initWithString: [_docsDir stringByAppendingPathComponent: @"EmployeeHrList.db"]];
    
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt*statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)== SQLITE_OK) {
        NSString*query=[NSString stringWithFormat:@"SELECT * FROM UserIphoneList"];
        const char *query_stmt=[query UTF8String];
        
        if (sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            _sqliteArray=[[NSMutableArray alloc]init];
            while (sqlite3_step(statement)==SQLITE_ROW) {
                _userdetails=[[UserDetails alloc]init];
                const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                _userdetails.primarykey=[pkey integerValue];
                _SqlSSnstrng=pkey;
                
                const char *username=(const char *)sqlite3_column_text(statement, 1);
                _userdetails.ssnstring=username==NULL ?nil:[[NSString alloc]initWithUTF8String:username];
                
                const char*password=(const char *)sqlite3_column_text(statement, 2);
                _userdetails.passwordstring=password==NULL ?nil:[[NSString alloc]initWithUTF8String:password];
                
                
                [_sqliteArray addObject:_userdetails];
                
                
            }
        }
        
        sqlite3_finalize(statement);
        
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
     [self pushtonextpage];
}

@end
