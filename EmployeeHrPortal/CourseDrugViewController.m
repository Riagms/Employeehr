//
//  CourseDrugViewController.m
//  EmployeePortal
//
//  Created by GMSIndia1 on 8/19/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "CourseDrugViewController.h"

@interface CourseDrugViewController ()

@end

@implementation CourseDrugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"Requirement Details",@"Requirement Details");
        self.tabBarItem.image = [UIImage imageNamed:@"personal"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     j=0;
    _scroll_iphone.frame=CGRectMake(0, 0, 500,640);
    [_scroll_iphone setContentSize:CGSizeMake(500,640)];
    // Do any additional setup after loading the view from its nib.
    _detailstable.layer.borderWidth = 2.0;
     _detailstable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _reqtable_iphone.layer.borderWidth = 2.0;
    _reqtable_iphone.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;

    _monthArray=[[NSMutableArray alloc]initWithObjects:@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC",nil];
    _monthdictArray=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    _monthDictionary=[[NSMutableDictionary alloc]initWithObjects:_monthdictArray forKeys:_monthArray];
    _remonthDictionary=[[NSMutableDictionary alloc]initWithObjects:_monthArray forKeys:_monthdictArray];
    _yearArray=[[NSMutableArray alloc]initWithObjects:@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023", nil];

  
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
    UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(logoutAction)];

    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationController.navigationBarHidden=NO;
    for (UIView *subview in self.detailstable.subviews)
    {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewWrapperView"])
        {
            subview.frame = CGRectMake(0, 0,self.detailstable.bounds.size.width, self.detailstable.bounds.size.height);
        }
    }
    for (UIView *subview in self.reqtable_iphone.subviews)
    {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewWrapperView"])
        {
            subview.frame = CGRectMake(0, 0,self.reqtable_iphone.bounds.size.width, self.reqtable_iphone.bounds.size.height);
        }
    }
    
    _passdict=[[NSMutableDictionary alloc]init];
    [_passdict setObject:@"pass" forKey:@"1"];
    [_passdict setObject:@"fail" forKey:@"0"];
    _revpassdict=[[NSMutableDictionary alloc]init];
    [_revpassdict setObject:@"1" forKey:@"pass"];
     [_revpassdict setObject:@"0" forKey:@"fail"];
    

}
-(void)logoutAction{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"LOGOUT" message:@"Really Logout?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ////NSLog(@"buttonIndex%d",buttonIndex);
    
    
    if ([alertView.message isEqualToString:msgstrg]) {
        
        
         [self InsertApplicantRequirements];
         }

    if ([alertView.message isEqualToString:@"Really Logout?"]) {
        
        
        
        if (buttonIndex==0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"logout" object:self userInfo:nil];
        
    }
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
      [self InsertApplicantRequirements];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
  //  [self DeleteApplicantRequirements];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView==_popOverTableView) {
        
        switch (Poptype) {
            case 1:
                return [_monthArray count];
                break;
            case 2:
                return [_yearArray count];
                break;
            case 3:
                return [_passdict count];
                break;

        }
    }
    if(tableView==_detailstable||tableView==_reqtable_iphone||tableView==_checktable_iphone)
    {
        return [_requirementArray count];
        
    }
  
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
           //cell.accessoryType = UITableViewCellAccessoryNone;
        if(tableView==_detailstable)
        {
            
            
            [[NSBundle mainBundle]loadNibNamed:@"CourseDrugCellView" owner:self options:nil];
           // cell.accessoryType = UITableViewCellAccessoryNone;
            cell=_detailcell;
        }
        if(tableView==_reqtable_iphone)
        {
            
            
            [[NSBundle mainBundle]loadNibNamed:@"CourseDrugCell_iphone" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell=_reqcell_iphone;
        }
//        if (tableView==_checktable) {
//            [[NSBundle mainBundle]loadNibNamed:@"requirementcell" owner:self options:nil];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell=_checkcell;
//
//        }
        if (tableView==_checktable_iphone) {
            [[NSBundle mainBundle]loadNibNamed:@"requirementcell_iphone" owner:self options:nil];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell=_checkcell_iphone;
            
        }

        
        
    }
    if (tableView==_popOverTableView) {
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        
        switch (Poptype) {
            case 1:
                cell.textLabel.text=[_monthArray objectAtIndex:indexPath.row];
                break;
            case 2:
                cell.textLabel.text=[_yearArray objectAtIndex:indexPath.row];
                break;
            case 3:
                
                cell.textLabel.text=[[_passdict allValues] objectAtIndex:indexPath.row];
                break;
        }
    }
    if(tableView==_detailstable)
        
        
    {
        Coursemdl*coursemdl1=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
        NSLog(@"indexpat%d",indexPath.row);
        _requirmentlbl=(UILabel *)[cell viewWithTag:1];
        _requirmentlbl.text=coursemdl1.itemname;
        //NSLog(@"lbl%@",)
        button=(UIButton*)[cell viewWithTag:2];
        [button setTitle:coursemdl1.month forState:UIControlStateNormal];
        yearbutton=(UIButton *)[cell viewWithTag:3];
        
        [yearbutton setTitle:coursemdl1.year forState:UIControlStateNormal];
        _codelbl=(UILabel *)[cell viewWithTag:4];
        _codelbl.text=coursemdl1.Code;
        
        if (coursemdl1.course_status==1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (coursemdl1.course_status==0){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        if ([coursemdl1.pass isEqualToString:@"1"]) {
            
            [_selectpass setTitle:@"pass" forState:UIControlStateNormal];
            
        }
        else{
            
            [_selectpass setTitle:@"fail" forState:UIControlStateNormal];
        }
        NSLog(@"expdate%@",coursemdl1.HaveExpiryDate);

        if([coursemdl1.HaveExpiryDate isEqualToString:@"true"]){
            _monthbtn.enabled=YES;
            _yearbtn.enabled=YES;

            
            
        }
        else{
          //  _monthbtn.hidden=YES;
          //  _yearbtn.hidden=YES;
            _monthbtn.enabled=NO;
            _yearbtn.enabled=NO;
        }
        
        
//        if (coursemdl2.course_status==1) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            
//        }else if (coursemdl2.course_status==0){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
        
        
        if ([_selectedcellstring isEqualToString:@"selected"]) {
            
            Coursemdl*coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
            
//            if(indexPath.row == selectedcell)
//            {
//                
//                if(cell.accessoryType==UITableViewCellAccessoryNone)
//                {
//                    
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    coursemdl3.course_status=1;
//                    //cell.selected = NO;
//                    
//                    
//                }
//                else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
//                {
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                   coursemdl3.course_status=0;
//                    //cell.selected=NO;
//                    
//                }
//                
//                
//            }
            
        }

        
    }
    
    if (tableView==_checktable) {
//        Coursemdl*coursemdl2=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
//        
//        cell.textLabel.text=coursemdl2.itemname;
//        
//        
//        
//        if (coursemdl2.course_status==1) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            
//        }else if (coursemdl2.course_status==0){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//       
//        if ([_selectedcellstring isEqualToString:@"selected"]) {
//            
//            Coursemdl*coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
//            
//            if(indexPath.row == selectedcell)
//            {
//                
//                if(cell.accessoryType==UITableViewCellAccessoryNone)
//                {
//                    
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    coursemdl3.course_status=1;
//                    //cell.selected = NO;
//                    
//                    
//                }
//                else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
//                {
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                    coursemdl3.course_status=0;
//                    //cell.selected=NO;
//                    
//                }
//                
//                
//            }
//            
//        }

    }
    if (tableView==_checktable_iphone)
    {
//        Coursemdl*coursemdl4=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
//        
//        cell.textLabel.text=coursemdl4.itemname;
//        
//        
//        
//        if (coursemdl4.course_status==1) {
//            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            
//        }else if (coursemdl4.course_status==0){
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//        
//        if ([_selectedcellstring isEqualToString:@"selected"]) {
//            
//            Coursemdl*coursemdl5=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
//            
//            if(indexPath.row == selectedcell)
//            {
//                
//                if(cell.accessoryType==UITableViewCellAccessoryNone)
//                {
//                    
//                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                    coursemdl5.course_status=1;
//                    //cell.selected = NO;
//                    
//                    
//                }
//                else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
//                {
//                    cell.accessoryType = UITableViewCellAccessoryNone;
//                    coursemdl5.course_status=0;
//                    //cell.selected=NO;
//                    
//                }
//                
//                
//            }
//            
//        }
        
    }
    
    if(tableView==_reqtable_iphone)
    {
        Coursemdl*coursemdl2=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
        _reqlabel_iphone=(UILabel *)[cell viewWithTag:1];
        _reqlabel_iphone.text=coursemdl2.itemname;
        //NSLog(@"lbl%@",)
        monthbtn_iphone=(UIButton*)[cell viewWithTag:2];
        [monthbtn_iphone setTitle:coursemdl2.month forState:UIControlStateNormal];
        yearbtn_iphone=(UIButton *)[cell viewWithTag:3];
        
        [yearbtn_iphone setTitle:coursemdl2.year forState:UIControlStateNormal];
//        _codelbl=(UILabel *)[cell viewWithTag:4];
//        _codelbl.text=coursemdl2.Code;
        
        if (coursemdl2.course_status==1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
        }else if (coursemdl2.course_status==0){
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        

        if ([_selectedcellstring isEqualToString:@"selected"]) {
            
            Coursemdl*coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:indexPath.row];
            
            if(indexPath.row == selectedcell)
            {
                
                if(cell.accessoryType==UITableViewCellAccessoryNone)
                {
                    
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    coursemdl3.course_status=1;
                    //cell.selected = NO;
                    
                    
                }
                else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    coursemdl3.course_status=0;
                    //cell.selected=NO;
                    
                }
                
                
            }
            
        }
        
    }

    
    
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Coursemdl*coursemdl2;
    Coursemdl*coursemdl3;
     Coursemdl*coursemdl4;
    if (Poptype==1) {
        
    
      CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.detailstable];
    NSIndexPath *textFieldIndexPath = [self.detailstable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    

    coursemdl2=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath.row];
    }
    if (Poptype==2) {
        
    
    CGPoint center1= yearbutton.center;
    CGPoint rootViewPoint1 = [yearbutton.superview convertPoint:center1 toView:self.detailstable];
    NSIndexPath *textFieldIndexPath1 = [self.detailstable indexPathForRowAtPoint:rootViewPoint1];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath1.row);

    coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath1.row];
    
    }
    if (Poptype==3) {
        
        
        CGPoint center1= segbutton.center;
        CGPoint rootViewPoint1 = [segbutton.superview convertPoint:center1 toView:self.detailstable];
        NSIndexPath *textFieldIndexPath1 = [self.detailstable indexPathForRowAtPoint:rootViewPoint1];
        NSLog(@"textFieldIndexPath%d",textFieldIndexPath1.row);
        
        coursemdl4=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath1.row];
        
    }

    if (tableView==_popOverTableView) {
        
        //Coursemdl*coursemdl2=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath.row];
        
        switch (Poptype) {
                
            case 1:
                
                path=indexPath.row;
                
               // button.enabled=YES;
            [button setTitle:[_monthArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
               
            coursemdl2.month=[_monthArray objectAtIndex:indexPath.row];
               //[button setTitle:coursemdl2.month forState:UIControlStateNormal];
                
                NSLog(@"_monthbtn.tag%@",coursemdl2.month);
                 NSLog(@"_monthbtn.tag%d",coursemdl2.reqid);
               // [_requirementArray addObject:coursemdl2];
                Poptype=0;
                
                
                
                break;
            case 2:
                
                [yearbutton setTitle:[_yearArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                coursemdl3.year=[_yearArray objectAtIndex:indexPath.row];
               // [_requirementArray addObject:coursemdl3];
                Poptype=0;
                break;
                
            case 3:
                
                [segbutton setTitle:[[_passdict allValues] objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                 NSLog(@"pass%@",[[_passdict allValues] objectAtIndex:indexPath.row]);
                
                coursemdl4.pass=[_revpassdict objectForKey:[[_passdict allValues] objectAtIndex:indexPath.row]];
                  NSLog(@"pass%@",coursemdl4.pass);
                // [_requirementArray addObject:coursemdl3];
                Poptype=0;
                break;

                
            default:
                break;
        }
      
        
    }
    if(tableView==_detailstable)
    {
        
        selectedcell=indexPath.row;
        _selectedcellstring=@"selected";
        [_detailstable reloadData];
    }
    if(tableView==_checktable)
    {
        
       // selectedcell=indexPath.row;
       // _selectedcellstring=@"selected";
        // [_checktable reloadData];
    }
    if(tableView==_checktable_iphone)
    {
        
        selectedcell=indexPath.row;
        _selectedcellstring=@"selected";
        [_checktable_iphone reloadData];
    }


    if(tableView==_reqtable_iphone)
    {
        
        selectedcell=indexPath.row;
        NSLog(@"%d",indexPath.row);
       // _selectedcellstring=@"selected";
        //[_reqtable_iphone reloadData];
    }

}


#pragma mark - webservice

-(void)InsertApplicantRequirements{
         webidfr=1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *fetchVariable = [defaults objectForKey:@"jobsiteid"];
    NSLog(@"%@",fetchVariable);
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    NSString *fetchVariable1 = [defaults1 objectForKey:@"CraftId"];
    NSLog(@"%@",fetchVariable1);

    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertApplicantRequirements xmlns=\"http://ios.kontract360.com/\">\n"
                   "<JobId>%d</JobId>\n"
                   "<CraftId>%d</CraftId>\n"
                   "<AppId>%d</AppId>\n"
                   "</InsertApplicantRequirements>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[fetchVariable integerValue],[fetchVariable1 integerValue] ,_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/InsertApplicantRequirements" forHTTPHeaderField:@"Soapaction"];
    
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


-(void)UpdateApplicantRequirements
{
    
    recordResults = FALSE;
    NSString *soapMessage;
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
     {
         for(int i=0;i<[_requirementArray count];i++)
    {
            NSInteger verifctnstatus=0;
            //NSInteger courseinteger=1;
        NSString*day=@"01";
       
       
       // NSLog(@"exdate%@",expirydate);
      
        Coursemdl*coursemdl1=(Coursemdl *)[_requirementArray objectAtIndex:i];
        
        NSInteger reqid=coursemdl1.reqid;
        NSString*mnth=[_monthDictionary objectForKey:coursemdl1.month];
        NSLog(@"yar%@",coursemdl1.year);
        NSString*expirydate=[NSString stringWithFormat:@"%@-%@-%@",coursemdl1.year,mnth,day];
    
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *fetchVariable = [defaults objectForKey:@"jobsiteid"];
        NSLog(@"%@",fetchVariable);
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   "<UpdateApplicantRequirements xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "<JobId>%d</JobId>\n"
                   "<ReqId>%d</ReqId>\n"
                   "<ExpiryDate>%@</ExpiryDate>\n"
                   "<CourseStatus>%d</CourseStatus>\n"
                   "<VerificationStatus>%d</VerificationStatus>\n"
                   "<CraftId>%d</CraftId>\n"
                   "<RequirementName>%@</RequirementName>\n"
                 "<pass>%d</pass>\n"
                   "</UpdateApplicantRequirements>\n"
                 
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,[fetchVariable integerValue],reqid,expirydate,coursemdl1.course_status,verifctnstatus,coursemdl1.craft,coursemdl1.itemname,[coursemdl1.pass integerValue]];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantRequirements" forHTTPHeaderField:@"Soapaction"];
    
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
     else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        for(int i=0;i<[_requirementArray count];i++)
        {
            NSInteger verifctnstatus=0;
            //NSInteger jobsiteid=1;
            NSString*day=@"01";
            
            
            // NSLog(@"exdate%@",expirydate);
            
            Coursemdl*coursemdliphone=(Coursemdl *)[_requirementArray objectAtIndex:i];
            
            NSInteger reqid=coursemdliphone.reqid;
            NSString*mnth=[_monthDictionary objectForKey:coursemdliphone.month];
            NSString*expirydate=[NSString stringWithFormat:@"%@-%@-%@",coursemdliphone.year,mnth,day];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *fetchVariable = [defaults objectForKey:@"jobsiteid"];
            NSLog(@"%@",fetchVariable);

            
            soapMessage = [NSString stringWithFormat:
                           
                           @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                           "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                           
                           
                           "<soap:Body>\n"
                           
                           "<UpdateApplicantRequirements xmlns=\"http://ios.kontract360.com/\">\n"
                           "<AppId>%d</AppId>\n"
                           "<JobId>%d</JobId>\n"
                           "<ReqId>%d</ReqId>\n"
                           "<ExpiryDate>%@</ExpiryDate>\n"
                           "<CourseStatus>%d</CourseStatus>\n"
                           "<VerificationStatus>%d</VerificationStatus>\n"
                           "<CraftId>%d</CraftId>\n"
                           "<RequirementName>%@</RequirementName>\n"
                           "</UpdateApplicantRequirements>\n"
                           "</soap:Body>\n"
                           "</soap:Envelope>\n",_Applicantid,[fetchVariable integerValue],reqid,expirydate,coursemdliphone.course_status,verifctnstatus,_coursemdl.craft,_coursemdl.itemname];
            NSLog(@"soapmsg%@",soapMessage);
            
            
          NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
             // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
            
            NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
            
            NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
            
            [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            
            [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantRequirements" forHTTPHeaderField:@"Soapaction"];
            
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
}

-(void)DeleteApplicantRequirements{
    webidfr=2;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteApplicantRequirements xmlns=\"http://ios.kontract360.com/\">\n"
                    "<AppId>%d</AppId>\n"
                   "</DeleteApplicantRequirements>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/DeleteApplicantRequirements" forHTTPHeaderField:@"Soapaction"];
    
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
    if (webidfr==2) {
        [self UpdateApplicantRequirements];
        webidfr=0;
    }

    if (webidfr==1) {
        
       // [self InsertApplicantRequirements];
        [_detailstable reloadData];
          _selectedcellstring=@"";
        webidfr=0;
    }

  
    
     [_reqtable_iphone reloadData];
    
    
    
}



#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"InsertApplicantRequirementsResult"])
    {
        _requirementArray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"EntryId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    
    if([elementName isEqualToString:@"ItemName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"Code"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"Type"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"pass"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"ApplyToAllCraft"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"HaveExpiryDate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"expir_date"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Default"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"status"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

    }
    if([elementName isEqualToString:@"craft"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"UpdateApplicantRequirementsResponse"])
    {
        
//        j++;
//        if (j==[_requirementArray count]-1) {
//            [self InsertApplicantRequirements];
//        }
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
          
    
    if([elementName isEqualToString:@"EntryId"])
    {
        _coursemdl=[[Coursemdl alloc]init];
        recordResults = FALSE;
        _coursemdl.reqid=[_soapResults integerValue];
        
        _soapResults=nil;
    }
    
    
    if([elementName isEqualToString:@"ItemName"])
    {
        recordResults = FALSE;
        _coursemdl.itemname=_soapResults;
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"Code"])
    {
         recordResults = FALSE;
        _coursemdl.Code=_soapResults;
        
        _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"Type"])
    {
        recordResults = FALSE;
        _coursemdl.Type=_soapResults;
        
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"ApplyToAllCraft"])
    {
        recordResults = FALSE;
        
        _coursemdl.ApplyToAllCraft=_soapResults;
        _soapResults=nil;    }
    
    if([elementName isEqualToString:@"HaveExpiryDate"])
    {
        recordResults = FALSE;
        _coursemdl.HaveExpiryDate=_soapResults;
        [_requirementArray addObject:_coursemdl];
        
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"expir_date"])
    {
        recordResults = FALSE;
        
        NSArray *dateArray=[[NSArray alloc]init];
        NSString*newstring=_soapResults;
         newstring=[newstring stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        dateArray=[newstring componentsSeparatedByString:@" "];
        NSString *date1 =[dateArray objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dates = [dateFormat dateFromString:date1];
        [dateFormat setDateFormat:@"MM-dd-yyy"];
        NSString *myFormattedDate = [dateFormat stringFromDate:dates];
       // _drugmdl.drugdate=

        
        
       
        
        
          _coursemdl.expdate=_soapResults;
        NSArray*newarray=[myFormattedDate componentsSeparatedByString:@"-"];
//        _coursemdl.month=[newarray objectAtIndex:0];
//        _coursemdl.year=[newarray objectAtIndex:2];
        _coursemdl.month=[_remonthDictionary objectForKey:[newarray objectAtIndex:0]];
    NSLog(@"mnth%@",_coursemdl.month);
     
      _coursemdl.year=[newarray objectAtIndex:2];
         NSLog(@"yar%@",_coursemdl.year);
    _soapResults=nil;
    }
    
    if([elementName isEqualToString:@"craft"])
    {
        recordResults = FALSE;
        _coursemdl.craft=[_soapResults integerValue];
        _soapResults=nil;
    }

    if([elementName isEqualToString:@"status"])
    {
        recordResults = FALSE;
        
//        if ([_soapResults isEqualToString:@"true"]) {
//            _coursemdl.course_status=1;
//            
//        }
//       
//        else if ([_soapResults isEqualToString:@"false"]){
//             _coursemdl.course_status=0;
//            
//        }
        
        _coursemdl.course_status=[_soapResults integerValue];
             NSLog(@"mdl%@",_requirementArray);
        _soapResults=nil;
    }
    if([elementName isEqualToString:@"pass"])
    {
       recordResults = FALSE;
        if ([_soapResults isEqualToString:@"false"]||[_soapResults isEqualToString:@"0"]) {
             _coursemdl.pass=@"0";
            
        }
        else{
             _coursemdl.pass=@"1";
        }
     

       

          _soapResults=nil;
    }

    if([elementName isEqualToString:@"result"])
    {
        j++;
        recordResults = FALSE;
       
      
        if (j==[_requirementArray count]) {
           
            msgstrg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
             j=0;
        }
      
        _soapResults=nil;
    }

  

       }


#pragma mark - Action

- (IBAction)continuebtn:(id)sender {
    
[self DeleteApplicantRequirements];
 
    //[_checktable reloadData];
    //_checkview.hidden=NO;
    //[self UpdateApplicantRequirements];
    
//    if (!self.raceVCtrl) {
//        _raceVCtrl=[[RaceViewController alloc]initWithNibName:@"RaceViewController" bundle:nil];
//    }
//    _raceVCtrl.applicantId=_Applicantid;
//    [self.navigationController pushViewController:_raceVCtrl animated:YES];
}

-(IBAction)selectMonth:(id)sender
{
  
    Poptype=1;
     
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
    
button = (UIButton *)sender;
    
    UITableViewCell *cell = (UITableViewCell *)button.superview;
    
    
    [self.popOverController1 presentPopoverFromRect:_monthbtn.frame
                                            inView:cell
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
  
 
}


-(IBAction)selectyear:(id)sender
{
    Poptype=2;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 60, 50)];
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
    
    
    yearbutton = (UIButton *)sender;
    
    UITableViewCell *cell = (UITableViewCell *)[[yearbutton superview] superview];
    
    
    
        

    [self.popOverController1 presentPopoverFromRect:_yearbtn.frame
                                             inView:cell
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];

}
-(IBAction)selectmonth_iphone:(id)sender
{
    monthbtn_iphone = (UIButton *)sender;
    
    //UITableViewCell *cell = (UITableViewCell *)[[monthbtn_iphone superview] superview];

    pickerstring=@"month";
    _monthpicker_iphone.hidden=NO;
    _yearpicker_iphone.hidden=YES;
    [_monthpicker_iphone reloadAllComponents];
}
-(IBAction)selectyear_iphone:(id)sender
{
   yearbtn_iphone = (UIButton *)sender;
    
    //UITableViewCell *cell = (UITableViewCell *)[[yearbtn_iphone superview] superview];
    pickerstring=@"year";
    _yearpicker_iphone.hidden=NO;
     _monthpicker_iphone.hidden=YES;
    [_yearpicker_iphone reloadAllComponents];
}
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView==_monthpicker_iphone)
    {
        return [_monthArray count];
    }
    else if(pickerView==_yearpicker_iphone)
    {
        return [_yearArray count];
    }
    return YES;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if(pickerView==_monthpicker_iphone)    {
        return [_monthArray objectAtIndex:row];
    }
    else if(pickerView==_yearpicker_iphone)
    {
        return [_yearArray objectAtIndex:row];
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
//    UITableViewCell *cell = (UITableViewCell *)[[monthbtn_iphone superview] superview];
//    UITableView *table = (UITableView *)[cell superview];
//    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
//    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
//    
//    
//    UITableViewCell *cell1 = (UITableViewCell *)[[yearbtn_iphone superview] superview];
//    UITableView *table1 = (UITableView *)[cell1 superview];
//    NSIndexPath *textFieldIndexPath1 = [table1 indexPathForCell:cell];
//    NSLog(@"textFieldIndexPath%d",textFieldIndexPath1.row);
// Coursemdl*coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath1.row];
    
        
        CGPoint center= monthbtn_iphone.center;
        CGPoint rootViewPoint = [monthbtn_iphone.superview convertPoint:center toView:self.reqtable_iphone];
        NSIndexPath *textFieldIndexPath = [self.reqtable_iphone indexPathForRowAtPoint:rootViewPoint];
        NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
        
    Coursemdl *coursemdl2;
        coursemdl2=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath.row];
   
        
        
        CGPoint center1= yearbtn_iphone.center;
        CGPoint rootViewPoint1 = [yearbtn_iphone.superview convertPoint:center1 toView:self.reqtable_iphone];
        NSIndexPath *textFieldIndexPath1 = [self.reqtable_iphone indexPathForRowAtPoint:rootViewPoint1];
        NSLog(@"textFieldIndexPath%d",textFieldIndexPath1.row);
        Coursemdl *coursemdl3;
        coursemdl3=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath1.row];
        
   
   if(pickerView==_monthpicker_iphone)
    {
        monthbtn_iphone.enabled=YES;
        [ monthbtn_iphone setTitle:[_monthArray objectAtIndex:row] forState:UIControlStateNormal];
        coursemdl2.month=[_monthArray objectAtIndex:row];
        _monthpicker_iphone.hidden=YES;
                
    }
    else if(pickerView==_yearpicker_iphone)
    {
        yearbtn_iphone.enabled=YES;
        [ yearbtn_iphone setTitle:[_yearArray objectAtIndex:row] forState:UIControlStateNormal];
         coursemdl3.year=[_yearArray objectAtIndex:row];
        _yearpicker_iphone.hidden=YES;
        
    }
    
}
-(IBAction)update_iphone:(id)sender
{
    [self DeleteApplicantRequirements];
    [_checktable_iphone reloadData];
    _checkview_iphone.hidden=NO;

}
-(IBAction)cancel_iphone:(id)sender
{
    
}

- (IBAction)checksave:(id)sender {
    
    _checkview.hidden=YES;
}
- (IBAction)checksave_iphone:(id)sender {
    _checkview_iphone.hidden=YES;
}

- (IBAction)segmntbtn:(id)sender {
    
    segbutton = (UIButton *)sender;
    CGPoint center= segbutton.center;
    //touchedpath=button.tag;
    CGPoint rootViewPoint = [segbutton.superview convertPoint:center toView:self.checktable];
    NSIndexPath *textFieldIndexPath = [self.checktable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
     Coursemdl*coumdl=(Coursemdl *)[_requirementArray objectAtIndex:textFieldIndexPath.row];

    
    if ([coumdl.pass isEqualToString:@"true"]) {
        _segmntbtnlbl.selectedSegmentIndex=1;
        selectedseg=0;
        coumdl.pass=@"0";
        
    }
    else{
         _segmntbtnlbl.selectedSegmentIndex=0;
        selectedseg=1;
        coumdl.pass=@"1";
    }
    
  //  [_requirementArray replaceObjectAtIndex:textFieldIndexPath.row withObject:coumdl];
    
   
}


- (IBAction)passbuttn:(id)sender {
    Poptype=3;
    
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 60, 70)];
    //200,250
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 60, 70)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorColor=[UIColor cyanColor];
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(60, 70);
    
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                               initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(60.0f, 70.0f);
    self.popOverController1=_popOverController1;
    
    
    segbutton = (UIButton *)sender;
    
    UITableViewCell *cell = (UITableViewCell *)segbutton.superview;
    
    
    [self.popOverController1 presentPopoverFromRect:_selectpass.frame
                                             inView:cell
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];

}
@end
