//
//  NewMedicalViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 8/1/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "NewMedicalViewController.h"

@interface NewMedicalViewController ()

@end

@implementation NewMedicalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Medical Details", @"Medical Details");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _scrollview.frame=CGRectMake(0, 0,1024, 768);
    [_scrollview setContentSize:CGSizeMake(1024,850)];
    
    _scroll_iphone.frame=CGRectMake(0, 0, 320, 548);
    [_scroll_iphone setContentSize:CGSizeMake(320, 700)];
    _medicaltable.layer.borderWidth = 2.0;
    _medicaltable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    
    _medicaltable_iphone.layer.borderWidth = 2.0;
    _medicaltable_iphone.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
self. medicaltable_iphone.contentSize = CGSizeMake(self.medicaltable_iphone.frame.size.width, self.medicaltable_iphone.contentSize.height);
    [self selectMedicalCondition];
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"logout1"] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    
    
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
    
    
    
    if (buttonIndex==0) {
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self userInfo:nil];
        
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self UpdateApplicantValue];
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self selectApplicantMedicalCondition];
    [self GetApplicantValues];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.popOverController1 presentPopoverFromRect:_medicalconditinbtnlbl.frame
                                             inView:self.view1
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}

- (IBAction)Addbtn:(id)sender {
    _view1.hidden=NO;
}

- (IBAction)savebtn:(id)sender {
    [self insertMedicalcondition];
}

- (IBAction)medcntdnbtn:(id)sender {
    [self createPopover];   
    [self selectMedicalCondition];
}

- (IBAction)closebtn:(id)sender {
     _view1.hidden=YES;
    
}

- (IBAction)continuebtn:(id)sender {
    
    
  //  [self DeleteApplicantMedicalCondition];
      [self UpdateApplicantValue];
 
    
}

- (IBAction)deletebtn:(id)sender {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_medicaltable setEditing:NO animated:NO];
        [_medicaltable reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_medicaltable setEditing:YES animated:YES];
        [_medicaltable reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }

}

//- (IBAction)firstpage:(id)sender {
//    
//    if (!self.firstVctrl) {
//        _firstVctrl=[[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
//    }
//    [self.navigationController pushViewController:_firstVctrl animated:YES];
//}
#pragma mark - webservice
-(void)selectApplicantMedicalCondition
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectApplicantMedicalCondition xmlns=\"http://arvin.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</SelectApplicantMedicalCondition>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://arvin.kontract360.com/SelectApplicantMedicalCondition" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)insertMedicalcondition
{
    
    webtype=1;
    
    NSString*medid=[_medicaliddict objectForKey:_medicalconditinbtnlbl.titleLabel.text];
        NSString*EduName=@"";
        recordResults = FALSE;
        
 NSInteger medstatus=1;
        NSString *soapMessage;
        
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<InsertApplicantMedicalCondition xmlns=\"http://arvin.kontract360.com/\">\n"
                       "<ApplicantId>%d</ApplicantId>\n"
                       "<MedConditionId>%d</MedConditionId>\n"
                       "<EduName>%@</EduName>\n"
                       "<MedStatus>%d</MedStatus>\n"
                       "<MedDescription>%@</MedDescription>\n"
                       "</InsertApplicantMedicalCondition>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_Applicantid,[medid integerValue],EduName,medstatus,_medicaldistxtfld.text];
        NSLog(@"soapmsg%@",soapMessage);
        
        
        // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
        NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue: @"http://arvin.kontract360.com/InsertApplicantMedicalCondition" forHTTPHeaderField:@"Soapaction"];
        
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
-(void)selectMedicalCondition
{
    
    recordResults= FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectMedicalCondition xmlns=\"http://arvin.kontract360.com/\">\n"
                   "</SelectMedicalCondition>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://arvin.kontract360.com/SelectMedicalCondition" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)GetApplicantValues{
    recordResults= FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GetApplicantValues xmlns=\"http://arvin.kontract360.com/\">\n"
                   "<AppId>%d</AppId>"
                   "</GetApplicantValues>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://arvin.kontract360.com/GetApplicantValues" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)DeleteApplicantMedicalCondition{
     Medicalmodel*medmdl1=(Medicalmodel *)[_applicantmedicalcntnarray objectAtIndex:identifier];
    NSInteger medid=[medmdl1.medicalid integerValue];
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteApplicantMedicalCondition xmlns=\"http://arvin.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                    "<MedConditionId>%d</MedConditionId>"
                   "</DeleteApplicantMedicalCondition>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,medid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://arvin.kontract360.com/DeleteApplicantMedicalCondition" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UpdateApplicantValue{
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        
    
    NSInteger Cablity;
    if (_climbingsegment.selectedSegmentIndex==1) {
        Cablity=0;
    }
    else {
        Cablity=1;
    }
    recordResults= FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   
                   "<UpdateApplicantValues xmlns=\"http://arvin.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<ClimbingAbility>%d</ClimbingAbility>\n"
                   "<CurrentMedication>%@</CurrentMedication>\n"
                   "</UpdateApplicantValues>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,Cablity,_medicationtxtfld.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"http://arvin.kontract360.com/UpdateApplicantValues" forHTTPHeaderField:@"Soapaction"];
    
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
else{
    NSInteger Cablity;
    if (_climbingsegment_iphone.selectedSegmentIndex==1) {
                                                               Cablity=0;
                                                           }
                                                           else {
                                                               Cablity=1;
                                                           }
                                                           recordResults= FALSE;
                                                           NSString *soapMessage;
                                                           
                                                           soapMessage = [NSString stringWithFormat:
                                                                          
                                                                          @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                                                          "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                                                                          "<soap:Body>\n"
                                                                          
                                                                          "<UpdateApplicantValues xmlns=\"http://arvin.kontract360.com/\">\n"
                                                                          "<ApplicantId>%d</ApplicantId>\n"
                                                                          "<ClimbingAbility>%d</ClimbingAbility>\n"
                                                                          "<CurrentMedication>%@</CurrentMedication>\n"
                                                                          "</UpdateApplicantValues>\n"
                                                                          "</soap:Body>\n"
                                                                          "</soap:Envelope>\n",_Applicantid,Cablity,_medicationtxtfld_iphone.text];
                                                           NSLog(@"soapmsg%@",soapMessage);
                                                           
                                                           
                                                           // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
                                                           NSURL *url = [NSURL URLWithString:@"http://arvin.kontract360.com/service.asmx"];
                                                           
                                                           NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
                                                           
                                                           NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
                                                           
                                                           [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                                                           
                                                           [theRequest addValue: @"http://arvin.kontract360.com/UpdateApplicantValues" forHTTPHeaderField:@"Soapaction"];
                                                           
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



#pragma mark - connection
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
    
    [_popOverTableView reloadData];
    [_medicaltable reloadData];
    [_medicaltable_iphone reloadData];
    if (webtype==1) {
        [self selectApplicantMedicalCondition];
        webtype=0;
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
    if (tableView==_popOverTableView) {
        return [_medicalnamearray count];
    }
    if (tableView==_medicaltable||tableView==_medicaltable_iphone) {
        return [_applicantmedicalcntnarray count];
    }
    return YES;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
 if (tableView==_medicaltable) {
        
       [[NSBundle mainBundle]loadNibNamed:@"newmedicalcell" owner:self options:nil];
            cell=_medicalcell;
 }
        }
        else if (tableView==_medicaltable_iphone) 
        {
            [[NSBundle mainBundle]loadNibNamed:@"medicell" owner:self options:nil];
            cell=_medcell_iphone;
        }
    
        }
    if (tableView==_popOverTableView) {
        cell.textLabel.text=[_medicalnamearray objectAtIndex:indexPath.row];
    }
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
    if (tableView==_medicaltable||tableView==_medicaltable_iphone) {
        Medicalmodel*medmdl1=(Medicalmodel *)[_applicantmedicalcntnarray objectAtIndex:indexPath.row];
        _medicalnamelbl=(UILabel*)[cell viewWithTag:1];
        _medicalnamelbl.text=[_medicalnamedict objectForKey:medmdl1.medicalid];
        NSLog(@"%@",medmdl1.medicalid);
        _meddescptnlbl=(UILabel*)[cell viewWithTag:2];
        _meddescptnlbl.text=medmdl1.meddescptn;
         NSLog(@"%@",medmdl1.meddescptn);
    }
        
    }
    else
    {
        Medicalmodel*medmdl1=(Medicalmodel *)[_applicantmedicalcntnarray objectAtIndex:indexPath.row];
        _mednamelabel_iphone=(UILabel*)[cell viewWithTag:1];
        _mednamelabel_iphone.text=[_medicalnamedict objectForKey:medmdl1.medicalid];
        NSLog(@"%@",medmdl1.medicalid);
        _meddescptnlabel_iphone=(UILabel*)[cell viewWithTag:2];
        _meddescptnlabel_iphone.text=medmdl1.meddescptn;
        NSLog(@"%@",medmdl1.meddescptn);
    }
    
    
      return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_medicalconditinbtnlbl setTitle:[_medicalnamearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_medicaltable) {
        identifier=indexPath.row;
        if (editingStyle==UITableViewCellEditingStyleDelete) {
            [self DeleteApplicantMedicalCondition];
            [_applicantmedicalcntnarray removeObjectAtIndex:indexPath.row];
        }

            }
        if(tableView==_medicaltable_iphone)
        {
        identifier=indexPath.row;
        if (editingStyle==UITableViewCellEditingStyleDelete) {
          [self DeleteApplicantMedicalCondition];
          [_applicantmedicalcntnarray removeObjectAtIndex:indexPath.row];
          
      }
        }

}
#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"SelectMedicalConditionResult"])
    {
        _medicalnamedict=[[NSMutableDictionary alloc]init];
        _medicaliddict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"medicalCondition_Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"medicalCondition_Name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SelectApplicantMedicalConditionResult"])
    {
        _applicantmedicalcntnarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"MedConditionId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"MedicalStatus"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Description"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"GetApplicantValuesResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ClimbingAbility"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"CurrentMedication"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"UpdateApplicantValuesResponse"])
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
    
    if([elementName isEqualToString:@"medicalCondition_Name"])
    {
        recordResults = FALSE;
        [_medicalnamedict setObject:_soapResults forKey:_unitstrg];
        [_medicaliddict setObject:_unitstrg forKey:_soapResults];
        _medicalnamearray=[_medicalnamedict allValues];
       _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"medicalCondition_Id"])
    {
       
        recordResults = FALSE;
        _unitstrg=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"ApplicantId"])
        
        
    {
        _medmdl=[[Medicalmodel alloc]init];
        recordResults = FALSE;
        
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"MedConditionId"])
        
        
    {
         
        recordResults = FALSE;
        _medmdl.medicalid=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"MedicalStatus"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _medmdl.medstatus=@"1";
            
            
        }
        else if ([_soapResults isEqualToString:@"true"]){
            
            _medmdl.medstatus=@"0";
        }
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Description"])
    {
        recordResults = FALSE;
        _medmdl.meddescptn=_soapResults;
        [_applicantmedicalcntnarray addObject:_medmdl];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"ClimbingAbility"])
    {
         recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            
            _climbingsegment.selectedSegmentIndex=0;
            _climbingsegment_iphone.selectedSegmentIndex=0;
            
        }
        else  if([_soapResults isEqualToString:@"false"]){
            
            
              _climbingsegment.selectedSegmentIndex=1;
            _climbingsegment_iphone.selectedSegmentIndex=1;
        }
       
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"CurrentMedication"])
    {
        recordResults = FALSE;
        _medicationtxtfld.text=_soapResults;
        _medicationtxtfld_iphone.text=_soapResults;
        _soapResults = nil;
        
    }
    
    if([elementName isEqualToString:@"UpdateApplicantValuesResponse"])
    {
       recordResults = FALSE;
//        if (!self.emplyeeVCtrl) {
//            _emplyeeVCtrl=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController" bundle:nil];
//        }
//        _emplyeeVCtrl.Applicantid=_Applicantid;
//        [self.navigationController pushViewController:_emplyeeVCtrl animated:YES];
        _soapResults = nil;
    }

    
}

- (IBAction)updatebtn:(id)sender {
    [self UpdateApplicantValue];
    
}
- (IBAction)Addbtn_iphone:(id)sender {
    
    if (!self.AddmedCondtnVCtrl) {
        _AddmedCondtnVCtrl=[[AddNewMedicalViewController alloc]initWithNibName:@"AddNewMedicalViewController" bundle:nil];
    }
    _AddmedCondtnVCtrl.Applicantid=_Applicantid;
    [self.navigationController pushViewController:_AddmedCondtnVCtrl animated:YES];
}

- (IBAction)deletebtn_iphone:(id)sender {
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_medicaltable_iphone setEditing:NO animated:NO];
        [_medicaltable_iphone reloadData];
        
        // [_delete_ipad setTitle:@"Done"];
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_medicaltable_iphone setEditing:YES animated:YES];
        [_medicaltable_iphone reloadData];
        // [_delete_ipad setTitle:@"Delete"];
        
        
        
        
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
   
    if(textField==_medicationtxtfld)
    {
    NSUInteger newLength = [_medicationtxtfld.text length] + [string length] - range.length;
    return (newLength > 50) ? NO : YES;
    }
    
   
    if(textField==_medicationtxtfld_iphone)
        {
            NSUInteger newLength = [_medicationtxtfld_iphone.text length] + [string length] - range.length;
            return (newLength > 50) ? NO : YES;
        }
 
    
}
-(IBAction)returnkey:(id)sender{
    [sender resignFirstResponder];
}
-(IBAction)cancel:(id)sender
{
    [_medicalconditinbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
    _meddistxtfld.text=@"";
}
@end
