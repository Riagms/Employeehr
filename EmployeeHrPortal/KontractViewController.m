//
//  KontractViewController.m
//  EmployeeHrPortal
//
//  Created by GMSIndia1 on 11/7/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "KontractViewController.h"

@interface KontractViewController ()

@end

@implementation KontractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"Kontract360", @"Kontract360");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    [ [NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processLogout:) name:@"logout" object:nil];
}
-(void)processLogout:(NSNotification *)aNotification{
    [self.navigationController popToViewController:_vCtroller animated:YES];
    //[NSUserDefaults standardUserDefaults]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark-Webservice
-(void)CheckLogin{
    recordResults=FALSE;
    NSString*soapMessage;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        
        
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<CheckLogin xmlns=\"http://ios.kontract360.com/\">\n"
                       "<UserName>%@</UserName>\n"
                       "<Password>%@</Password>\n"
                       "</CheckLogin>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_usertxtfld.text,_passwrdtxtfld.text];
        NSLog(@"soapmsg%@",soapMessage);
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        
      // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        NSMutableURLRequest*urlRequest=[NSMutableURLRequest requestWithURL:url];
        NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
        [urlRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [urlRequest addValue:@ "http://ios.kontract360.com/CheckLogin" forHTTPHeaderField:@"Soapaction"];
        [urlRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        [urlRequest setHTTPMethod:@"POST"];
        NSURLConnection *theConnection=[[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
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
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<CheckLogin xmlns=\"http://ios.kontract360.com/\">\n"
                       "<UserName>%@</UserName>\n"
                       "<Password>%@</Password>\n"
                       "</CheckLogin>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_usernametext_iphone.text,_passwordtext_iphone.text];
        NSLog(@"soapmsg%@",soapMessage);
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        //NSURL*url=[NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
        NSMutableURLRequest*urlRequest=[NSMutableURLRequest requestWithURL:url];
        NSString *msgLength=[NSString stringWithFormat:@"%d",[soapMessage length]];
        [urlRequest addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [urlRequest addValue:@ "http://ios.kontract360.com/CheckLogin" forHTTPHeaderField:@"Soapaction"];
        [urlRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
        [urlRequest setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
        [urlRequest setHTTPMethod:@"POST"];
        NSURLConnection *theConnection=[[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
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
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"ERROR with theConenction" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
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
    if([elementName isEqualToString:@"CheckLoginResult"])
    {
        _usernamedict=[[NSMutableDictionary alloc]init];
        if(!_Soapresults)
        {
            _Soapresults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"UserId"])
    {
        if(!_Soapresults)
        {
            _Soapresults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"UserName"])
    {
        if(!_Soapresults)
        {
            _Soapresults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    
    if([elementName isEqualToString:@"Name"])
    {
        if(!_Soapresults)
        {
            _Soapresults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        
        
		[_Soapresults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"UserId"])
    {
        
        recordResults = FALSE;
        _fromid=_Soapresults;
        
        
        
        
        _Soapresults = nil;
    }
    if([elementName isEqualToString:@"UserName"])
    {
        
        recordResults = FALSE;
        
        [_usernamedict setObject:_Soapresults forKey:_fromid];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
        {
            if (!self.vCtroller) {
                self.vCtroller=[[ViewController alloc]initWithNibName:@"ViewController_iPad" bundle:nil];
                
            }
//            _userVctrl.Fromuserid=[_fromid integerValue];
//            _userVctrl.usernamedict=_usernamedict;
//            _userVctrl.username=_Soapresults;
            [self.navigationController pushViewController:self.vCtroller animated:YES];
        }
        else{
            if (!self.vCtroller) {
                self.vCtroller=[[ViewController alloc]initWithNibName:@"ViewController_iPhone" bundle:nil];
                
            }
//            _userVctrl.usernamedict=_usernamedict;
//            _userVctrl.Fromuserid=[_fromid integerValue];
//            _userVctrl.username=_Soapresults;
            [self.navigationController pushViewController:self.vCtroller animated:YES];
        }
        
        
        
        _Soapresults = nil;
        
    }
    if([elementName isEqualToString:@"result"])
    {
        
        recordResults = FALSE;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:_Soapresults delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
        _Soapresults = nil;
    }
    if([elementName isEqualToString:@"Name"])
    {
        
        recordResults = FALSE;
        _Soapresults = nil;
    }
    
    
}
#pragma Mark-Button Action

- (IBAction)login_ipad:(id)sender {
    
    [self CheckLogin];
    
    
    
}

- (IBAction)login_iphone:(id)sender {
    
    [self CheckLogin];
    
    //    if (!self.userVctrl) {
    //        self.userVctrl=[[UsersViewController alloc]initWithNibName:@"UsersViewController_iPhone" bundle:nil];
    //
    //    }
    //
    //
    //    [self.navigationController pushViewController:self.userVctrl animated:YES];
    
    
    
}
-(IBAction)returnkey:(id)sender{
    [sender resignFirstResponder];
}
@end
