//
//  EmployeeViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/25/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Previous Employer",@"Previous Employer");
        self.tabBarItem.image = [UIImage imageNamed:@"personal"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _scroll.frame=CGRectMake(0, 0,1024, 768);
    [ _scroll setContentSize:CGSizeMake(1024,850)];
    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,640)];
    _datepicker_iphone.hidden=YES;
    _addview_iphone.hidden=YES;
    _empdatetextfld_iphone.inputView=[[UIView alloc]initWithFrame:CGRectZero];
    _prevousEmpTable.layer.borderWidth = 2.0;
    _prevousEmpTable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _previousemptable_iphone.layer.borderWidth = 2.0;
    _previousemptable_iphone.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    [self selectApplicantPreviousEmployer];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationController.navigationBarHidden=NO;
    [self createandcheckdatabaseipad];
 
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
        if ([alertView.message isEqualToString:@"Invalid rate"]) {
            
            _rateofpaytxt.text=@"";
            
         
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SavePreviousemployee:(id)sender
{
    
    if ([_previouscompanytxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Company Name is Required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert1 show];
    }
   else if ([_rateofpaytxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Rate of pay is Required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert1 show];
    }

    else{
    Validation*val=[[Validation alloc]init];
    int value1=[val isNumeric:_rateofpaytxt.text];
    
    if(value1==0)
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid rate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert1 show];
        
        
    }
    else{
        if([_Availablityresult isEqualToString:@"Yes"])
        {
            [self insertPreviousEmployer];
        }
       else if([_Availablityresult isEqualToString:@"No"]){
            [self savePreviousEmpDBipad];
            [self FetchPreviousEmpDBipad];
        }
        
        
        _previouscompanytxt.text=@"";
        [_datebtn setTitle:@"Select" forState:UIControlStateNormal];
        _rateofpaytxt.text=@"";
        _positionheldtxt.text=@"";
        _reasonforleavingtxt.text=@"";

        
        
        
    }
    }
    
}

- (IBAction)selectdate:(id)sender {
    [self createCalenderPopover];
}
-(IBAction)deletepreviousemp:(id)sender
{
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_prevousEmpTable setEditing:NO animated:NO];
        [_prevousEmpTable reloadData];
        
        
        [_deletebtn setTitle:@"Delete" forState:UIControlStateNormal];
        
        
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_prevousEmpTable setEditing:YES animated:YES];
        [_prevousEmpTable reloadData];
        
        [_deletebtn setTitle:@"Done" forState:UIControlStateNormal];        
        
    }

}
-(void)createCalenderPopover
{
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 315, 330)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(315, 330);
    
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
    calendar.maximumDate =[self.dateFormatter dateFromString:@"01/01/2050"];
    calendar.shouldFillCalendar = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = NO;
    
    calendar.frame = CGRectMake(10, 10, 300, 320);
    [popoverView addSubview:calendar];
    
    //    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //    [self.view addSubview:self.dateLabel];
    
    //  self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(315.0f, 330.0f);
    self.popOverController1=_popOverController1;
    
    [self.popOverController1 presentPopoverFromRect:_datebtn.frame
                                             inView:self.scroll
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}

- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}



#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM-dd-YYYY"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    [_datebtn setTitle:dateString forState:UIControlStateNormal];
    [self.popOverController1 dismissPopoverAnimated:YES];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_prevousEmpTable) {
        return [_previousemployeeArray count];
        
        
    }
     if (tableView==_previousemptable_iphone)
     {
         return [_previousemployeeArray count];
 
     }
         
    return YES;
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (tableView==_prevousEmpTable)
        {
            [[NSBundle mainBundle]loadNibNamed:@"customprevious" owner:self options:nil];
            cell=_previouscell;

        }
        if(tableView==_previousemptable_iphone)
        {
            [[NSBundle mainBundle]loadNibNamed:@"Employeecell_iphone" owner:self options:nil];
            cell=_empcell_iphone;
        }
        
               
        
    }
    
       if (tableView==_prevousEmpTable)
       {
        _previous=(previousemp *)[_previousemployeeArray objectAtIndex:indexPath.row];
        _companynamelabel=(UILabel*)[cell viewWithTag:1];
        _companynamelabel.text=_previous.previouscompany;
           NSLog(@"%@",_previous.previouscompany);
           NSLog(@"%d",_previous.previousid);
        _datelabel=(UILabel*)[cell viewWithTag:2];
        _datelabel.text=_previous.dateofemployee;
        _rateofpaylabel=(UILabel*)[cell viewWithTag:3];
        _rateofpaylabel.text=[NSString stringWithFormat:@"$%@",_previous.previousrateofpay];
          
        _positionlabel=(UILabel*)[cell viewWithTag:4];
        _positionlabel.text=_previous.previousposition;
        _reasonforleavinglabel=(UILabel*)[cell viewWithTag:5];
        _reasonforleavinglabel.text=_previous.reasonforleaving;
        
        
       }
     if(tableView==_previousemptable_iphone)
     {
         _previous=(previousemp *)[_previousemployeeArray objectAtIndex:indexPath.row];
         _companynamelbl_iphone=(UILabel*)[cell viewWithTag:1];
         _companynamelbl_iphone.text=_previous.previouscompany;
         _rateofpaylbl_iphone=(UILabel*)[cell viewWithTag:2];
         _rateofpaylbl_iphone.text=_previous.previousrateofpay;
     }
    
      return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    identifr=indexPath.row;
    NSLog(@"ide%d",identifr);
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        
        [self DeleteApplicantPreviousEmployer];
              
        [_previousemployeeArray removeObjectAtIndex:indexPath.row];
        
        
        
    }
}




#pragma mark - webservice

-(void)insertPreviousEmployer
{
    recordResults = FALSE;
    NSString *soapMessage;
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
     {
    webtype=1;
    NSLog(@"date%@",_datebtn.titleLabel.text);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
   [dateFormat setDateFormat: @"MM-dd-yyyy"];
         
         NSString* sqldate;
         if ([_datebtn.titleLabel.text isEqualToString:@"Select"]) {
             NSDate *d=[NSDate date];
             NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
             [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
             sqldate=[dateFormat1 stringFromDate:d];
             NSLog(@"s%@",sqldate);

             
         }
         else{
    NSDate *dateString = [dateFormat dateFromString:_datebtn.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
     sqldate=[dateFormat1 stringFromDate:dateString];
    NSLog(@"s%@",sqldate);
         }
    NSString *compnyname=_previouscompanytxt.text;
    //NSString *rateofpay=_rateofpaytxt.text;
    
    NSString *prevoiusposition=_positionheldtxt.text;
    NSString *reasonforleaving=_reasonforleavingtxt.text;
    NSInteger createdUser=0;
    NSInteger modifieduser=0;
    NSString *createdDate=@"2013-01-01";
    NSString *modifieddate=@"2013-01-01";

    _previousid=0;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertApplicantPreviousEmployer xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<PreviousId>%d</PreviousId>\n"
                   "<PreviousCompany>%@</PreviousCompany>\n"
                   "<EmploymentDate>%@</EmploymentDate>\n"
                   "<PreviousRateofPay>%f</PreviousRateofPay>\n"
                   "<PreviousPosition>%@</PreviousPosition>\n"
                   "<LeavingReason>%@</LeavingReason>\n"
                   "<CreatedDate>%@</CreatedDate>\n"
                   "<CreatedUser>%d</CreatedUser>\n"
                   "<ModifiedDate>%@</ModifiedDate>\n"
                   "<ModifiedUser>%d</ModifiedUser>\n"
                   "</InsertApplicantPreviousEmployer>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,_previousid,compnyname,sqldate,[_rateofpaytxt.text floatValue],prevoiusposition,reasonforleaving,createdDate,createdUser,modifieddate,modifieduser];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/InsertApplicantPreviousEmployer" forHTTPHeaderField:@"Soapaction"];
    
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
       webtype=1;
       NSLog(@"date%@",_empdatetextfld_iphone.text);
//       NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//       [dateFormat setDateFormat: @"MM-dd-yyyy"];
//       
//       NSDate *dateString = [dateFormat dateFromString:_empdatetextfld_iphone.text];
//       NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
//       [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
//       NSString* sqldate=[dateFormat1 stringFromDate:dateString];

     //  NSLog(@"s%@",sqldate);
       NSString *compnyname=_companynametxtfld_iphone.text;
       //NSString *rateofpay=_rateofpaytxt.text;
       
       NSString *prevoiusposition=_positionheldtxtfld_iphone.text;
       NSString *reasonforleaving=_reasonlvtxtfld_iphone.text;
       NSInteger createdUser=0;
       NSInteger modifieduser=0;
       NSString *createdDate=@"2013-01-01";
       NSString *modifieddate=@"2013-01-01";
       
       _previousid=0;
       
       
       soapMessage = [NSString stringWithFormat:
                      
                      @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                      "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                      
                      
                      "<soap:Body>\n"
                      
                      "<InsertApplicantPreviousEmployer xmlns=\"http://ios.kontract360.com/\">\n"
                      "<ApplicantId>%d</ApplicantId>\n"
                      "<PreviousId>%d</PreviousId>\n"
                      "<PreviousCompany>%@</PreviousCompany>\n"
                      "<EmploymentDate>%@</EmploymentDate>\n"
                      "<PreviousRateofPay>%f</PreviousRateofPay>\n"
                      "<PreviousPosition>%@</PreviousPosition>\n"
                      "<LeavingReason>%@</LeavingReason>\n"
                      "<CreatedDate>%@</CreatedDate>\n"
                      "<CreatedUser>%d</CreatedUser>\n"
                      "<ModifiedDate>%@</ModifiedDate>\n"
                      "<ModifiedUser>%d</ModifiedUser>\n"
                      "</InsertApplicantPreviousEmployer>\n"
                      "</soap:Body>\n"
                      "</soap:Envelope>\n",_Applicantid,_previousid,compnyname,_empdatetextfld_iphone.text,[_rateofpaytxtfld_iphone.text floatValue],prevoiusposition,reasonforleaving,createdDate,createdUser,modifieddate,modifieduser];
       NSLog(@"soapmsg%@",soapMessage);
       
       
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
       
       NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
       
       NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
       
       [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
       
       [theRequest addValue:@"http://ios.kontract360.com/InsertApplicantPreviousEmployer" forHTTPHeaderField:@"Soapaction"];
       
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
-(void)selectApplicantPreviousEmployer
{
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectApplicantPreviousEmployer xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</SelectApplicantPreviousEmployer>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectApplicantPreviousEmployer" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)DeleteApplicantPreviousEmployer
{
    previousemp *pre1;
    pre1=(previousemp *)[_previousemployeeArray objectAtIndex:identifr];
    
    NSInteger previosid=pre1.previousid;
   
    NSLog(@"id%d",previosid);
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteApplicantPreviousEmployer xmlns=\"http://ios.kontract360.com/\">\n"
                   "<PreviousId>%d</PreviousId>\n"
                   "<AppId>%d</AppId>\n"
                   "</DeleteApplicantPreviousEmployer>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",previosid,_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/DeleteApplicantPreviousEmployer" forHTTPHeaderField:@"Soapaction"];
    
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
    [_prevousEmpTable reloadData];
    [_previousemptable_iphone reloadData];
    if (webtype==1) {
        [self selectApplicantPreviousEmployer];
        webtype=0;
    }

}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"SelectApplicantPreviousEmployerResult"])
    {
        _previousemployeeArray=[[NSMutableArray alloc]init];
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
    if([elementName isEqualToString:@"previous_Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"previous_Company"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"dateof_Employment"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"previous_rateofPay"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }


    if([elementName isEqualToString:@"previous_Position"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"leaving_reason"])
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
    if([elementName isEqualToString:@"previous_Id"])
    {
        _previous=[[previousemp alloc]init];
        recordResults = FALSE;
        _previous.previousid=[_soapResults integerValue];
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"applicant_Id"])
    {
        
        recordResults = FALSE;
        _previous.applicantid=_soapResults;
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"previous_Company"])
    {
        recordResults = FALSE;
        _previous.previouscompany=_soapResults;
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"dateof_Employment"])
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
        _previous.dateofemployee=myFormattedDate;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"previous_rateofPay"])
    {
        recordResults = FALSE;
        _previous.previousrateofpay=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"previous_Position"])
    {
        recordResults = FALSE;
        _previous.previousposition=_soapResults;
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"leaving_reason"])
    {
        recordResults = FALSE;
        _previous.reasonforleaving=_soapResults;
        [_previousemployeeArray addObject:_previous];
        NSLog(@"%d",_previous.previousid);
        NSLog(@"%@",_previous.previouscompany);
        _soapResults = nil;
    }



    
}
-(IBAction)continueaction:(id)sender
{
    
//    if (!self.drugVCtrl) {
//        _drugVCtrl=[[DrugViewController alloc]initWithNibName:@"DrugViewController" bundle:nil];
//    }
//    _drugVCtrl.applicantId=_Applicantid;
//     _drugVCtrl.jobsiteid=_jobsiteid;
//    _drugVCtrl.craftid=_craftid;
//    [self.navigationController pushViewController:_drugVCtrl animated:YES];Validation*val=[[Validation alloc]init];

    if (!self.coursedrugVCtrl) {
        _coursedrugVCtrl=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController" bundle:nil];
    }
   _coursedrugVCtrl.Applicantid=_Applicantid;
 _coursedrugVCtrl.jobsiteid=_jobsiteid;
    _coursedrugVCtrl.craftid=_craftid;
    [self.navigationController pushViewController:_coursedrugVCtrl animated:YES];

    
    
    
}
//iphone

-(IBAction)save_iphone:(id)sender
{
    
     Validation*val=[[Validation alloc]init];
      int value1=[val isNumeric:_rateofpaytxtfld_iphone.text];
    
    if(value1==0)
    {
        UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Invalid rate" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert1 show];
        
        
    }
    else{
        if([_Availablityresult isEqualToString:@"Yes"])
        {
            
            [self insertPreviousEmployer];        }
        else if([_Availablityresult isEqualToString:@"No"]){
            [self savePreviousEmpDBipad];
            [self FetchPreviousEmpDBipad];
        }

    }

   
}
-(IBAction)cancel_iphone:(id)sender
{
    _companynametxtfld_iphone.text=@"";
    _empdatetextfld_iphone.text=@"";
    _rateofpaytxtfld_iphone.text=@"";
    _positionheldtxtfld_iphone.text=@"";
    _reasonlvtxtfld_iphone.text=@"";
}
-(IBAction)deleteemp_iphone:(id)sender
{
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_previousemptable_iphone setEditing:NO animated:NO];
        [_previousemptable_iphone reloadData];
        
        
        [_deletebtn_iphone setTitle:@"Delete" forState:UIControlStateNormal];
        
        
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_previousemptable_iphone setEditing:YES animated:YES];
        [_previousemptable_iphone reloadData];
        
        [_deletebtn_iphone setTitle:@"Done" forState:UIControlStateNormal];
        
    }
 
}
-(IBAction)addemp_iphone:(id)sender
{
    _addview_iphone.hidden=NO;
    
}
#pragma mark-TExtfield Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    if (textField==_empdatetextfld_iphone) {
        
        [_empdatetextfld_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        [_datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
    
    
     //_picker.hidden=YES;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
    if (textField==_empdatetextfld_iphone) {
        
        
        [_empdatetextfld_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        
        [  _datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
        if(textField==_companynametxtfld_iphone)
        {
            NSUInteger newLength = [_companynametxtfld_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }
        if(textField==_rateofpaytxtfld_iphone)
        {
            NSUInteger newLength = [_rateofpaytxtfld_iphone.text length] + [string length] - range.length;
            return (newLength > 25) ? NO : YES;
        }
        if(textField==_reasonlvtxtfld_iphone)
        {
            NSUInteger newLength = [_reasonlvtxtfld_iphone.text length] + [string length] - range.length;
            return (newLength > 100) ? NO : YES;
        }
        if(textField==_positionheldtxtfld_iphone)
        {
            NSUInteger newLength = [_positionheldtxtfld_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }
        
    
    
    if(textField==_previouscompanytxt)
    {
        NSUInteger newLength = [_previouscompanytxt.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    if(textField==_rateofpaytxt)
    {
        NSUInteger newLength = [_rateofpaytxt.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if(textField==_reasonforleavingtxt)
    {
        NSUInteger newLength = [_reasonforleavingtxt.text length] + [string length] - range.length;
        return (newLength > 100) ? NO : YES;
    }
    if(textField==_positionheldtxt)
    {
        NSUInteger newLength = [_positionheldtxt.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    
    
    
    //_picker.hidden=YES;
    return YES;
}
-(void)picker1action{
    NSDate *date1  = _datepicker_iphone.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    //    dateFormat.dateFormat=@"MM/dd/yyyy";
    dateFormat.dateFormat=@"yyyy-MM-dd";
    _empdatetextfld_iphone.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date1]];
    _datepicker_iphone.hidden=YES;
    
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

-(IBAction)close_iphone:(id)sender
{
    _addview_iphone.hidden=YES;
}

-(IBAction)cancel:(id)sender
{
    _previouscompanytxt.text=@"";
    [_datebtn setTitle:@"Select" forState:UIControlStateNormal];
    _rateofpaytxt.text=@"";
    _positionheldtxt.text=@"";
    _reasonforleavingtxt.text=@"";
}
#pragma mark-SqliteDB  for ipad

-(void)createandcheckdatabaseipad{
    _dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    _docsDir=[_dirPaths objectAtIndex:0];
    /* Build the path to the database file*/
    
    _databasePath = [[NSString alloc] initWithString: [_docsDir stringByAppendingPathComponent: @"EmployeeHrList.db"]];
    //NSLog(@"Path %@",_databasePath);
    
//    NSFileManager *filemgr = [NSFileManager defaultManager];
//    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
//    {
        const char *dbpath = [_databasePath UTF8String];
        if (sqlite3_open(dbpath, &_newEmplyhrListDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PreviousemployeeList (ID INTEGER PRIMARY KEY AUTOINCREMENT, PreviousID TEXT,CompanyName TEXT,EmployementDate TEXT,RateOFPay TEXT,PreviousPosition TEXT,ReasonForLeaving TEXT,ApplicantSSN TEXT)";
            
            
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

-(void)savePreviousEmpDBipad{
    
    //_SqlSSnstrng=_connectstring;
    NSInteger previousid=0;
    NSLog(@"date%@",_datebtn.titleLabel.text);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
    
    NSDate *dateString = [dateFormat dateFromString:_datebtn.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* date2=[dateFormat1 stringFromDate:dateString];
    NSLog(@"s%@",date2);

    sqlite3_stmt *statement;
    const char* dbpath=[_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*INSERTSql=[NSString stringWithFormat:@"INSERT  INTO PreviousemployeeList(PreviousID,CompanyName,EmployementDate,RateOFPay,PreviousPosition,ReasonForLeaving,ApplicantSSN) VALUES (\"%d\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")",previousid,_previouscompanytxt.text,date2,_rateofpaytxt.text,_positionheldtxt.text,_reasonforleavingtxt.text,_applicantssn];
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


-(void)FetchPreviousEmpDBipad
{
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt*statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*query=[NSString stringWithFormat:@"SELECT * FROM  PreviousemployeeList WHERE ApplicantSSN='%@'",_applicantssn];
               const char *query_stmt=[query UTF8String];
        
        if (sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            _previousemployeeArray=[[NSMutableArray alloc]init];
        

            while (sqlite3_step(statement)==SQLITE_ROW) {
                   _previous=[[previousemp alloc]init];
                           const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                // _userdetails.primarykey=[pkey integerValue];
                
                const char *previousid=(const char *)sqlite3_column_text(statement,1);
                NSString *preid=previousid==NULL ?nil:[[NSString alloc]initWithUTF8String:previousid];
                _previous.previousid=[preid integerValue];
                
                const char *companyname=(const char *)sqlite3_column_text(statement, 2);
                _previous.previouscompany=companyname==NULL ?nil:[[NSString alloc]initWithUTF8String:companyname];
                
                const char*empdate=(const char *)sqlite3_column_text(statement, 3);
                _previous.dateofemployee=empdate==NULL ?nil:[[NSString alloc]initWithUTF8String:empdate];
                 const char*rateofpay=(const char *)sqlite3_column_text(statement, 4);
                _previous.previousrateofpay=rateofpay==NULL ?nil:[[NSString alloc]initWithUTF8String:rateofpay];
                
                const char*postion=(const char *)sqlite3_column_text(statement, 5);
                _previous.previousposition=postion==NULL ?nil:[[NSString alloc]initWithUTF8String:postion];
                
                const char*reasonforleaving=(const char *)sqlite3_column_text(statement, 6);
                _previous.reasonforleaving=reasonforleaving==NULL ?nil:[[NSString alloc]initWithUTF8String:reasonforleaving];
                
                 [_previousemployeeArray addObject:_previous];
                
                
            }
        }
        
        sqlite3_finalize(statement);
        
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
    [_prevousEmpTable reloadData];
    
}
#pragma mark-sqlite DB for iphone
-(void)updatePreviousEmpDBiphone
{
    NSInteger previosid=0;
    NSLog(@"date%@",_datebtn.titleLabel.text);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
    
    NSDate *dateString = [dateFormat dateFromString:_datebtn.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* date1=[dateFormat1 stringFromDate:dateString];
    NSLog(@"s%@",date1);
    
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt *statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString *updatesql=[NSString stringWithFormat:@"UPDATE UserList SET PreviousID=\"%d\",CompanyName=\"%@\",EmployementDate=\"%@\",RateOFPay=\"%@\",PreviousPosition=\"%@\",ReasonForLeaving=\"%@\" WHERE ID=%@",previosid,_companynametxtfld_iphone.text,date1,_rateofpaytxtfld_iphone.text,_positionheldtxtfld_iphone.text,_reasonlvtxtfld_iphone.text,_sqlitessn];
        const char *update_stmt=[updatesql UTF8String];
        sqlite3_prepare(_newEmplyhrListDB, update_stmt, -1, &statement, NULL);
        if(sqlite3_step(statement)==SQLITE_DONE)
        {
            NSLog( @"UserDetail's updated");
        }
        else
        {
            NSLog( @"Failed to add update");
        }
        sqlite3_finalize(statement);
        sqlite3_close(_newEmplyhrListDB);
        
        
    }
}

-(void)FetchPreviousEmpDBiphone
{
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt*statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*query=[NSString stringWithFormat:@"SELECT * FROM UserList"];
        const char *query_stmt=[query UTF8String];
        
        if (sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
             int i=0;
            
            while (sqlite3_step(statement)==SQLITE_ROW) {
                 _userdetails=(UserDetails *)[_sqliteArray objectAtIndex:i];
                const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                _userdetails.primarykey=[pkey integerValue];
                
                const char *previousid=(const char *)sqlite3_column_text(statement, 5);
                NSString *preid=previousid==NULL ?nil:[[NSString alloc]initWithUTF8String:previousid];
                _userdetails.previousid=[preid integerValue];
                
                const char *companyname=(const char *)sqlite3_column_text(statement, 5);
                _userdetails.companyname=companyname==NULL ?nil:[[NSString alloc]initWithUTF8String:companyname];
                
                const char*empdate=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.passwordstring=empdate==NULL ?nil:[[NSString alloc]initWithUTF8String:empdate];
                const char*rateofpay=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.rateofpay=rateofpay==NULL ?nil:[[NSString alloc]initWithUTF8String:rateofpay];
                const char*postion=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.previosposition=postion==NULL ?nil:[[NSString alloc]initWithUTF8String:postion];
                
                const char*reasonforleaving=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.reasonforleaving=reasonforleaving==NULL ?nil:[[NSString alloc]initWithUTF8String:reasonforleaving];
                
                [_sqliteArray addObject:_userdetails];
                
                i++;
            }
        }
        
        sqlite3_finalize(statement);
        
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
    
}




@end
