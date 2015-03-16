//
//  EducationViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/9/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "EducationViewController.h"

@interface EducationViewController ()

@end

@implementation EducationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Education Details", @"Education Details");
        self.tabBarItem.image = [UIImage imageNamed:@"education"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [self createEducationDBTable];
    [self createcertificateDbTable];
    [self FetcheducationdetailsfromDBipad];
    [self FetchCertificateDetailsFromDBipad];
    _scroll.frame=CGRectMake(0, 0,1024, 768);
    [ _scroll setContentSize:CGSizeMake(1024,850)];
    
    _scroll_iphone.frame=CGRectMake(0, 0, 320, 548);
     [_scroll_iphone setContentSize:CGSizeMake(320,600)];
    
    
    _educationtable.layer.borderWidth = 2.0;
    _educationtable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _certificatetable.layer.borderWidth = 2.0;
    _certificatetable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _edutable_iphone.layer.borderWidth = 2.0;
    _edutable_iphone.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _certtable_iphone.layer.borderWidth = 2.0;
   _certtable_iphone.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _edunamearray=[[NSMutableArray alloc]initWithObjects:@"High School",@"College",@"Other", nil];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    
    self.navigationController.navigationBarHidden=NO;
    
}
-(void)logoutAction{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"LOGOUT" message:@"Really Logout?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ////NSLog(@"buttonIndex%d",buttonIndex);
    
    
    if ([alertView.message isEqualToString:@"Really Logout?"]) {
        
        
        
        if (buttonIndex==0) {
   
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self userInfo:nil];
        
    }
        
    }
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    
    [self SelectApplicantEducation];
    
    [self SelectApplicantCertificates];
    
   
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
   
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Popover


-(void)CreatePopover
{
    
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 200, 250)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 250)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorColor=[UIColor cyanColor];
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(200, 250);
    
    //create a popover controller
    self.popOverController
    = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(200.0f, 250.0f);
    self.popOverController=_popOverController;
    [self.popOverController presentPopoverFromRect:_edunamebtnlbl.frame
                                             inView:self.view1
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}

#pragma mark - webservice
/*webservices*/

-(void)SelectApplicantCertificates{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectApplicantCertificates xmlns=\"http://ios.kontract360.com/\">\n"
                     "<AppId>%d</AppId>\n"
                   "</SelectApplicantCertificates>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectApplicantCertificates" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)SelectApplicantEducation{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectApplicantEducation xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</SelectApplicantEducation>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectApplicantEducation" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)InsertApplicantCertificates{
     webtype=2;
    recordResults = FALSE;
    NSString *soapMessage;
    NSInteger certificateid=0;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM/dd/yyyy"];
    NSString* sqldate;
    if ([_certificatedatebtnlbl.titleLabel.text isEqualToString:@"Select"]) {
      
        sqldate=@"1990-01-01";
    }
    else{
    NSDate *dateString = [dateFormat dateFromString:_certificatedatebtnlbl.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    sqldate=[dateFormat1 stringFromDate:dateString];
    }

    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertApplicantCertificates xmlns=\"http://ios.kontract360.com/\">\n"
                  
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<CertificateId>%d</CertificateId>\n"
                   "<CertificateName>%@</CertificateName>\n"
                   "<CertificateDate>%@</CertificateDate>\n"
                   "</InsertApplicantCertificates>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,certificateid,_certifcatenametxt.text,sqldate];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/InsertApplicantCertificates" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)InsertApplicantEducation{
    webtype=1;
    NSInteger eduid=0;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertApplicantEducation xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<EduId>%d</EduId>\n"
                   "<EduName>%@</EduName>\n"
                   "<YersCompleted>%d</YersCompleted>\n"
                   "<InstituteName>%@</InstituteName>\n"
                   "<InstituteCity>%@</InstituteCity>\n"
                   "<InstituteState>%@</InstituteState>\n"
                   "</InsertApplicantEducation>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,eduid,_edunamebtnlbl.titleLabel.text,[_yearscompleted.text integerValue],_insitutionname.text,_citytxtfld.text,_statetxtfld.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/InsertApplicantEducation" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)DeleteApplicantEducation
{
    _Edumodel=(Educationdetails *)[_eduarray objectAtIndex:identifr];
    NSInteger eduwid=_Edumodel.eduid;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteApplicantEducation xmlns=\"http://ios.kontract360.com/\">\n"
                   "<EducationId>%d</EducationId>\n"
                   "<AppId>%d</AppId>\n"
                   "</DeleteApplicantEducation>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",eduwid,_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/DeleteApplicantEducation" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)DeleteApplicantCertificates
{
    certificateModel*certifictem=(certificateModel*)[_certifctearray objectAtIndex:identifr];
    NSInteger certid=certifictem.certificateid;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteApplicantCertificates xmlns=\"http://ios.kontract360.com/\">\n"
                   "<CertificateId>%d</CertificateId>\n"
                   "<AppId>%d</AppId>\n"
                   "</DeleteApplicantCertificates>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",certid,_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/DeleteApplicantCertificates" forHTTPHeaderField:@"Soapaction"];
    
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
    [_certificatetable reloadData];
    [_educationtable reloadData];
    [_edutable_iphone reloadData];
    [_certtable_iphone reloadData];
    if (webtype==2) {
        [self SelectApplicantCertificates];
        webtype=0;
    }
    if (webtype==1) {
        [self SelectApplicantEducation];
        webtype=0;
    }

    
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    
    if([elementName isEqualToString:@"SelectApplicantCertificatesResult"])
    {
        _certifctearray=[[NSMutableArray alloc]init];
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"certificate_id"])
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

    if([elementName isEqualToString:@"certificate_Name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"certificate_date"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    
    if([elementName isEqualToString:@"SelectApplicantEducationResult"])
    {
        _eduarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"education_id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"education_Name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"years_Completed"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"institute_Name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"institute_City"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"institute_State"])
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
       
    
    
    
    if([elementName isEqualToString:@"certificate_id"])
    {
        _cerifcteml=[[certificateModel alloc]init];
        recordResults = FALSE;
        _cerifcteml.certificateid=[_soapResults integerValue];
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_Id"])
    { recordResults = FALSE;
        _Applicantid=[_soapResults integerValue];
         _soapResults = nil;

    }
    
    if([elementName isEqualToString:@"certificate_Name"])
    {
        recordResults = FALSE;
        _cerifcteml.certificatename=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"certificate_date"])
    {
        recordResults = FALSE;
        NSArray *dateArray=[[NSArray alloc]init];
        dateArray=[_soapResults componentsSeparatedByString:@"T"];
        NSString *date1 =[dateArray objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dates = [dateFormat dateFromString:date1];
        [dateFormat setDateFormat:@"MM-dd-yyy"];
        NSString *myFormattedDate = [dateFormat stringFromDate:dates];
        _cerifcteml.date=myFormattedDate;
        [_certifctearray addObject:_cerifcteml];
      
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"education_id"])
    {
        _Edumodel=[[Educationdetails alloc]init];
       recordResults = FALSE;
        _Edumodel.eduid=[_soapResults integerValue];
     _soapResults = nil;
    }
    if([elementName isEqualToString:@"education_Name"])
    {
        recordResults = FALSE;
        _Edumodel.educationname=_soapResults;
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"years_Completed"])
    {
        recordResults = FALSE;
        _Edumodel.yearscompleted=[_soapResults integerValue];
        _soapResults = nil;

    }
    
    if([elementName isEqualToString:@"institute_Name"])
    {
        recordResults = FALSE;
        _Edumodel.InstituteName=_soapResults;
        _soapResults = nil;

    }
    if([elementName isEqualToString:@"institute_City"])
    {
        recordResults = FALSE;
        _Edumodel.city=_soapResults;
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"institute_State"])
    {
        recordResults = FALSE;
        _Edumodel.state=_soapResults;
        [_eduarray addObject:_Edumodel];
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"result"])
    {
        recordResults = FALSE;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        _soapResults = nil;
    }


}
#pragma mark - Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_certificatetable||tableView==_certtable_iphone) {
        return [_certifctearray count];

        
    }
    if (tableView==_educationtable||tableView==_edutable_iphone) {
        return [_eduarray count];
        
        
    }
    if (tableView==_popOverTableView) {
        return [_edunamearray count];
        
        
    }

    return YES;

    
    }
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            
        if (tableView==_certificatetable) {
        [[NSBundle mainBundle]loadNibNamed:@"EducationCertificatecell" owner:self options:nil];
        cell=_certificatecell;
         }
        if (tableView==_educationtable) {
            [[NSBundle mainBundle]loadNibNamed:@"CellEducationtable" owner:self options:nil];
            cell=_educell;
        }
        }
        
        else {
            
            
            [[NSBundle mainBundle]loadNibNamed:@"EducationCell_iphone" owner:self options:nil];
            
            cell=__educell_iphone;
            
            
        }
        
        
        
               
    }
    
    
     if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
      if (tableView==_popOverTableView) {
          cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
          cell.textLabel.font = [UIFont systemFontOfSize:12.0];

          cell.textLabel.text=[_edunamearray objectAtIndex:indexPath.row];
      }
     if (tableView==_educationtable) {
         _Edumodel=(Educationdetails *)[_eduarray objectAtIndex:indexPath.row];
         _edunamelbl=(UILabel*)[cell viewWithTag:1];
         _edunamelbl.text=_Edumodel.educationname;
         _yearslbl=(UILabel*)[cell viewWithTag:2];
         _yearslbl.text=[NSString stringWithFormat:@"%d",_Edumodel.yearscompleted];
         _institutelbl=(UILabel*)[cell viewWithTag:3];
         _institutelbl.text=_Edumodel.InstituteName;
         _citylbl=(UILabel*)[cell viewWithTag:4];
         _citylbl.text=_Edumodel.city;
         _statelbl=(UILabel*)[cell viewWithTag:5];
         _statelbl.text=_Edumodel.state;
         
         
         
         
     }
    
     if (tableView==_certificatetable) {
    certificateModel*certifictem=(certificateModel*)[_certifctearray objectAtIndex:indexPath.row];
    //cell.textLabel.text=[NSString stringWithFormat:@"%@                               %@",certifictem.certificatename,certifictem.date];
   
    _Cnamelbl=(UILabel*)[cell viewWithTag:1];
    _Cnamelbl.text=certifictem.certificatename;
    _cdatelbl=(UILabel*)[cell viewWithTag:2];
    _cdatelbl.text=certifictem.date;
    
     }
     }
    
     else{
         if (tableView==_edutable_iphone) {
               _Edumodel=(Educationdetails *)[_eduarray objectAtIndex:indexPath.row];
             _namelbl_iphone=(UILabel *)[cell viewWithTag:1];
             _namelbl_iphone.text=_Edumodel.educationname;
             _yearlbl_iphone=(UILabel *)[cell viewWithTag:2];
             _yearlbl_iphone.text=[NSString stringWithFormat:@"%d",_Edumodel.yearscompleted];
         }
         
         
         if (tableView==_certtable_iphone) {
              certificateModel*certifictem=(certificateModel*)[_certifctearray objectAtIndex:indexPath.row];
              _namelbl_iphone=(UILabel *)[cell viewWithTag:1];
             _namelbl_iphone.text=certifictem.certificatename;
              _yearlbl_iphone=(UILabel *)[cell viewWithTag:2];
              _yearlbl_iphone.text=certifictem.date;
         }
         
         
     }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_edunamebtnlbl setTitle:[_edunamearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    [self.popOverController dismissPopoverAnimated:YES];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_educationtable)
    {
    identifr=indexPath.row;
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self DeleteApplicantEducation];
        [_eduarray removeObjectAtIndex:indexPath.row];
    }
    }
    if(tableView==_certificatetable)
    {
        identifr=indexPath.row;
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            [self DeleteApplicantCertificates];
            [_certifctearray removeObjectAtIndex:indexPath.row];
        }

    }
    
    
    if (tableView==_edutable_iphone) {
        identifr=indexPath.row;
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            [self DeleteApplicantEducation];
            [_eduarray removeObjectAtIndex:indexPath.row];
        }

    }
    
    
    if (tableView==_certtable_iphone) {
        identifr=indexPath.row;
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            [self DeleteApplicantCertificates];
            [_certifctearray removeObjectAtIndex:indexPath.row];
        }

    }
}


#pragma mark - Action

- (IBAction)selecteducationbtn:(id)sender {
    [self CreatePopover];
}

- (IBAction)closebutn:(id)sender {
    _view1.hidden=YES;
    _certificatetable.userInteractionEnabled=YES;
}

- (IBAction)Addeduction:(id)sender {
    
    _view1.hidden=NO;
    _edunamebtnlbl.titleLabel.text=@"Select";
    _yearscompleted.text=@"";
    _citytxtfld.text=@"";
    _statetxtfld.text=@"";
    _insitutionname.text=@"";
    _educationtable.userInteractionEnabled=NO;
    
    
    
    
    }

- (IBAction)Addcertificate:(id)sender {
    _view2.hidden=NO;
    _certifcatenametxt.text=@"";
    _certificatedatebtnlbl.titleLabel.text=@"Select";
      _certificatetable.userInteractionEnabled=NO;
    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"MM/dd/YYYY"];
//    NSDate *date=[NSDate date];
//    NSString *dateString = [dateFormat stringFromDate:date];
//    [_certificatedatebtnlbl setTitle:dateString forState:UIControlStateNormal];
}

- (IBAction)certificataeclsebtn:(id)sender {
     _view2.hidden=YES;
      _certificatetable.userInteractionEnabled=YES;
    
}

- (IBAction)datebtn:(id)sender {
     [self createCalenderPopover];
}

- (IBAction)savebtn:(id)sender {
    if (([_certifcatenametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0))
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Certificate Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
   else if ([_certificatedatebtnlbl.titleLabel.text isEqualToString:@"Select"]||[_certificatedatebtnlbl.titleLabel.text isEqualToString:@""])
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Certificate Date is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else{

    if([_Availablityresult isEqualToString:@"Yes"])
    {
       [self InsertApplicantCertificates]; 
    }
    
    else if([_Availablityresult isEqualToString:@"No"]){
        [self createEducationDBTable];
        [self saveCertificateDatatoDB];
        [self FetchCertificateDetailsFromDBipad];
    }

    _certifcatenametxt.text=@"";
    [_certificatedatebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
}
}
- (IBAction)cancelbtn:(id)sender
{
    _certifcatenametxt.text=@"";
    [_certificatedatebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
}

- (IBAction)edusavebtn:(id)sender {
    
    if ([_edunamebtnlbl.titleLabel.text isEqualToString:@"Select"]) {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Education Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    else if (([_yearscompleted.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0))
    {
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Year is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    

    
    else{
    Validation*val=[[Validation alloc]init];
    int value1=[val isNumeric:_yearscompleted.text];
    if(value1==0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Year" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        _yearscompleted.text=@"";
    }
    else{
    
    
    if([_Availablityresult isEqualToString:@"Yes"])
    {
        [self InsertApplicantEducation];
    }
    
    else if([_Availablityresult isEqualToString:@"No"]){
       
        [self saveEduDataToDB];
        [self FetcheducationdetailsfromDBipad];
    }

   
    
    [_edunamebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
    _yearscompleted.text=@"";
    _insitutionname.text=@"";
    _citytxtfld.text=@"";
    _statetxtfld.text=@"";
    }}

}

- (IBAction)educancelbtn:(id)sender {
    [_edunamebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
    _yearscompleted.text=@"";
    _insitutionname.text=@"";
    _citytxtfld.text=@"";
    _statetxtfld.text=@"";
    
    
}

- (IBAction)deleteedubtn:(id)sender {
    
    
    
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_educationtable setEditing:NO animated:NO];
        [_educationtable reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_educationtable setEditing:YES animated:YES];
        [_educationtable reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }
    

       
}

- (IBAction)certdeletebtn:(id)sender {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_certificatetable setEditing:NO animated:NO];
        [_certificatetable reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_certificatetable setEditing:YES animated:YES];
        [_certificatetable reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }
}

  /*iphone Actions*/
- (IBAction)Addedu_iphone:(id)sender {
    _eduview=@"edu";
    if (!self.AddeduVCtrl) {
        _AddeduVCtrl=[[AddEducationViewController alloc]initWithNibName:@"AddEducationViewController" bundle:nil];
    }
    _AddeduVCtrl.Applicantid=_Applicantid;
    _AddeduVCtrl.eduview=_eduview;
    
    [self.navigationController pushViewController:_AddeduVCtrl animated:YES];
    
    }
    
- (IBAction)Addcert_iphone:(id)sender {
    _eduview=@"cert";
    if (!self.AddeduVCtrl) {
        _AddeduVCtrl=[[AddEducationViewController alloc]initWithNibName:@"AddEducationViewController" bundle:nil];
    }
    _AddeduVCtrl.eduview=_eduview;
    _AddeduVCtrl.Applicantid=_Applicantid;
    [self.navigationController pushViewController:_AddeduVCtrl animated:YES];
    
}


    
    
- (IBAction)deleteedu_iphone:(id)sender {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_edutable_iphone setEditing:NO animated:NO];
        [_edutable_iphone reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_edutable_iphone setEditing:YES animated:YES];
        [_edutable_iphone reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }
    

    }
    
- (IBAction)deletecert_iphone:(id)sender {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_certtable_iphone setEditing:NO animated:NO];
        [_certtable_iphone  reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_certtable_iphone  setEditing:YES animated:YES];
        [_certtable_iphone  reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }

    }

    
    
    
    

#pragma mark - Calendar
-(void)createCalenderPopover
{
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 300, 320)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(300, 320);
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = (id)self;
    
    
    NSDate *date = [NSDate date];
    
    // format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:date];
    //NSLog(@"datestring%@",dateString);
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    calendar.selectedDate = [self.dateFormatter dateFromString:dateString];
    
    calendar.minimumDate = [self.dateFormatter dateFromString:@"01/01/1950"];
    calendar.maximumDate =[self.dateFormatter dateFromString:dateString];
    calendar.shouldFillCalendar = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = NO;
    
    calendar.frame = CGRectMake(10, 10,300, 320);
    [popoverView addSubview:calendar];
    
    //    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //    [self.view addSubview:self.dateLabel];
    
    //  self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    //create a popover controller
    self.popOverController = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(315.0f, 330.0f);
    self.popOverController=_popOverController;
    [self.popOverController presentPopoverFromRect:_certificatedatebtnlbl.frame
                                             inView:self.view2
                           permittedArrowDirections:UIPopoverArrowDirectionRight
                                           animated:YES];
    
}




- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}



#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/YYYY"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    [_certificatedatebtnlbl setTitle:dateString forState:UIControlStateNormal];
    [self.popOverController dismissPopoverAnimated:YES];
    
}
-(IBAction)continueAction:(id)sender
{
    
//    if (!self.newmedVCtrl) {
//        _newmedVCtrl=[[NewMedicalViewController alloc]initWithNibName:@"NewMedicalViewController" bundle:nil];
//    }
//    _newmedVCtrl.Applicantid=_Applicantid;
//    [self.navigationController pushViewController:_newmedVCtrl animated:YES];

    }
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(textField==_insitutionname)
    {
    NSUInteger newLength = [_insitutionname.text length] + [string length] - range.length;
    return (newLength > 25) ? NO : YES;
    }
    if(textField==_citytxtfld)
    {
        NSUInteger newLength = [_citytxtfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_statetxtfld)
    {
        NSUInteger newLength = [_statetxtfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_certifcatenametxt)
    {
        NSUInteger newLength = [_certifcatenametxt.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    return YES;


}
#pragma mark-Sqlitedatabase
-(void)createEducationDBTable{
    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_newEmplyhrListDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS EducationData (ID INTEGER PRIMARY KEY AUTOINCREMENT, SocialSecurityNO TEXT,EducationID TEXT,EducationName TEXT,YearsCompleted TEXT,InstitutionName TEXT,EducationCity TEXT,EducationState TEXT)";
            
            
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
    
    
//}
-(void)createcertificateDbTable
{
    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_newEmplyhrListDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS CertificateData (ID INTEGER PRIMARY KEY AUTOINCREMENT, SocialSecurityNO TEXT,CertificateID TEXT,CertificateName TEXT,CertificateDate TEXT)";
            
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
    
    
//}

-(void)saveEduDataToDB{
     NSInteger eduid=0;
    //_SqlSSnstrng=_connectstring;
    sqlite3_stmt *statement;
    const char* dbpath=[_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*INSERTSql=[NSString stringWithFormat:@"INSERT INTO EducationData (SocialSecurityNO,EducationID,EducationName,YearsCompleted,InstitutionName,EducationCity,EducationState) VALUES (\"%@\",\"%d\",\"%@\",\"%d\",\"%@\",\"%@\",\"%@\")",_applicantssn,eduid,_edunamebtnlbl.titleLabel.text,[_yearscompleted.text integerValue],_insitutionname.text,_citytxtfld.text,_statetxtfld.text];
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
-(void)saveCertificateDatatoDB{
    NSInteger certificateid=0;
    //_SqlSSnstrng=_connectstring;
    sqlite3_stmt *statement;
    const char* dbpath=[_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*INSERTSql=[NSString stringWithFormat:@"INSERT INTO CertificateData (SocialSecurityNO,CertificateID,CertificateName,CertificateDate) VALUES (\"%@\",\"%d\",\"%@\",\"%@\")",_applicantssn,certificateid,_certifcatenametxt.text,_certificatedatebtnlbl.titleLabel.text];
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




-(void)FetcheducationdetailsfromDBipad
{      const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt *statement;
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"SELECT * FROM EducationData WHERE SocialSecurityNO='%@'",_applicantssn];
        const char *query_stmt=[query UTF8String];
        _eduarray=[[NSMutableArray alloc]init];
        if(sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            

                //int i=0;
                while (sqlite3_step(statement)==SQLITE_ROW) {
                _Edumodel=[[Educationdetails alloc]init];

                const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                 _Edumodel.primarykey=[pkey integerValue];
                
                const char*ssn=(const char *)sqlite3_column_text(statement, 1);
                //_Edumodel.educationname=ssn==NULL ?nil:[[NSString alloc]initWithUTF8String:ssn];
                    
                const char *educationid=(const char *)sqlite3_column_text(statement, 2);
                NSString *eid=educationid==NULL ?nil:[[NSString alloc]initWithUTF8String:educationid];
                _Edumodel.eduid=[eid integerValue];
                

                const char*educationname=(const char *)sqlite3_column_text(statement, 3);
                 _Edumodel.educationname=educationname==NULL ?nil:[[NSString alloc]initWithUTF8String:educationname];
                
                const char *yearscompleted=(const char *)sqlite3_column_text(statement, 4);
                NSString *years=yearscompleted==NULL ?nil:[[NSString alloc]initWithUTF8String:yearscompleted];
                _Edumodel.yearscompleted=[years integerValue];
                
                const char *institutionname=(const char *)sqlite3_column_text(statement, 5);
                _Edumodel.InstituteName=institutionname==NULL ?nil:[[NSString alloc]initWithUTF8String:institutionname];
                
                const char *educationcity=(const char *)sqlite3_column_text(statement, 6);
                _Edumodel.city=educationcity==NULL ?nil:[[NSString alloc]initWithUTF8String:educationcity];

                const char *educationstate=(const char *)sqlite3_column_text(statement, 7);
                _Edumodel.state=educationstate==NULL ?nil:[[NSString alloc]initWithUTF8String:educationstate];
               

                
                 [_eduarray addObject:_Edumodel];
                //i++;

            }
            
        }
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(_newEmplyhrListDB);
    [_educationtable reloadData];
    [_edutable_iphone reloadData];
}
-(void)FetchCertificateDetailsFromDBipad
{
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt *statement;
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        NSString *query=[NSString stringWithFormat:@"SELECT * FROM CertificateData WHERE SocialSecurityNO='%@'",_applicantssn];
        const char *query_stmt=[query UTF8String];
          _certifctearray=[[NSMutableArray alloc]init];
        if(sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK)
        {
            while (sqlite3_step(statement)==SQLITE_ROW) {
                _cerifcteml=[[certificateModel alloc]init];
                const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                 _cerifcteml.primarykey=[pkey integerValue];
                
                const char*ssn=(const char *)sqlite3_column_text(statement, 1);
               // _cerifcteml.educationname=ssn==NULL ?nil:[[NSString alloc]initWithUTF8String:ssn];
                
                const char *certificateid=(const char *)sqlite3_column_text(statement, 2);
                NSString *cerid=certificateid==NULL ?nil:[[NSString alloc]initWithUTF8String:certificateid];
                _cerifcteml.certificateid=[cerid integerValue];
                
                const char*certificatename=(const char *)sqlite3_column_text(statement, 3);
                _cerifcteml.certificatename=certificatename==NULL ?nil:[[NSString alloc]initWithUTF8String:certificatename];
                
                const char*certificatedate=(const char *)sqlite3_column_text(statement, 4);
                _cerifcteml.date=certificatedate==NULL ?nil:[[NSString alloc]initWithUTF8String:certificatedate];

                
                
                 [_certifctearray addObject:_cerifcteml];
                              }
            
           
        }
        sqlite3_finalize(statement);
        
    }
    sqlite3_close(_newEmplyhrListDB);
    [_certificatetable reloadData];
    [_certtable_iphone reloadData];
    
}


@end
