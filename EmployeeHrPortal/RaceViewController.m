//
//  RaceViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/26/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "RaceViewController.h"

@interface RaceViewController ()

@end

@implementation RaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Other Details", @"Other Details");
        self.tabBarItem.image = [UIImage imageNamed:@"personal"];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self GetApplicantInformations];
    
    // Do any additional setup after loading the view from its nib.
     _convictExplanationText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    _workedperiodText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    _scrollview.frame=CGRectMake(0, 0,1024, 768);
    [ _scrollview setContentSize:CGSizeMake(1024,850)];
    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,640)];
    _refferArray=[[NSMutableArray alloc]initWithObjects:@"Contacted  on my own",@"Referred by employee",@"Company Website",@"State Employment agency",@"National Publication",@"Newspaper Advertisement",@"Private Employment agency",@"Another Company",@"Other", nil];
    _refferArray_iphone=[[NSMutableArray alloc]initWithObjects:@"Contacted  on my own",@"Referred by employee",@"Company Website",@"State Employment agency",@"National Publication",@"Newspaper Advertisement",@"Private Employment agency",@"Another Company",@"Other", nil];
self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
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

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
   
    if(_isconvictSegment.selectedSegmentIndex==0)
    {
        _isconvictvalue=1;
        _convictExplanationText.enabled=NO;
        _convictExplanationText.backgroundColor=[UIColor whiteColor];
      
    }
    else if(_isconvictSegment.selectedSegmentIndex==1)
    {
        _isconvictvalue=0;
       
        _convictExplanationText.enabled=YES;
        _convictExplanationText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    }
    if(_agelimitsegment.selectedSegmentIndex==0)
    {
        _agelimitvalue=1;
    }
    else if(_agelimitsegment.selectedSegmentIndex==1)
    {
        _agelimitvalue=0;
    }
    if(_legalsrightssegment.selectedSegmentIndex==0)
    {
        _legalrightsvalue=1;
    }
    else if(_legalsrightssegment.selectedSegmentIndex==1)
    {
        _legalrightsvalue=0;
    }
    if(_workovertimesegment.selectedSegmentIndex==0)
    {
        _workedovertimevalue=1;
    }
    else if(_workovertimesegment.selectedSegmentIndex==1)
    {
        _workedovertimevalue=0;
    }
    if(_workedearliersegment.selectedSegmentIndex==0)
    {
        _workedearliervalue=1;
        
        _workedperiodText.enabled=NO;
        _workedperiodText.backgroundColor=[UIColor whiteColor];
    }
    else if(_workedearliersegment.selectedSegmentIndex==1)
    {
        _workedearliervalue=0;
        _workedperiodText.enabled=YES;
        _workedperiodText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];

    }
    
    if(_workoutoftownSegment.selectedSegmentIndex==0)
    {
        _workoutoftownvalue=1;
    }
    else if(_workoutoftownSegment.selectedSegmentIndex==1)
    {
        _workoutoftownvalue=0;
    }
    
    if(_IsProtectedVeteransegment.selectedSegmentIndex==0)
    {
        _IsProtectedVeteranValue=1;
    }
    else if(_IsProtectedVeteransegment.selectedSegmentIndex==1)
    {
        _IsProtectedVeteranValue=0;
    }
    if(_isdisableSegment.selectedSegmentIndex==0)
    {
        _IsDisablevalue=1;
    }
    else if(_isdisableSegment.selectedSegmentIndex==1)
    {
        _IsDisablevalue=0;
    }
    if(_IsVietnamEraSegment.selectedSegmentIndex==0)
    {
        _IsVietnamEravalue=1;
    }
    else if(_IsVietnamEraSegment.selectedSegmentIndex==1)
    {
        _IsVietnamEravalue=0;
    }
    if(_IsActiveReservistSegment.selectedSegmentIndex==0)
    {
        _IsActiveReservistvalue=1;
    }
    else if(_IsActiveReservistSegment.selectedSegmentIndex==1)
    {
        _IsActiveReservistvalue=0;
    }
    if(_IsDisabledVeteranSegment.selectedSegmentIndex==0)
    {
        _IsDisabledVeteranvalue=1;
    }
    else if(_IsDisabledVeteranSegment.selectedSegmentIndex==1)
    {
        _IsDisabledVeteranvalue=0;
    }
    
    if(_IsSeperatedVeteranSegment.selectedSegmentIndex==0)
    {
        _IsSeperatedVeteranvalue=1;
    }
    else if(_IsSeperatedVeteranSegment.selectedSegmentIndex==1)
    {
        _IsSeperatedVeteranvalue=0;
    }
    

    if ([_Availablityresult isEqualToString:@"Yes"]) {
        
        [self UpdateApplicantInformations];

        
        
        
    }
    else if([_Availablityresult isEqualToString:@"No"]){
        
        
               
        
    }
    
    

    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)UpdateApplicantInformations
{
    recordResults = FALSE;
    NSString *soapMessage;
   
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateApplicantInformations xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<IsConvict>%d</IsConvict>\n"
                   "<ConvictExplanation>%@</ConvictExplanation>\n"
                   "<TWICNumber>%@</TWICNumber>\n"
                   "<AgeLimit>%d</AgeLimit>\n"
                   "<LegelRights>%d</LegelRights>\n"
                   "<WorkedOverTime>%d</WorkedOverTime>\n"
                   "<WorkedEarlier>%d</WorkedEarlier>\n"
                   "<WorkedPeriod>%@</WorkedPeriod>\n"
                   "<WorkOutofTown>%d</WorkOutofTown>\n"
                   "<Referred>%@</Referred>\n"
                   "<ReferredAgency>%@</ReferredAgency>\n"
                   "<IsProtectedVeteran>%d</IsProtectedVeteran>\n"
                   "<IsDisable>%d</IsDisable>\n"
                   "<IsVietnamEra>%d</IsVietnamEra>\n"
                   "<IsActiveReservist>%d</IsActiveReservist>\n"
                   "<IsDisabledVeteran>%d</IsDisabledVeteran>\n"
                   "<IsSeperatedVeteran>%d</IsSeperatedVeteran>\n"
                   "</UpdateApplicantInformations>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_applicantId,_isconvictvalue,_convictExplanationText.text,_twicnumberText.text,_agelimitvalue,_legalrightsvalue,_workedovertimevalue,_workedearliervalue,_workedperiodText.text,_workoutoftownvalue,_refferbtn.titleLabel.text,_refferedagencyText.text,_IsProtectedVeteranValue,_IsDisablevalue,_IsVietnamEravalue,_IsActiveReservistvalue,_IsDisabledVeteranvalue,_IsSeperatedVeteranvalue];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantInformations" forHTTPHeaderField:@"Soapaction"];
    
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
    
-(void)GetApplicantInformations
{
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GetApplicantInformations xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</GetApplicantInformations>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_applicantId];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/GetApplicantInformations" forHTTPHeaderField:@"Soapaction"];
    
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
       
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"GetApplicantInformationsResult"])
    {
       
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_Isconvicted"])
    {
              if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_explanationofConvict"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_TWIC"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_AgeLimit"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"applicant_LegalRights"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"applicant_OverTime"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_WorkedEarlier"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_WorkedPeriod"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"applicant_workOutofTown"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"applicant_referred"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"applicant_referredAgency"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    

    
    if([elementName isEqualToString:@"applicant_IsProtectedVeteran"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    

    if([elementName isEqualToString:@"applicant_IsDisable"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"applicant_IsVietnamera"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    


    if([elementName isEqualToString:@"applicant_IsActivereservist"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    

    if([elementName isEqualToString:@"applicant_IsdisableVeteran"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"applicant_IsSeperatedVeteran"])
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
    if([elementName isEqualToString:@"applicant_Isconvicted"])
    {
        _ethmdl=[[Ethicity alloc]init];
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.isConvicted=1;
            _isconvictSegment.selectedSegmentIndex=0;
            _isconvictSegment_iphone.selectedSegmentIndex=0;

            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.isConvicted=0;
            _isconvictSegment.selectedSegmentIndex=1;
             _isconvictSegment_iphone.selectedSegmentIndex=1;
            
        }

        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_explanationofConvict"])
    {
               recordResults = FALSE;
        if([_soapResults isEqualToString:@"(null)"])
        {
            _convictExplanationText.text=@"";
             _convictExplanationText_iphone.text=@"";
            _ethmdl.convictexplanation=@"";
        }
        else
        {
        _ethmdl.convictexplanation=_soapResults;
        _convictExplanationText.text=_soapResults;
        _convictExplanationText_iphone.text=_soapResults;
        }
        _soapResults = nil;
    }

    
    if([elementName isEqualToString:@"applicant_TWIC"])
    {
        recordResults = FALSE;
        if([_soapResults isEqualToString:@"(null)"])
        {
            _ethmdl.twiccardno=@"";
            _twicnumberText.text=@"";
            _twicnumberText_iphone.text=@"";
        }
        else
        {
        _ethmdl.twiccardno=_soapResults;
        _twicnumberText.text=_soapResults;
        _twicnumberText_iphone.text=_soapResults;
        }
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_EmergencyContactNo"])
    {
        recordResults = FALSE;
        _soapResults = nil;
    }
    

    
    if([elementName isEqualToString:@"applicant_AgeLimit"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.agelimit=1;
            _agelimitsegment.selectedSegmentIndex=0;
            _agelimitsegment_iphone.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.agelimit=0;
            _agelimitsegment.selectedSegmentIndex=1;
            _agelimitsegment_iphone.selectedSegmentIndex=1;
        }
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_LegalRights"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.legalrights=1;
            _legalsrightssegment.selectedSegmentIndex=0;
             _legalsrightssegment_iphone.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.legalrights=0;
            _legalsrightssegment.selectedSegmentIndex=1;
            _legalsrightssegment_iphone.selectedSegmentIndex=1;
        }
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_LegalRights"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.legalrights=1;
            _legalsrightssegment.selectedSegmentIndex=0;
            _legalsrightssegment_iphone.selectedSegmentIndex=0;
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.legalrights=0;
            _legalsrightssegment.selectedSegmentIndex=1;
             _legalsrightssegment_iphone.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_OverTime"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.WorkOverTime=1;
            _workovertimesegment.selectedSegmentIndex=0;
            _workovertimesegment_iphone.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.WorkOverTime=0;
            _workovertimesegment.selectedSegmentIndex=1;
            _workovertimesegment_iphone.selectedSegmentIndex=1;
        }
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_WorkedEarlier"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.WorkedEarlier=1;
            _workedearliersegment.selectedSegmentIndex=0;
             _workedearliersegment_iphone.selectedSegmentIndex=0;
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.WorkedEarlier=0;
            _workedearliersegment.selectedSegmentIndex=1;
            _workedearliersegment_iphone.selectedSegmentIndex=1;
        }
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_WorkedPeriod"])
    {
        
        recordResults = FALSE;
        
        if([_soapResults isEqualToString:@"(null)"])
        {
            _workedperiodText.text=@"";
            _workedperiodText_iphone.text=@"";
            _ethmdl.WorkedPeriod=@"";

        }
        else
        {
        _workedperiodText.text=_soapResults;
        _workedperiodText_iphone.text=_soapResults;
        _ethmdl.WorkedPeriod=_soapResults;
        }
        _soapResults = nil;
    }

    
    if([elementName isEqualToString:@"applicant_workOutofTown"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.WorkedOutofTown=1;
            _workoutoftownSegment.selectedSegmentIndex=0;
             _workoutoftownSegment_iphone.selectedSegmentIndex=0;
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.WorkedOutofTown=0;
            _workoutoftownSegment.selectedSegmentIndex=1;
            _workoutoftownSegment_iphone.selectedSegmentIndex=1;
        }
        
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"applicant_referred"])
    {
        
        recordResults = FALSE;
        if([_soapResults isEqualToString:@"(null)"])
        {
            [_refferbtn setTitle:@"" forState:UIControlStateNormal];
            [_reffertext_iphone setTitle:@"" forState:UIControlStateNormal];
            _ethmdl.reffered=@"";
        }
        else
        {
        [_refferbtn setTitle:_soapResults forState:UIControlStateNormal];
       [_reffertext_iphone setTitle:_soapResults forState:UIControlStateNormal];
        _ethmdl.reffered=_soapResults;
        }
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_referredAgency"])
    {
        
        recordResults = FALSE;
        if([_soapResults isEqualToString:@"(null)"])
        {
            _refferedagencyText.text=@"";
            _refferedagencyText_iphone.text=@"";
            _ethmdl.reffereagency=@"";

        }
        else
        {
        _refferedagencyText.text=_soapResults;
        _refferedagencyText_iphone.text=_soapResults;
        _ethmdl.reffereagency=_soapResults;
        }
        _soapResults = nil;
    }


    
    if([elementName isEqualToString:@"applicant_IsProtectedVeteran"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsProtectedVeteran=1;
            _IsProtectedVeteransegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsProtectedVeteran=0;
            _IsProtectedVeteransegment.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_IsDisable"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsDisable=1;
            _isdisableSegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsDisable=0;
            _isdisableSegment.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }
    

    
    if([elementName isEqualToString:@"applicant_IsVietnamera"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsVietnamEra=1;
            _IsVietnamEraSegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsVietnamEra=0;
            _IsVietnamEraSegment.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_IsActivereservist"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsActiveReservist=1;
            _IsActiveReservistSegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsActiveReservist=0;
            _IsActiveReservistSegment.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_IsdisableVeteran"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsDisbledVeteran=1;
            _IsDisabledVeteranSegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsDisbledVeteran=0;
            _IsDisabledVeteranSegment.selectedSegmentIndex=1;
            
        }
        
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"applicant_IsSeperatedVeteran"])
    {
        
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"true"]) {
            _ethmdl.IsSeperatedVeteran=1;
            _IsSeperatedVeteranSegment.selectedSegmentIndex=0;
            
        }
        else if ([_soapResults isEqualToString:@"false"]){
            _ethmdl.IsSeperatedVeteran=0;
            _IsSeperatedVeteranSegment.selectedSegmentIndex=1;
            
        }
        
        
        
        _soapResults = nil;
    }


    
}

-(IBAction)submitAction:(id)sender
{
    if(_isconvictSegment.selectedSegmentIndex==0)
    {
        _isconvictvalue=1;
    }
    else if(_isconvictSegment.selectedSegmentIndex==1)
    {
        _isconvictvalue=0;
    }
    if(_agelimitsegment.selectedSegmentIndex==0)
    {
        _agelimitvalue=1;
    }
    else if(_agelimitsegment.selectedSegmentIndex==1)
    {
        _agelimitvalue=0;
    }
    if(_legalsrightssegment.selectedSegmentIndex==0)
    {
        _legalrightsvalue=1;
    }
    else if(_legalsrightssegment.selectedSegmentIndex==1)
    {
        _legalrightsvalue=0;
    }
    if(_workovertimesegment.selectedSegmentIndex==0)
    {
        _workedovertimevalue=1;
    }
    else if(_workovertimesegment.selectedSegmentIndex==1)
    {
        _workedovertimevalue=0;
    }
    if(_workedearliersegment.selectedSegmentIndex==0)
    {
        _workedearliervalue=1;
    }
    else if(_workedearliersegment.selectedSegmentIndex==1)
    {
        _workedearliervalue=0;
    }

    if(_workoutoftownSegment.selectedSegmentIndex==0)
    {
        _workoutoftownvalue=1;
    }
    else if(_workoutoftownSegment.selectedSegmentIndex==1)
    {
        _workoutoftownvalue=0;
    }

    if(_IsProtectedVeteransegment.selectedSegmentIndex==0)
    {
        _IsProtectedVeteranValue=1;
    }
    else if(_IsProtectedVeteransegment.selectedSegmentIndex==1)
    {
        _IsProtectedVeteranValue=0;
    }
    if(_isdisableSegment.selectedSegmentIndex==0)
    {
        _IsDisablevalue=1;
    }
    else if(_isdisableSegment.selectedSegmentIndex==1)
    {
        _IsDisablevalue=0;
    }
    if(_IsVietnamEraSegment.selectedSegmentIndex==0)
    {
        _IsVietnamEravalue=1;
    }
    else if(_IsVietnamEraSegment.selectedSegmentIndex==1)
    {
        _IsVietnamEravalue=0;
    }
    if(_IsActiveReservistSegment.selectedSegmentIndex==0)
    {
        _IsActiveReservistvalue=1;
    }
    else if(_IsActiveReservistSegment.selectedSegmentIndex==1)
    {
        _IsActiveReservistvalue=0;
    }
    if(_IsDisabledVeteranSegment.selectedSegmentIndex==0)
    {
        _IsDisabledVeteranvalue=1;
    }
    else if(_IsDisabledVeteranSegment.selectedSegmentIndex==1)
    {
        _IsDisabledVeteranvalue=0;
    }

    if(_IsSeperatedVeteranSegment.selectedSegmentIndex==0)
    {
        _IsSeperatedVeteranvalue=1;
    }
    else if(_IsSeperatedVeteranSegment.selectedSegmentIndex==1)
    {
        _IsSeperatedVeteranvalue=0;
    }

    
    if ([_Availablityresult isEqualToString:@"Yes"]) {
        
        [self UpdateApplicantInformations];
        
        
    }
    else if([_Availablityresult isEqualToString:@"No"]){
        
        [self saveOthersDatatoDBipad];

        
    }
    


    
    
}

-(IBAction)selectreffer:(id)sender
{
    [self createPopover];
}
-(void)createPopover
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
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(200.0f, 250.0f);
    self.popOverController1=_popOverController1;
    [self.popOverController1 presentPopoverFromRect:_refferbtn.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
           
        
  
    
    return [_refferArray count];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        
    }
    
            
        cell.textLabel.text=[_refferArray objectAtIndex:indexPath.row];
          
       return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_refferbtn setTitle:[_refferArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [self.popOverController1 dismissPopoverAnimated:YES];
}


- (IBAction)nextbtn:(id)sender {
    if(_isconvictSegment_iphone.selectedSegmentIndex==0)
    {
        _isconvictvalue=1;
    }
    else if(_isconvictSegment_iphone.selectedSegmentIndex==1)
    {
        _isconvictvalue=0;
    }
    if(_agelimitsegment_iphone.selectedSegmentIndex==0)
    {
        _agelimitvalue=1;
    }
    else if(_agelimitsegment_iphone.selectedSegmentIndex==1)
    {
        _agelimitvalue=0;
    }
    if(_legalsrightssegment_iphone.selectedSegmentIndex==0)
    {
        _legalrightsvalue=1;
    }
    else if(_legalsrightssegment_iphone.selectedSegmentIndex==1)
    {
        _legalrightsvalue=0;
    }
    if(_workovertimesegment_iphone.selectedSegmentIndex==0)
    {
        _workedovertimevalue=1;
    }
    else if(_workovertimesegment_iphone.selectedSegmentIndex==1)
    {
        _workedovertimevalue=0;
    }
    if(_workedearliersegment_iphone.selectedSegmentIndex==0)
    {
        _workedearliervalue=1;
    }
    else if(_workedearliersegment_iphone.selectedSegmentIndex==1)
    {
        _workedearliervalue=0;
    }
    
    if(_workoutoftownSegment_iphone.selectedSegmentIndex==0)
    {
        _workoutoftownvalue=1;
    }
    else if(_workoutoftownSegment_iphone.selectedSegmentIndex==1)
    {
        _workoutoftownvalue=0;
    }
    _racemdl=[[racemdl alloc]init];
    _racemdl.isConvicted=_isconvictvalue;
    _racemdl.agelimit=_agelimitvalue;
    _racemdl.legalrights=_legalrightsvalue;
    _racemdl.WorkOverTime=_workedovertimevalue;
    _racemdl.WorkedEarlier=_workedearliervalue;
    _racemdl.WorkedOutofTown=_workoutoftownvalue;
    _racemdl.convictexplanation=_convictExplanationText_iphone.text;
    _racemdl.twiccardno=_twicnumberText_iphone.text;
    _racemdl.WorkedPeriod=_workedperiodText_iphone.text;
    _racemdl.reffered=_reffertext_iphone.titleLabel.text;
    _racemdl.reffereagency=_refferedagencyText_iphone.text;
    if (!self.secondVCtrl) {
        _secondVCtrl=[[SecondRaceViewController alloc]initWithNibName:@"SecondRaceViewController" bundle:nil];
    }
    _secondVCtrl.race1=_racemdl;
    _secondVCtrl.applicantId=_applicantId;
    _secondVCtrl.ethicity1=_ethmdl;
    [self.navigationController pushViewController:_secondVCtrl animated:YES];
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
           return [_refferArray_iphone count];
      
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
   
   
        return [_refferArray_iphone objectAtIndex:row];
      
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{  
    [_reffertext_iphone setTitle:[_refferArray_iphone objectAtIndex:row] forState:UIControlStateNormal];
        _refferpicker_iphone.hidden=YES;
        
      
}
- (IBAction)refferselect:(id)sender
{
     _refferpicker_iphone.hidden=NO;
    [_refferpicker_iphone reloadAllComponents];
}
-(IBAction)textfieldshouldreturn:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)convictedsegmt:(id)sender {
    
    if(_isconvictSegment.selectedSegmentIndex==0)
    {
        _convictExplanationText.enabled=NO;
        _convictExplanationText.backgroundColor=[UIColor whiteColor];
      
    }
    else if(_isconvictSegment.selectedSegmentIndex==1)
    {
        
        _convictExplanationText.enabled=YES;
        _convictExplanationText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
       
    }

    
}

- (IBAction)cmpnysgmnt:(id)sender {
    if(_workedearliersegment.selectedSegmentIndex==0)
    {
        _workedperiodText.enabled=NO;
        _workedperiodText.backgroundColor=[UIColor whiteColor];

    }
    else if(_workedearliersegment.selectedSegmentIndex==1)
    {
        _workedperiodText.enabled=YES;
        _workedperiodText.backgroundColor=[[UIColor alloc]initWithRed:204/255.0f green:204/255.0f blue:204/255.0f alpha:1];
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(textField==_workedperiodText)
    {
    NSUInteger newLength = [_workedperiodText.text length] + [string length] - range.length;
    return (newLength > 50) ? NO : YES;
    }
    if(textField==_convictExplanationText)
    {
        NSUInteger newLength = [_convictExplanationText.text length] + [string length] - range.length;
        return (newLength > 100) ? NO : YES;
    }
    if(textField==_twicnumberText)
    {
        NSUInteger newLength = [_twicnumberText.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    if(textField==_refferedagencyText)
    {
        NSUInteger newLength = [_refferedagencyText.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    
        if(textField==_workedperiodText_iphone)
        {
            NSUInteger newLength = [_workedperiodText_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }
        if(textField==_convictExplanationText_iphone)
        {
            NSUInteger newLength = [_convictExplanationText_iphone.text length] + [string length] - range.length;
            return (newLength > 100) ? NO : YES;
        }
        if(textField==_twicnumberText_iphone)
        {
            NSUInteger newLength = [_twicnumberText_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }
        
        if(textField==_refferedagencyText_iphone)
        {
            NSUInteger newLength = [_refferedagencyText_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }

        }


#pragma mark-Sqlite DB for ipad

-(void)saveOthersDatatoDBipad{
    
    
    sqlite3_stmt *statement;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        NSString *updateSql=[NSString stringWithFormat:@"UPDATE UserList SET isconvictvalue= \"%d\",convictExplanationText=\"%@\",twicnumberText=\"%@\",agelimitvalue = \"%d\",legalrightsvalue = \"%d\",workedovertimevalue= \"%d\",workedearliervalue= \"%d\",workedperiodText= \"%@\",workoutoftownvalue= \"%d\",refferbtn= \"%@\",refferedagencyText= \"%@\",IsProtectedVeteranValue= \"%d\",IsDisablevalue= \"%d\",IsVietnamEravalue= \"%d\",IsActiveReservistvalue= \"%d\",IsDisabledVeteranvalue= \"%d\",IsSeperatedVeteranvalue= \"%d\" WHERE ID= %@",_isconvictvalue,_convictExplanationText.text,_twicnumberText.text,_agelimitvalue,_legalrightsvalue,_workedovertimevalue,_workedearliervalue,_workedperiodText.text,_workoutoftownvalue,_refferbtn.titleLabel.text,_refferedagencyText.text,_IsProtectedVeteranValue,_IsDisablevalue,_IsVietnamEravalue,_IsActiveReservistvalue,_IsDisabledVeteranvalue,_IsSeperatedVeteranvalue,_sqlitessn];
        
        NSLog(@"updatesql%@",updateSql);
        const char *update_stmt=[updateSql UTF8String];
       sqlite3_prepare(_newEmplyhrListDB, update_stmt, -1, &statement, NULL);
        
        
        if(sqlite3_step(statement)==SQLITE_DONE)
        {
            
            NSLog( @"UserDetail's updated");
        }
        
        else{
            
            NSLog( @"Failed to add update");
        }
        
        
        sqlite3_finalize(statement);
        sqlite3_close(_newEmplyhrListDB);
    }

}
-(void)fetchothersDataDBipad{
    
}

@end
