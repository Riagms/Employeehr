//
//  BasicdetailsViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 7/8/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "BasicdetailsViewController.h"
#import "Base64.h"
@interface BasicdetailsViewController ()

@end

@implementation BasicdetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title=NSLocalizedString(@"Personal Details", @"Personal Details");
        self.tabBarItem.image = [UIImage imageNamed:@"personal"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self FetchuserdetailsfromDBforipad];
    [_sufixbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
       [_stateissuebtn setTitle:@"Select" forState:UIControlStateNormal];
    x=1;
    detailbtnclicked_iphone=0;
    _datetextfld_ipad.inputView=[[UIView alloc]initWithFrame:CGRectZero];
  [self getstates];
    _suffixarray=[[NSMutableArray alloc]initWithObjects:@"None",@"JR.",@"SR.",@"II",@"III" ,nil];
    _suffixarray_iphone=[[NSMutableArray alloc]initWithObjects:@"None",@"JR.",@"SR.",@"II",@"III" ,nil];
    _scrollview.frame=CGRectMake(0, 0,1024, 768);
    [ _scrollview setContentSize:CGSizeMake(1024,850)];
    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,1500)];
    _ssntxtfld.enabled=NO;
    _ssntextfield_iphone.enabled=NO;
    _imgvw.layer.borderColor=[UIColor blackColor].CGColor;
    _imgvw.layer.borderWidth=1;
    _Addresstxtfld.layer.borderColor=[UIColor colorWithRed:184.0/255.0f green:184.0/255.0f blue:184.0/255.0f alpha:1.0f].CGColor;
    
    _Addresstxtfld.layer.borderWidth=1;
    _Addresstxtfld.layer.cornerRadius=6;
    _datepicker_ipad.layer.borderColor=[UIColor colorWithRed:184.0/255.0f green:184.0/255.0f blue:184.0/255.0f alpha:1.0f].CGColor;
    _datepicker_ipad.layer.borderWidth=1;
    _datepicker_ipad.layer.cornerRadius=6;
    _imgvw.userInteractionEnabled = YES;
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(handlePinch:)];
    pgr.delegate = (id)self;
    
    [_imgvw addGestureRecognizer:pgr];
    // Do any additional setup after loading the view from its nib.
  
//self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:0.2 green:0.5 blue:0.5 alpha:1];
           
      self.navigationItem.hidesBackButton=YES;
}
-(void)homeAction{
   [self UpdateApplicantData];
    [self.navigationController popViewControllerAnimated:YES];
     
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    photostring=@"";
    _applicantssn=_ssntxtfld.text;
    _applicantssn=_ssntextfield_iphone.text;
    //_sufixbtnlbl.titleLabel.text=@"Select";
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
   self.navigationController.navigationBar.translucent = NO;
   UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationController.navigationBarHidden=NO;
    
    
    
   // if (x==1) {
        [self GetApplicantDetails];
      //  x=2;
       

  // }
    
    
    
    }
//-(void)checknetavailability
//{
//    NSString *urlstring=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
//    _Availablityresult=[[NSString alloc]init];
//    _Availablityresult=((urlstring !=NULL)? @"YES" :@"NO");
//    NSLog(@"Internet connection availability : %@", _Availablityresult);
//
//    if ([_Availablityresult isEqualToString:@"YES"]) {
//        // [self FetchManapowerdatasfromDB];
//        
//        //        if ([_Sqlitearry count]>0) {
//        //            //[self SynManpowertoserver];
//        //        }
//        //        else{
//        //            //[self Selectallmanpower];
//        //        }
//        //
//        
//    }
//    else if([_Availablityresult isEqualToString:@"NO"]){
//        // [self Createdatabase];
//        //[self FetchManapowerdatasfromDB];
//        
//        
//    }
//}
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
    if ([alertView.message isEqualToString:@"Invalid Alternative Number"]) {
        _alternativenumtxtfld.text=@"";
        _alternatenotxt_iphone.text=@"";
        
    }if ([alertView.message isEqualToString:@"Invalid Mobile Number"]) {
        _mobilenotext_iphone.text=@"";
        _mobiletxtfld.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid Home Number"]) {
        _homenotxt_iphone.text=@"";
        _homenumbertxtfld.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid Contact Number"]) {
        _contactnotxt_iphone.text=@"";
        _contactnumbtxtfld.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid Zip"]) {
        _ziptxt_iphone.text=@"";
        _ziptextflield.text=@"";
        
        
    }
    if ([alertView.message isEqualToString:@"Invalid Email"]) {
        _emailtxt_iphone.text=@"";
        _emailtxtfld.text=@"";
        
        
    }


}



-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([_Availablityresult isEqualToString:@"Yes"]) {
        
          [self UpdateApplicantData];
        
        
    }
    else if([_Availablityresult isEqualToString:@"No"]){
        
       
    }

 
    

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Action

- (IBAction)suffixbtn:(id)sender {
    popovertype=1;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 60, 250)];
    //200,250
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 60, 250)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorColor=[UIColor cyanColor];
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(60, 250);
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(60.0f, 250.0f);
    self.popOverController1=_popOverController1;
    [self.popOverController1 presentPopoverFromRect:_sufixbtnlbl.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];

    
}

- (IBAction)statebtn:(id)sender
{    popovertype=2;
    stateidentifier=1;
    [self createPopover];
    [self getstates];
}
-(IBAction)selectlicenceissuestate:(id)sender
{
     popovertype=2;
    stateidentifier=2;
    [self createPopover];
    [self getstates];
}

- (IBAction)pickercalendar:(id)sender {
    [_datepicker_ipad resignFirstResponder];

    _datepicker_ipad.hidden=NO;
    
   [_datepicker_ipad addTarget:self action:@selector(picker2action) forControlEvents:UIControlEventValueChanged];
}

- (IBAction)countrybtn:(id)sender {
}

- (IBAction)dobbtn:(id)sender {
    [self createCalenderPopover];
}

- (IBAction)gendersegmentcntrl:(id)sender {
}

- (IBAction)continuebtn:(id)sender {
  
//    if(phonex==1)
//    {
//        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid PhoneNumber" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
//        
//        [alert show];
//
//    }
//    else
//    {
    
    if (([_lastnametxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_firstnametxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_citytxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_emailtxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_mobiletxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_Addresstxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||([_datetextfld_ipad.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)) {
        
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter Mandatory fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];

        
        
    }
    
     if ([_datetextfld_ipad.text isEqualToString:@"01-01-1900"]) {
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"DOB Required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        [alert show];
    }
    
    else{
    
    
    
        if ([_Availablityresult isEqualToString:@"Yes"]) {
            
            [self UpdateApplicantData];
            
            
        }
        else if([_Availablityresult isEqualToString:@"No"]){
            
            [self UPdateDBipad];
            [self FetchuserdetailsfromDBforipad];
        }

          }
    
    
}


-(void)picker1action{
    NSDate *date1  = _datepicker_iphone.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    //    dateFormat.dateFormat=@"MM/dd/yyyy";
    dateFormat.dateFormat=@"MM-dd-yyyy";
    _dobtext_iphone.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date1]];
    _datepicker_iphone.hidden=YES;
    
}
-(void)picker2action{
    NSDate *date1  = _datepicker_ipad.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    //    dateFormat.dateFormat=@"MM/dd/yyyy";
    dateFormat.dateFormat=@"MM-dd-yyyy";
    _datetextfld_ipad.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date1]];
    _datepicker_ipad.hidden=YES;
    
}


-(IBAction)update_iphone:(id)sender
{     [self UPdateDBiphone];
    [self FetchuserdetailsfromDBforiphone];
    [self UpdateApplicantData];
    
}
-(IBAction)cancel_iphone:(id)sender
{
    
}


- (IBAction)cancelbtn:(id)sender {
//    [_sufixbtnlbl setTitle:@"" forState:UIControlStateNormal];
//    _lastnametxtfld.text=@"";
//    _firstnametxtfld.text=@"";
//    _Addresstxtfld.text=@"";
//    _citytxtfld.text=@"";
//    [_statebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
//    _ziptextflield.text=@"";
//    _datetextfld_ipad.text=@"";
//    _emailtxtfld.text=@"";
//    _mobiletxtfld.text=@"";
//    _homenumbertxtfld.text=@"";
}
-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}
-(IBAction)selectsuffix_iphone:(id)sender
{   pickerstring=@"suff";
    _suffixpicker.hidden=NO;
    [_suffixpicker reloadAllComponents];
}
-(IBAction)selectstate_iphone:(id)sender
{
    
    pickerstring=@"state";
    
    _statepicker.hidden=NO;
    [_statepicker reloadAllComponents];
    ;
}
- (IBAction)uploadimage:(id)sender {
    NSLog(@"%@",_imgvw.image);
    
   
    

    
    if (_imgvw.image==nil) {
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Image not available to upload" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];
    }
    else{
    
    UIImage *imagename =_imgvw.image;
    NSData *data = UIImagePNGRepresentation(imagename);
    
    // NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    _encodedString = [data base64EncodedString];
    
    NSLog(@"result%@",_encodedString);
       
    [self updateImagetoDB];
    
    [self UploadImage];
        
         _fileuploadbtnlbl.enabled=NO;
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
        switch (popovertype) {
            case 1:
                return [_suffixarray count];
                break;
            case 2:
                
                return [_stateArray count];
                break;
//            case 3:
//                return [_stateArray count];
//                break;

            default:
                break;
        }

        
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
     
    }


    if (tableView==_popOverTableView) {
               
        switch (popovertype) {
            case 1:
                cell.textLabel.text=[_suffixarray objectAtIndex:indexPath.row];
                break;
            case 2:
                cell.textLabel.text=[_stateArray objectAtIndex:indexPath.row];
                break;
//            case 3:
//                cell.textLabel.text=[_stateArray objectAtIndex:indexPath.row];
//                break;

            default:
                break;
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_popOverTableView) {
        
        
        
        switch (popovertype) {
            case 1:
                
                [_sufixbtnlbl setTitle:[_suffixarray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            
                
                
                break;
            case 2:
                if(stateidentifier==1)
                {
                [_statebtnlbl setTitle:[_stateArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                }else if(stateidentifier==2)
                {
                    [_stateissuebtn setTitle:[_stateArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                }
                
//            case 3:
//                
//                [_stateissuebtn setTitle:[_stateArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                
//                break;
            default:
                break;
        }
}
    [self.popOverController1 dismissPopoverAnimated:YES];


}

#pragma mark - webservice


-(void)GetApplicantDetails{
    upint=3;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<GetApplicantDetails xmlns=\"http://ios.kontract360.com/\">\n"
                    "<AppId>%d</AppId>\n"
                    "</GetApplicantDetails>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/GetApplicantDetails" forHTTPHeaderField:@"Soapaction"];
    
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


-(void)UpdateApplicantData{
    recordResults = FALSE;
    NSString *soapMessage;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
    NSLog(@"date%@",_datetextfld_ipad.text);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
    
    NSDate *dateString = [dateFormat dateFromString:_datetextfld_ipad.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* sqldate=[dateFormat1 stringFromDate:dateString];
    
   

    
    if(_gendersegmentcntrl.selectedSegmentIndex==0)
    {
        genderstg=1;
    }
    else if(_gendersegmentcntrl.selectedSegmentIndex==1)
    {
        genderstg=0;
    }
       

    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateApplicantData xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<NameSuffix>%@</NameSuffix>\n"
                   "<FirstName>%@</FirstName>\n"
                   "<LastName>%@</LastName>\n"
                   "<Address>%@</Address>\n"
                   "<City>%@</City>\n"
                   "<State>%@</State>\n"
                   "<Zip>%@</Zip>\n"
                   "<SSN>%@</SSN>\n"
                   "<DOB>%@</DOB>\n"
                   "<Country>%@</Country>\n"
                   "<Gender>%d</Gender>\n"
                   "<Email>%@</Email>\n"
                   "<CellphoneNo>%@</CellphoneNo>\n"
                   "<PhoneNo>%@</PhoneNo>\n"
                   "<AlternateNo>%@</AlternateNo>\n"
                   "<EmergencyContactName>%@</EmergencyContactName>\n"
                   "<EmergencyContactNo>%@</EmergencyContactNo>\n"
                   "<DrivingLicenseNo>%@</DrivingLicenseNo>\n"
                   "<LicenseIssuingState>%@</LicenseIssuingState>\n"
                   "<NameInLicense>%@</NameInLicense>\n"
                   "</UpdateApplicantData>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,_sufixbtnlbl.titleLabel.text,_firstnametxtfld.text,_lastnametxtfld.text,_Addresstxtfld.text,_citytxtfld.text,_statebtnlbl.titleLabel.text,_ziptextflield.text,_ssntxtfld.text,sqldate,_countrybtnlbl.titleLabel.text,genderstg,_emailtxtfld.text,_mobiletxtfld.text,_homenumbertxtfld.text,_alternativenumtxtfld.text,_emergencytxtfld.text,_contactnumbtxtfld.text,_driverlicencetxtfld.text,_stateissuebtn.titleLabel.text,_nameinlicencetxtfld.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantData" forHTTPHeaderField:@"Soapaction"];
    
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
         if(_gendersegment_iphone.selectedSegmentIndex==0)
         {
             genderstg=1;
         }
         else if(_gendersegment_iphone.selectedSegmentIndex==1)
         {
             genderstg=0;
         }
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
         [dateFormat setDateFormat: @"MM-dd-yyyy"];
         
         NSDate *dateString = [dateFormat dateFromString:_dobtext_iphone.text];
         NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
         [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
         NSString* sqldate=[dateFormat1 stringFromDate:dateString];
         
         soapMessage = [NSString stringWithFormat:
                        
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                        
                        
                        "<soap:Body>\n"
                        
                        "<UpdateApplicantData xmlns=\"http://ios.kontract360.com/\">\n"
                        "<ApplicantId>%d</ApplicantId>\n"
                        "<NameSuffix>%@</NameSuffix>\n"
                        "<FirstName>%@</FirstName>\n"
                        "<LastName>%@</LastName>\n"
                        "<Address>%@</Address>\n"
                        "<City>%@</City>\n"
                        "<State>%@</State>\n"
                        "<Zip>%@</Zip>\n"
                        "<SSN>%@</SSN>\n"
                        "<DOB>%@</DOB>\n"
                        "<Country>%@</Country>\n"
                        "<Gender>%d</Gender>\n"
                        "<Email>%@</Email>\n"
                        "<CellphoneNo>%@</CellphoneNo>\n"
                        "<PhoneNo>%@</PhoneNo>\n"
                        "<AlternateNo>%@</AlternateNo>\n"
                        "<EmergencyContactName>%@</EmergencyContactName>\n"
                        "<EmergencyContactNo>%@</EmergencyContactNo>\n"
                        "<DrivingLicenseNo>%@</DrivingLicenseNo>\n"
                        "<LicenseIssuingState>%@</LicenseIssuingState>\n"
                        "<NameInLicense>%@</NameInLicense>\n"
                        "</UpdateApplicantData>\n"
                        "</soap:Body>\n"
                        "</soap:Envelope>\n",_Applicantid,_suffixbtn_iphone.titleLabel.text,_firstnametxt_iphone.text,_lastnametxt_iphone.text,_homeaddresstxt_iphone.text,_citytxt_iphone.text,_statebtn_iphone.titleLabel.text,_ziptxt_iphone.text,_ssntextfield_iphone.text,sqldate,_countrytxt_iphone.titleLabel.text,genderstg,_emailtxt_iphone.text,_mobilenotext_iphone.text,_homenotxt_iphone.text,_alternatenotxt_iphone.text,_emergencycontactnametxt_iphone.text,_contactnotxt_iphone.text,_drivinglicenceno_iphone.text,_stateissuetxt_iphone.text,_nameonlicenct_iphone.text];
         NSLog(@"soapmsg%@",soapMessage);
         
         
       NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
          // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
         
         NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
         
         NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
         
         [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
         
         [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantData" forHTTPHeaderField:@"Soapaction"];
         
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
-(void)getstates
{
    popovertype=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "<SelectState xmlns=\"http://ios.kontract360.com/\">\n"
                   "</SelectState>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
   
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectState" forHTTPHeaderField:@"Soapaction"];
    
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
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
    [_popOverTableView reloadData];
    if(upint==3)
    {
        
        upint=2;
    }
    
        
     
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    
    if([elementName isEqualToString:@"GetApplicantDetailsResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"NameSuffix"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FirstName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"LastName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"Address"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"LastName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"Address"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"City"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"State"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Zip"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"State"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"SSN"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    

    if([elementName isEqualToString:@"DOB"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
       
    
    if([elementName isEqualToString:@"country_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"applicant_Gender"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"applicant_Email"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"CellPhone"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"phone"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"applicant_AlternateNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"EmergencyContact"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"DrivingLicense"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"applicant_photo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    
    if([elementName isEqualToString:@"applicant_LicenseState"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"NameinLicense"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SelectStateResult"])
    {
        _stateArray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

   
    if([elementName isEqualToString:@"state_id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

    }
    if([elementName isEqualToString:@"state_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    
    if([elementName isEqualToString:@"state_abbr"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"EmergencyContactNo"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"UploadImageResult"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FetchImageResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"url"])
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
    {recordResults = FALSE;
        _soapResults=nil;

    }
    if([elementName isEqualToString:@"NameSuffix"])
    {
        recordResults = FALSE;
        [_sufixbtnlbl setTitle:_soapResults forState:UIControlStateNormal];
        [_suffixbtn_iphone setTitle:_soapResults forState:UIControlStateNormal];
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"FirstName"])
    {
        recordResults = FALSE;
        _firstnametxtfld.text=_soapResults;
        _firstnametxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"LastName"])
    {
        recordResults = FALSE;
        _lastnametxtfld.text=_soapResults;
        _lastnametxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"Address"])
    {
        recordResults = FALSE;
        _Addresstxtfld.text=_soapResults;
        _homeaddresstxt_iphone.text=_soapResults;
        _soapResults=nil;    }
       
    if([elementName isEqualToString:@"City"])
    {
        recordResults = FALSE;
        _citytxtfld.text=_soapResults;
        _citytxt_iphone.text=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"State"])
    {
        recordResults = FALSE;
       
           [_statebtnlbl setTitle:_soapResults forState:UIControlStateNormal];
        [_statebtn_iphone setTitle:_soapResults forState:UIControlStateNormal];
        if([_soapResults isEqualToString:@""]){
            
            [_statebtnlbl setTitle:@"Select" forState:UIControlStateNormal];
            [_statebtn_iphone setTitle:@"Select" forState:UIControlStateNormal];
        }
            
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"Zip"])
    {
        recordResults = FALSE;
        _ziptextflield.text=_soapResults;
        _ziptxt_iphone.text=_soapResults;

        _soapResults=nil;    }
    
    
      
    if([elementName isEqualToString:@"SSN"])
    {
        recordResults = FALSE;
        _ssntxtfld.text=_soapResults;
       
        _ssntextfield_iphone.text=_soapResults;

        _soapResults=nil;    }
    
    
    
    if([elementName isEqualToString:@"DOB"])
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

      
        _datetextfld_ipad .text=myFormattedDate;
        _dobtext_iphone.text=myFormattedDate;
        _soapResults=nil;    }
    
    
    
    
    if([elementName isEqualToString:@"country_name"])
    {
        recordResults = FALSE;
          [_countrybtnlbl setTitle:_soapResults forState:UIControlStateNormal];
          [_countrytxt_iphone setTitle:_soapResults forState:UIControlStateNormal];
        if([_soapResults isEqualToString:@""]){
            
            [_countrybtnlbl setTitle:@"USA" forState:UIControlStateNormal];
            [_countrytxt_iphone setTitle:@"USA" forState:UIControlStateNormal];
        }

        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"applicant_Gender"])
    {
        recordResults = FALSE;
        if ([_soapResults isEqualToString:@"true"]) {
            _gendersegmentcntrl.selectedSegmentIndex=0;
            _gendersegment_iphone.selectedSegmentIndex=0;
            
            
        }
        else  if ([_soapResults isEqualToString:@"false"]) {
            _gendersegmentcntrl.selectedSegmentIndex=1;
            _gendersegment_iphone.selectedSegmentIndex=1;
            
            
        }

        
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"applicant_Email"])
    {
        recordResults = FALSE;
        _emailtxtfld.text=_soapResults;
        _emailtxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"CellPhone"])
    {
        recordResults = FALSE;
        _mobiletxtfld.text=_soapResults;
        _mobilenotext_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"phone"])
    {
        recordResults = FALSE;
        _homenumbertxtfld.text=_soapResults;
        _homenotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"applicant_photo"])
    {
        recordResults = FALSE;
        photostring=_soapResults;
        if (x==1) {
           [self FetchImage];
            x=2;
            
            
        }

       
  _soapResults=nil;
        
    }

    if([elementName isEqualToString:@"applicant_AlternateNo"])
    {
        recordResults = FALSE;
        _alternativenumtxtfld.text=_soapResults;
        _alternatenotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"EmergencyContact"])
    {
        recordResults = FALSE;
        _emergencytxtfld.text=_soapResults;
        _emergencycontactnametxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"EmergencyContactNo"])
    {
        recordResults = FALSE;
        _contactnumbtxtfld.text=_soapResults;
        _contactnotxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    

    
    if([elementName isEqualToString:@"DrivingLicense"])
    {
        recordResults = FALSE;
        _driverlicencetxtfld.text=_soapResults;
        _drivinglicenceno_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    
    
    if([elementName isEqualToString:@"applicant_LicenseState"])
    {
        recordResults = FALSE;
        [_stateissuebtn setTitle:_soapResults forState:UIControlStateNormal];

        _stateissuetxt_iphone.text=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"NameinLicense"])
    {
        recordResults = FALSE;
        _nameinlicencetxtfld.text=_soapResults;
        _nameonlicenct_iphone.text=_soapResults;
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"state_id"])
    {
        recordResults = FALSE;
       
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"state_abbr"])
    {
        recordResults = FALSE;
        
        _soapResults=nil;
    }

    if([elementName isEqualToString:@"state_name"])
    {
        recordResults = FALSE;
        NSLog(@"%@",_soapResults);
        [_stateArray addObject:_soapResults];
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"url"])
    {
           NSLog(@"upint%d",upint);
        recordResults = FALSE;
        if (upint==1) {
            
        
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
             _fileuploadbtnlbl.enabled=YES;
        }
        if (upint==2) {
             _uploadlbl.hidden=YES;
            NSData *data1=[_soapResults base64DecodedData];
            
            UIImage *image1=  [[UIImage alloc]initWithData:data1];
            CGSize newsize=CGSizeMake(192, 110);
            UIGraphicsBeginImageContext(newsize);
            [image1 drawInRect:CGRectMake(0,0,newsize.width,newsize.height)];
            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            _imgvw.image=newImage;
            //[NSData dataWithData:UIImagePNGRepresentation(image.image)];
            
         
            //_imgvw.image=image1;
            NSLog(@"img%@",image1);

            
        }
        
        _soapResults = nil;
    }


    

}
-(void)createPopover
{
    popovertype=2;
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
    
    if(stateidentifier==1)
    {
        [self.popOverController1 presentPopoverFromRect:_statebtnlbl.frame
                                              inView:self.scrollview
                            permittedArrowDirections:UIPopoverArrowDirectionUp
                                            animated:YES];
        
    }
    else if(stateidentifier==2)
    {
    [self.popOverController1 presentPopoverFromRect:_stateissuebtn.frame
                                            inView:self.scrollview
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    }
  
}

#pragma mark - Calendar
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
    
    calendar.frame = CGRectMake(10, 10, 315, 330);
    [popoverView addSubview:calendar];
    
    //    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    //    [self.view addSubview:self.dateLabel];
    
    //  self.view.backgroundColor = [UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(300.0f, 320.0f);
    self.popOverController1=_popOverController1;
    [self.popOverController1 presentPopoverFromRect:_dobbtnlbl.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionUp
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
    [_dobbtnlbl setTitle:dateString forState:UIControlStateNormal];
    [self.popOverController1 dismissPopoverAnimated:YES];
}


//iphone
- (IBAction)detailbtn_iphone:(id)sender {
    if (detailbtnclicked_iphone==0) {
        _contactinfoview_iphone.hidden=NO;
        [_infobtn_iphone setImage:[UIImage imageNamed:@"disclsurebtn"] forState:UIControlStateNormal];
        detailbtnclicked_iphone=1;
        
    }
    
    else{
        _contactinfoview_iphone.hidden=YES;
        [_infobtn_iphone setImage:[UIImage imageNamed:@"disclsurebtndwn"] forState:UIControlStateNormal];
        
        
    detailbtnclicked_iphone=0;
    }
    
}


#pragma mark - PickerAction
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if([pickerstring isEqualToString:@"suff"])
    {
        return [_suffixarray_iphone count];
    }
    else
    {
        return [_stateArray count];
    }
    return YES;

}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if([pickerstring isEqualToString:@"suff"])
    {
        return [_suffixarray_iphone objectAtIndex:row];
    }
    else if([pickerstring isEqualToString:@"state"])
    {
        return [_stateArray objectAtIndex:row];
    }

}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
      if([pickerstring isEqualToString:@"suff"])
      {
    [ _suffixbtn_iphone setTitle:[_suffixarray_iphone objectAtIndex:row] forState:UIControlStateNormal];
          _suffixpicker.hidden=YES;

      }
     else if([pickerstring isEqualToString:@"state"])
     {
    [ _statebtn_iphone setTitle:[_stateArray objectAtIndex:row] forState:UIControlStateNormal];
         _statepicker.hidden=YES;

     }
   
}



#pragma mark-Textfield Delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    if (textField==_dobtext_iphone) {
        
        [_dobtext_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        [_datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
//    if (textField==_datetextfld_ipad) {
//        
//        [_datetextfld_ipad resignFirstResponder];
//        
//        _datepicker_ipad.hidden=NO;
//        
//        [_datepicker_ipad addTarget:self action:@selector(picker2action) forControlEvents:UIControlEventValueChanged];
//    }
    

    //_picker.hidden=YES;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_dobtext_iphone) {
        
        
        [_dobtext_iphone resignFirstResponder];
        
        _datepicker_iphone.hidden=NO;
        
        
        [  _datepicker_iphone addTarget:self action:@selector(picker1action) forControlEvents:UIControlEventValueChanged];
    }
//    if (textField==_datetextfld_ipad) {
//        
//        
//        [_datepicker_ipad resignFirstResponder];
//        
//        _datepicker_ipad.hidden=NO;
//        
//        
//        [  _datepicker_ipad addTarget:self action:@selector(picker2action) forControlEvents:UIControlEventValueChanged];
//    }

    if(textField==_firstnametxtfld)
    {
        NSUInteger newLength = [_firstnametxtfld.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if(textField==_lastnametxtfld)
    {
        NSUInteger newLength = [_lastnametxtfld.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if(textField==_Addresstxtfld)
    {
        NSUInteger newLength = [_Addresstxtfld.text length] + [string length] - range.length;
        return (newLength > 250) ? NO : YES;
    }

    if(textField==_mobiletxtfld)
    {
        NSUInteger newLength = [_mobiletxtfld.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    if(textField==_homenumbertxtfld)
    {
        NSUInteger newLength = [_homenumbertxtfld.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }

    if(textField==_citytxtfld)
    {
        NSUInteger newLength = [_citytxtfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_ziptextflield)
    {
        NSUInteger newLength = [_ziptextflield.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    if(textField==_driverlicencetxtfld)
    {
        NSUInteger newLength = [_driverlicencetxtfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_nameinlicencetxtfld)
    {
        NSUInteger newLength = [_nameinlicencetxtfld.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    if(textField==_emergencytxtfld)
    {
        NSUInteger newLength = [_emergencytxtfld.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }

    if(textField==_contactnumbtxtfld)
    {
        NSUInteger newLength = [_contactnumbtxtfld.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    if(textField==_emailtxtfld)
    {
        NSUInteger newLength = [_emailtxtfld.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }

    if(textField==_alternativenumtxtfld)
    {
        NSUInteger newLength = [_alternativenumtxtfld.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
//    if(textField==_stateissuetxtfld)
//    {
//        NSUInteger newLength = [_stateissuetxtfld.text length] + [string length] - range.length;
//        return (newLength > 50) ? NO : YES;
//    }
    if(textField==_firstnametxt_iphone)
    {
        NSUInteger newLength = [_firstnametxt_iphone.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if(textField==_lastnametxt_iphone)
    {
        NSUInteger newLength = [_lastnametxt_iphone.text length] + [string length] - range.length;
        return (newLength > 25) ? NO : YES;
    }
    if(textField==_homeaddresstxt_iphone)
    {
        NSUInteger newLength = [_homeaddresstxt_iphone.text length] + [string length] - range.length;
        return (newLength > 250) ? NO : YES;
    }
    
    if(textField==_mobilenotext_iphone)
    {
        NSUInteger newLength = [_mobilenotext_iphone.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    if(textField==_homenotxt_iphone)
    {
        NSUInteger newLength = [_homenotxt_iphone.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    
    if(textField==_citytxt_iphone)
    {
        NSUInteger newLength = [_citytxt_iphone.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_ziptxt_iphone)
    {
        NSUInteger newLength = [_ziptxt_iphone.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    if(textField==_drivinglicenceno_iphone)
    {
        NSUInteger newLength = [_drivinglicenceno_iphone.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_nameonlicenct_iphone)
    {
        NSUInteger newLength = [_nameonlicenct_iphone.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    if(textField==_emergencycontactnametxt_iphone)
    {
        NSUInteger newLength = [_emergencycontactnametxt_iphone.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    if(textField==_contactnotxt_iphone)
    {
        NSUInteger newLength = [_contactnotxt_iphone.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    if(textField==_emailtxt_iphone)
    {
        NSUInteger newLength = [_emailtxt_iphone.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    
    if(textField==_alternatenotxt_iphone)
    {
        NSUInteger newLength = [_alternatenotxt_iphone.text length] + [string length] - range.length;
        return (newLength > 12) ? NO : YES;
    }
    if(textField==_stateissuetxt_iphone)
    {
        NSUInteger newLength = [_stateissuetxt_iphone.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }



        
    //_picker.hidden=YES;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
    {
        if(textField==_emailtxtfld){
            NSString *estring=_emailtxtfld.text;
            if (estring.length==0) {
                
            }
            else
            {
            Validation *val=[[Validation alloc]init];
            BOOL bEmailValid = [val validEmailAddress:[_emailtxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
               if(bEmailValid)
             {
                // email valid, other validations in the form
             }
             else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            }
        }


    if(textField==_mobiletxtfld)
    {
        mobilenostring=_mobiletxtfld.text ;
        if ([mobilenostring length]<10) {
               if([mobilenostring isEqualToString:@""])
               {
                   
               }
               else
               {
                   phonex=1;
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
        
        [alert show];
        
               }
        
    }
        else
        {
        Validation*val=[[Validation alloc]init];
        int value1=[val isdataformat:_mobiletxtfld.text];
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
            
        }

    else
    {
        mobilenostring=_mobiletxtfld.text;
        
        
        //checking a particular charector
        // NSString *connectstring;
        NSString*new=[mobilenostring substringWithRange:NSMakeRange(3, 1)];
        NSString*new1=[mobilenostring substringWithRange:NSMakeRange(7, 1)];
        
        
        
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *resultString = [[mobilenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        NSLog (@"Result: %@", resultString);
        if ([resultString length]<=9){
            
             phonex=1;
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
        
        
        
        if ([mobilenostring length]==12) {
            
            
            
            
            
            
            if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                _connectmobile=mobilenostring;
                phonex=2;
            }
            else
            {
                 phonex=1;
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
            }
            
        }
        
        
        
        if ([resultString length]==10){
            
            
             phonex=2;
            
            NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
            NSLog(@"%@",subString);
            NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
            NSLog(@"%@",substring2);
            NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
            NSLog(@"%@",substring3);
            _connectmobile=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
            NSLog(@"%@",_connectmobile);
            
            
            
            
            _mobiletxtfld.text=_connectmobile;
            
        }
        
        
        
        
        
        if ([resultString length]==11){
            
             phonex=1;
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
        }
        }
        
    }
}
    if(textField==_homenumbertxtfld)
    {
    
        homenostring=_homenumbertxtfld.text;
    
    if ([homenostring length]<10) {
        if([homenostring isEqualToString:@""])
        {
            
        }
        else
        { phonex=1;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];

        }
        
        
        
    }
    else
    {
        Validation*val=[[Validation alloc]init];
        int value1=[val isdataformat:_homenumbertxtfld.text];
        if(value1==0)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
            
        }

    else
    {
        homenostring=_homenumbertxtfld.text;
        
        
        //checking a particular charector
        // NSString *connectstring;
        NSString*new=[homenostring substringWithRange:NSMakeRange(3, 1)];
        NSString*new1=[homenostring substringWithRange:NSMakeRange(7, 1)];
        
        
        
        NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
        NSString *resultString = [[homenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
        NSLog (@"Result: %@", resultString);
        if ([resultString length]<=9){
            
            
             phonex=1;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
        
        
        if ([homenostring length]==12) {
            
            
            
            
            
            
            if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                _connecthome=homenostring;
                 phonex=2;
            }
            else
            { phonex=1;
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
            }
            
        }
        
        
        
        if ([resultString length]==10){
            
            
             phonex=2;
            
            NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
            NSLog(@"%@",subString);
            NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
            NSLog(@"%@",substring2);
            NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
            NSLog(@"%@",substring3);
            _connecthome=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
            NSLog(@"%@",_connecthome);
            
            
            
            
            _homenumbertxtfld.text=_connecthome;
            
        }
        
        
        
        
        
        if ([resultString length]==11){
            
            
             phonex=1;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
        }
    }
    }
    }

    if(textField==_contactnumbtxtfld)
    {
        contactnostring=_contactnumbtxtfld.text;
        if ([contactnostring length]<10) {
            if([contactnostring isEqualToString:@""])
            {
                
            }
            else
            {
                 phonex=1;
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
            
            [alert show];
            
            }
            
        }
        else
        {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_contactnumbtxtfld.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

        
        else
        {
            contactnostring=_contactnumbtxtfld.text;
            
            
            //checking a particular charector
            // NSString *connectstring;
            NSString*new=[contactnostring substringWithRange:NSMakeRange(3, 1)];
            NSString*new1=[contactnostring substringWithRange:NSMakeRange(7, 1)];
            
            
            
            NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
            NSString *resultString = [[contactnostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
            NSLog (@"Result: %@", resultString);
            if ([resultString length]<=9){
                
                 phonex=1;
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
            
            
            if ([contactnostring length]==12) {
                
                
                
                
                
                
                if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                    _connectcontact=contactnostring;
                     phonex=2;
                }
                else
                {
                     phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                }
                
            }
            
            
            
            if ([resultString length]==10){
                
                
                phonex=2;
                
                NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                NSLog(@"%@",subString);
                NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                NSLog(@"%@",substring2);
                NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                NSLog(@"%@",substring3);
                _connectcontact=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                NSLog(@"%@",_connectcontact);
                
                
                
                
                _contactnumbtxtfld.text=_connectcontact;
                
            }
            
            
            
            
            
            if ([resultString length]==11){
                
                 phonex=1;
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
        }
        }

    }
    if(textField==_alternativenumtxtfld)
    {
        
        alternatenostring=_alternativenumtxtfld.text;
        
        if ([alternatenostring length]<10) {
            if ([alternatenostring isEqualToString:@""])
            {
            
            }
            else
            {
                 phonex=1;
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];

            }
            
            
            
        }
        else
        {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_alternativenumtxtfld.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

        else
        {
            alternatenostring=_alternativenumtxtfld.text;
            
            
            //checking a particular charector
            // NSString *connectstring;
            NSString*new=[alternatenostring substringWithRange:NSMakeRange(3, 1)];
            NSString*new1=[alternatenostring substringWithRange:NSMakeRange(7, 1)];
            
            
            
            NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
            NSString *resultString = [[alternatenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
            NSLog (@"Result: %@", resultString);
            if ([resultString length]<=9){
                
                 phonex=1;
                
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
            
            
            if ([alternatenostring length]==12) {
                
                
                
                
                
                
                if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                    _connectalternate=alternatenostring;
                    phonex=2;
                }
                else
                {
                     phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                }
                
            }
            
            
            
            if ([resultString length]==10){
                
                
                phonex=2;
                
                NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                NSLog(@"%@",subString);
                NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                NSLog(@"%@",substring2);
                NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                NSLog(@"%@",substring3);
                _connectalternate=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                NSLog(@"%@",_connectalternate);
                
                
                
                
                _alternativenumtxtfld.text=_connectalternate;
                
            }
            
            
            
            
            
            if ([resultString length]==11){
                
                
                 phonex=1;
                UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                
                [alert show];
                
            }
            
        }
    }
    }
        if(textField==_ziptextflield)
        {
            NSString *zstring=_ziptextflield.text ;
            if (zstring.length==0)
            {
                
            }
            else
            {
            Validation*val=[[Validation alloc]init];
                int value1=[val isNumeric:_ziptextflield.text] ;
                if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Zip" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }
            }

        }
    }
    
    else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        if(textField==_emailtxt_iphone){
            
            Validation *val=[[Validation alloc]init];
            BOOL bEmailValid = [val validEmailAddress:_emailtxt_iphone.text];
            if(bEmailValid)
            {
                // email valid, other validations in the form
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            
            
        }

        if(textField==_mobilenotext_iphone)
        {
            mobilenostring=_mobilenotext_iphone.text;
            if ([mobilenostring length]<10) {
                if([mobilenostring isEqualToString:@""])
                {
                    
                }
                else
                {
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
            }
            else
            {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_mobilenotext_iphone.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

            else
            {
                mobilenostring=_mobilenotext_iphone.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[mobilenostring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[mobilenostring substringWithRange:NSMakeRange(7, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[mobilenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                if ([resultString length]<=9){
                    
                    phonex=1;
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                if ([mobilenostring length]==12) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connectmobile=mobilenostring;
                        phonex=2;
                    }
                    else
                    {
                        phonex=1;
                        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                        
                        [alert show];
                    }
                    
                }
                
                
                
                if ([resultString length]==10){
                    
                    
                    phonex=2;
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                    NSLog(@"%@",substring3);
                    _connectmobile=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectmobile);
                    
                    
                    
                    
                    _mobilenotext_iphone.text=_connectmobile;
                    
                }
                
                
                
                
                
                if ([resultString length]==11){
                    
                    phonex=1;
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Mobile Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
            }
            }
        }
        if(textField==_homenotxt_iphone)
        {
            
            homenostring=_homenotxt_iphone.text;
            
            
            if ([homenostring length]<10) {
                if([homenostring isEqualToString:@""])
                {
                    
                }
                else
                { phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                
            }
            else
            {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_homenotxt_iphone.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

            else
            {
                homenostring=_homenotxt_iphone.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[homenostring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[homenostring substringWithRange:NSMakeRange(7, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[homenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                if ([resultString length]<=9){
                    
                    
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                if ([homenostring length]==12) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connecthome=homenostring;
                        phonex=2;
                    }
                    else
                    { phonex=1;
                        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                        
                        [alert show];
                    }
                    
                }
                
                
                
                if ([resultString length]==10){
                    
                    
                    phonex=2;
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                    NSLog(@"%@",substring3);
                    _connecthome=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connecthome);
                    
                    
                    
                    
                  _homenotxt_iphone.text=_connecthome;
                    
                }
                
                
                
                
                
                if ([resultString length]==11){
                    
                    
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Home Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
            }
            }
        }
        
        if(textField==_contactnotxt_iphone)
        {
            contactnostring=_contactnotxt_iphone.text;
            if ([contactnostring length]<10) {
                if([contactnostring isEqualToString:@""])
                {
                    
                }
                else
                {
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
            }
            else
            {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_contactnotxt_iphone.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

            else
            {
                contactnostring=_contactnotxt_iphone.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[contactnostring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[contactnostring substringWithRange:NSMakeRange(7, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[contactnostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                if ([resultString length]<=9){
                    
                    phonex=1;
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                if ([contactnostring length]==12) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connectcontact=contactnostring;
                        phonex=2;
                    }
                    else
                    {
                        phonex=1;
                        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                        
                        [alert show];
                    }
                    
                }
                
                
                
                if ([resultString length]==10){
                    
                    
                    phonex=2;
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                    NSLog(@"%@",substring3);
                    _connectcontact=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectcontact);
                    
                    
                    
                    
                  _contactnotxt_iphone.text=_connectcontact;
                    
                }
                
                
                
                
                
                if ([resultString length]==11){
                    
                    phonex=1;
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Contact Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
            }
            }
            
        }
        if(textField==_alternatenotxt_iphone)
        {
            
            alternatenostring=_alternatenotxt_iphone.text;
            
            
            if ([alternatenostring length]<10) {
                if ([alternatenostring isEqualToString:@""])
                {
                    
                } else
                {
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                
            }
            else
            {
            Validation*val=[[Validation alloc]init];
            int value1=[val isdataformat:_alternatenotxt_iphone.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }

            else
            {
                alternatenostring=_alternatenotxt_iphone.text;
                
                
                //checking a particular charector
                // NSString *connectstring;
                NSString*new=[alternatenostring substringWithRange:NSMakeRange(3, 1)];
                NSString*new1=[alternatenostring substringWithRange:NSMakeRange(7, 1)];
                
                
                
                NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];
                NSString *resultString = [[alternatenostring componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
                NSLog (@"Result: %@", resultString);
                if ([resultString length]<=9){
                    
                    phonex=1;
                    
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
                
                if ([alternatenostring length]==12) {
                    
                    
                    
                    
                    
                    
                    if ([new  isEqualToString:@"-"]&&[new1  isEqualToString:@"-"]) {
                        _connectalternate=alternatenostring;
                        phonex=2;
                    }
                    else
                    {
                        phonex=1;
                        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                        
                        [alert show];
                    }
                    
                }
                
                
                
                if ([resultString length]==10){
                    
                    
                    phonex=2;
                    
                    NSString *subString = [resultString substringWithRange:NSMakeRange(0,3)];
                    NSLog(@"%@",subString);
                    NSString *substring2=[resultString  substringWithRange:NSMakeRange(3,3)];
                    NSLog(@"%@",substring2);
                    NSString *substring3=[resultString  substringWithRange:NSMakeRange(6,4)];
                    NSLog(@"%@",substring3);
                    _connectalternate=[NSString stringWithFormat:@"%@-%@-%@",subString,substring2,substring3];
                    NSLog(@"%@",_connectalternate);
                    
                    
                    
                    
                   _alternatenotxt_iphone.text=_connectalternate;
                    
                }
                
                
                
                
                
                if ([resultString length]==11){
                    
                    
                    phonex=1;
                    UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Alternative Number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil , nil];
                    
                    [alert show];
                    
                }
                
            }
        }

    }
        if(textField==_ziptxt_iphone)
        {
            
            Validation*val=[[Validation alloc]init];
            int value1=[val isNumeric:_ziptxt_iphone.text];
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Zip" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
                
                
            }
            
        }

    }
    
}
#pragma mark - Uploadimage webservice


-(void)UploadImage{
    upint=1;
    recordResults = FALSE;
    NSString *soapMessage;
    
    
 
               NSString *imagename=[NSString stringWithFormat:@"Photo_%@.png",_ssntxtfld.text];
        
    
    // NSString *cmpnyname=@"arvin";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UploadImage xmlns=\"http://ios.kontract360.com/\">\n"
                   "<f>%@</f>\n"
                   "<fileName>%@</fileName>\n"
                   "<appid>%d</appid>\n"
                   "</UploadImage>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_encodedString,imagename,_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UploadImage" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)FetchImage{
    upint=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    
  //  NSString *imagename=[NSString stringWithFormat:@"Photo_%@.png",_ssntxtfld.text];
    
    
    // NSString *cmpnyname=@"arvin";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<FetchImageHR xmlns=\"http://ios.kontract360.com/\">\n"
                                     
                   "<appid>%d</appid>\n"
                   "<photo>%@</photo>\n"
                   "</FetchImageHR>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,photostring];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/FetchImageHR" forHTTPHeaderField:@"Soapaction"];
    
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



- (void)handlePinch:(UITapGestureRecognizer *)pinchGestureRecognizer
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
#pragma mark-ImagePicker
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // [self.popoverController dismissPopoverAnimated:true];
    
    _uploadlbl.hidden=YES;
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        _imgvw.image=nil;

        NSLog(@"dict%@",info);
        
        
        
         _imgvw.image =image;
        
            [self dismissViewControllerAnimated:YES completion:nil];
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
//camera in lanscapemode

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        return NO;
    }
    else {
        return YES;
    }
}
-(IBAction)returnkey:(id)sender{
    [sender resignFirstResponder];
}



#pragma mark-Sqlite database for ipad
-(void)UPdateDBipad
{
    NSLog(@"PRIMARYID%@",_sqlitessn);

    if(_gendersegmentcntrl.selectedSegmentIndex==0)
    {
        genderstg=1;
    }
    else if(_gendersegmentcntrl.selectedSegmentIndex==1)
    {
        genderstg=0;
    }
    
    
    sqlite3_stmt *statement;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        NSString *updateSql=[NSString stringWithFormat:@"UPDATE UserList SET Suffix= \"%@\",LastName=\"%@\",FirstName=\"%@\",HomeAddress = \"%@\",City = \"%@\",State= \"%@\",Zip= \"%@\",SSN= \"%@\",Country= \"%@\",DateOfBirth= \"%@\",Gender= \"%d\",EmailID= \"%@\",MobileNO= \"%@\",HomeNO= \"%@\",EmergencyContactName= \"%@\",ContactNO= \"%@\",AlternateNO= \"%@\",LicenceNO= \"%@\",StateIssueingLicence= \"%@\",NameInLicence= \"%@\" WHERE ID= %@",_sufixbtnlbl.titleLabel.text, _lastnametxtfld.text,_firstnametxtfld.text,_Addresstxtfld.text,_citytxtfld.text,_statebtnlbl.titleLabel.text,_ziptextflield.text,_ssntxtfld.text,_countrybtnlbl.titleLabel.text,_datetextfld_ipad.text,genderstg,_emailtxtfld.text,_mobiletxtfld.text,_homenumbertxtfld.text,_emergencytxtfld.text,_contactnumbtxtfld.text,_alternativenumtxtfld.text,_driverlicencetxtfld.text,_stateissuebtn.titleLabel.text,_nameinlicencetxtfld.text,_sqlitessn];
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

-(void)FetchuserdetailsfromDBforipad{
    
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
                
                const char *suffix=(const char *)sqlite3_column_text(statement, 3);
                _userdetails.suffix=suffix==NULL ?nil:[[NSString alloc]initWithUTF8String:suffix];
                
                const char*lastname=(const char *)sqlite3_column_text(statement, 4);
                _userdetails.lastname=lastname==NULL ?nil:[[NSString alloc]initWithUTF8String:lastname];
                
                const char*firstname=(const char *)sqlite3_column_text(statement, 5);
                _userdetails.firstname=firstname==NULL ?nil:[[NSString alloc]initWithUTF8String:firstname];

                const char*homeaddress=(const char *)sqlite3_column_text(statement, 6);
                _userdetails.homeaddress=homeaddress==NULL ?nil:[[NSString alloc]initWithUTF8String:homeaddress];
                
                const char*city=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.city=city==NULL ?nil:[[NSString alloc]initWithUTF8String:city];
                
                const char*state=(const char *)sqlite3_column_text(statement, 8);
                _userdetails.state=state==NULL ?nil:[[NSString alloc]initWithUTF8String:state];

                const char*zip=(const char *)sqlite3_column_text(statement, 9);
                _userdetails.zip=zip==NULL ?nil:[[NSString alloc]initWithUTF8String:zip];
                
                const char*country =(const char *)sqlite3_column_text(statement, 11);
                _userdetails.country=country==NULL ?nil:[[NSString alloc]initWithUTF8String:country];
                
                const char*dob =(const char *)sqlite3_column_text(statement, 12);
                _userdetails.dob=dob==NULL ?nil:[[NSString alloc]initWithUTF8String:dob];

                const char*gender =(const char *)sqlite3_column_text(statement, 13);
                NSString*gen =gender==NULL ?nil:[[NSString alloc]initWithUTF8String:gender];
                _userdetails.gender=[gen integerValue];
                
                const char*email =(const char *)sqlite3_column_text(statement, 14);
                _userdetails.emailid=email==NULL ?nil:[[NSString alloc]initWithUTF8String:email];
                
                const char*mobileno =(const char *)sqlite3_column_text(statement, 15);
                _userdetails.mobileno=mobileno==NULL ?nil:[[NSString alloc]initWithUTF8String:mobileno];
                
                const char*homeno =(const char *)sqlite3_column_text(statement, 16);
                _userdetails.homeno=homeno==NULL ?nil:[[NSString alloc]initWithUTF8String:homeno];
                
                const char*EmergencyContactName =(const char *)sqlite3_column_text(statement, 17);
                _userdetails.emergencycontactname=EmergencyContactName==NULL ?nil:[[NSString alloc]initWithUTF8String:EmergencyContactName];
                
                const char*ContactNO =(const char *)sqlite3_column_text(statement, 18);
                _userdetails.contactno=ContactNO==NULL ?nil:[[NSString alloc]initWithUTF8String:ContactNO];
                
                const char*AlternateNO =(const char *)sqlite3_column_text(statement, 19);
                _userdetails.alternateno=AlternateNO==NULL ?nil:[[NSString alloc]initWithUTF8String:AlternateNO];
                
                const char*LicenceNO =(const char *)sqlite3_column_text(statement, 20);
                _userdetails.licenceno=LicenceNO==NULL ?nil:[[NSString alloc]initWithUTF8String:LicenceNO];
                
                const char*StateIssueingLicence =(const char *)sqlite3_column_text(statement, 21);
                _userdetails.stateissuinglicence=StateIssueingLicence==NULL ?nil:[[NSString alloc]initWithUTF8String:StateIssueingLicence];
                
                const char*NameInLicence =(const char *)sqlite3_column_text(statement, 22);
                _userdetails.Nameinlicence=NameInLicence==NULL ?nil:[[NSString alloc]initWithUTF8String:NameInLicence];


                [_sqliteArray addObject:_userdetails];
                
                 
            }
        }
        
        sqlite3_finalize(statement);
        
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
    
}

-(void)updateImagetoDB{
        NSString *imagename=[NSString stringWithFormat:@"Photo_%@.png",_ssntxtfld.text];
    sqlite3_stmt *statement;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        NSString *updateSql=[NSString stringWithFormat:@"UPDATE UserList SET FileName=\"%@\",EncodedString=\"%@\"  WHERE ID= %@",imagename,_encodedString,_sqlitessn];
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
#pragma mark-Sqlite database for iphone
-(void)UPdateDBiphone
{
    NSLog(@"PRIMARYID%@",_sqlitessn);
    if(_gendersegment_iphone.selectedSegmentIndex==0)
    {
        genderstg=1;
    }
    else if(_gendersegment_iphone.selectedSegmentIndex==1)
    {
        genderstg=0;
    }
    sqlite3_stmt *statement;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        
        NSString *updateSql=[NSString stringWithFormat:@"UPDATE UserIphoneList SET Suffix= \"%@\",LastName=\"%@\",FirstName=\"%@\",HomeAddress = \"%@\",City = \"%@\",State= \"%@\",Zip= \"%@\",SSN= \"%@\",Country= \"%@\",DateOfBirth= \"%@\",Gender= \"%d\",EmailID= \"%@\",MobileNO= \"%@\",HomeNO= \"%@\",EmergencyContactName= \"%@\",ContactNO= \"%@\",AlternateNO= \"%@\",LicenceNO= \"%@\",StateIssueingLicence= \"%@\",NameInLicence= \"%@\" WHERE ID= %@",_suffixbtn_iphone.titleLabel.text, _lastnametxt_iphone.text,_firstnametxt_iphone.text,_homeaddresstxt_iphone.text,_citytxt_iphone.text,_statebtn_iphone.titleLabel.text,_ziptxt_iphone.text,_ssntextfield_iphone.text,_countrytxt_iphone.titleLabel.text,_dobtext_iphone.text,genderstg,_emailtxt_iphone.text,_mobilenotext_iphone.text,_homenotxt_iphone.text,_emergencycontactnametxt_iphone.text,_contactnotxt_iphone.text,_alternatenotxt_iphone.text,_drivinglicenceno_iphone.text,_stateissuetxt_iphone.text,_nameonlicenct_iphone.text,_sqlitessn];
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

-(void)FetchuserdetailsfromDBforiphone{
    
    const char *dbpath=[_databasePath UTF8String];
    sqlite3_stmt*statement;
    if (sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK) {
        NSString*query=[NSString stringWithFormat:@"SELECT * FROM UserIphoneList"];
        const char *query_stmt=[query UTF8String];
        
        if (sqlite3_prepare_v2(_newEmplyhrListDB, query_stmt, -1, &statement, NULL)==SQLITE_OK) {
            int i=0;
            while (sqlite3_step(statement)==SQLITE_ROW) {
                _userdetails=(UserDetails *)[_sqliteArray objectAtIndex:i];
                const char *key=(const char *)sqlite3_column_text(statement, 0);
                NSString *pkey= key == NULL ? nil : [[NSString alloc] initWithUTF8String:key];
                 _userdetails.primarykey=[pkey integerValue];
                
                const char *suffix=(const char *)sqlite3_column_text(statement, 3);
                _userdetails.suffix=suffix==NULL ?nil:[[NSString alloc]initWithUTF8String:suffix];
                
                const char*lastname=(const char *)sqlite3_column_text(statement, 4);
                _userdetails.lastname=lastname==NULL ?nil:[[NSString alloc]initWithUTF8String:lastname];
                
                const char*firstname=(const char *)sqlite3_column_text(statement, 5);
                _userdetails.firstname=firstname==NULL ?nil:[[NSString alloc]initWithUTF8String:firstname];
                
                const char*homeaddress=(const char *)sqlite3_column_text(statement, 6);
                _userdetails.homeaddress=homeaddress==NULL ?nil:[[NSString alloc]initWithUTF8String:homeaddress];
                
                const char*city=(const char *)sqlite3_column_text(statement, 7);
                _userdetails.city=city==NULL ?nil:[[NSString alloc]initWithUTF8String:city];
                
                const char*state=(const char *)sqlite3_column_text(statement, 8);
                _userdetails.state=state==NULL ?nil:[[NSString alloc]initWithUTF8String:state];
                
                const char*zip=(const char *)sqlite3_column_text(statement, 9);
                _userdetails.zip=zip==NULL ?nil:[[NSString alloc]initWithUTF8String:zip];
                
                const char*country =(const char *)sqlite3_column_text(statement, 11);
                _userdetails.country=country==NULL ?nil:[[NSString alloc]initWithUTF8String:country];
                
                const char*dob =(const char *)sqlite3_column_text(statement, 12);
                _userdetails.dob=dob==NULL ?nil:[[NSString alloc]initWithUTF8String:dob];
                
                const char*gender =(const char *)sqlite3_column_text(statement, 13);
                NSString*gen =gender==NULL ?nil:[[NSString alloc]initWithUTF8String:gender];
                _userdetails.gender=[gen integerValue];
                
                const char*email =(const char *)sqlite3_column_text(statement, 14);
                _userdetails.emailid=email==NULL ?nil:[[NSString alloc]initWithUTF8String:email];
                
                const char*mobileno =(const char *)sqlite3_column_text(statement, 15);
                _userdetails.mobileno=mobileno==NULL ?nil:[[NSString alloc]initWithUTF8String:mobileno];
                
                const char*homeno =(const char *)sqlite3_column_text(statement, 16);
                _userdetails.homeno=homeno==NULL ?nil:[[NSString alloc]initWithUTF8String:homeno];
                
                const char*EmergencyContactName =(const char *)sqlite3_column_text(statement, 17);
                _userdetails.emergencycontactname=EmergencyContactName==NULL ?nil:[[NSString alloc]initWithUTF8String:EmergencyContactName];
                
                const char*ContactNO =(const char *)sqlite3_column_text(statement, 18);
                _userdetails.contactno=ContactNO==NULL ?nil:[[NSString alloc]initWithUTF8String:ContactNO];
                
                const char*AlternateNO =(const char *)sqlite3_column_text(statement, 19);
                _userdetails.alternateno=AlternateNO==NULL ?nil:[[NSString alloc]initWithUTF8String:AlternateNO];
                
                const char*LicenceNO =(const char *)sqlite3_column_text(statement, 20);
                _userdetails.licenceno=LicenceNO==NULL ?nil:[[NSString alloc]initWithUTF8String:LicenceNO];
                
                const char*StateIssueingLicence =(const char *)sqlite3_column_text(statement, 21);
                _userdetails.stateissuinglicence=StateIssueingLicence==NULL ?nil:[[NSString alloc]initWithUTF8String:StateIssueingLicence];
                
                const char*NameInLicence =(const char *)sqlite3_column_text(statement, 22);
                _userdetails.Nameinlicence=NameInLicence==NULL ?nil:[[NSString alloc]initWithUTF8String:NameInLicence];
                
                
                 [_sqliteArray addObject:_userdetails];
                
                
            }
        }
        
        sqlite3_finalize(statement);
        
        
        
    }
    sqlite3_close(_newEmplyhrListDB);
    
}



@end
