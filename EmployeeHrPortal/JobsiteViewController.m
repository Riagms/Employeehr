//
//  JobsiteViewController.m
//  EmployeeHrPortal
//
//  Created by GMSIndia1 on 9/5/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "JobsiteViewController.h"

@interface JobsiteViewController ()

@end

@implementation JobsiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"Jobsite Details", @"Jobsite Details");
       self.tabBarItem.image = [UIImage imageNamed:@"workicon"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    //[self.navigationController.navigationBar setHidden:YES];
    // Do any additional setup after loading the view from its nib.
    [self SelectEmployeeSkills];
    
    
    _expirydatetxtfld_iphone.inputView=[[UIView alloc] initWithFrame:CGRectZero];
    _skilltextflield_iphone.inputView=[[UIView alloc] initWithFrame:CGRectZero];
    _crafttxtflield_iphone.inputView=[[UIView alloc] initWithFrame:CGRectZero];
    _scrollview.frame=CGRectMake(0, 0,1024, 768);
    [ _scrollview setContentSize:CGSizeMake(1024,850)];
    
    
    _scroll_iphone.frame=CGRectMake(0, 0,320, 548);
    [_scroll_iphone setContentSize:CGSizeMake(320,7000)];
    
   
    _listtable.layer.borderWidth = 4.0;
    _listtable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _selectedtable.layer.borderWidth = 4.0;
    _selectedtable.layer.borderColor = [UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
   // _skillbtnlbl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _jobsitetable_iphone.layer.borderWidth=4.0;
    _jobsitetable_iphone.layer.borderColor=[UIColor colorWithRed:0/255.0f green:191/255.0f blue:255.0/255.0f alpha:1.0f].CGColor;
    _monthArray=[[NSMutableArray alloc]initWithObjects:@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC",nil];
    _monthdictArray=[[NSMutableArray alloc]initWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil];
    _monthDictionary=[[NSMutableDictionary alloc]initWithObjects:_monthdictArray forKeys:_monthArray];
    _remonthDictionary=[[NSMutableDictionary alloc]initWithObjects:_monthArray forKeys:_monthdictArray];
    _yearArray=[[NSMutableArray alloc]initWithObjects:@"2013",@"2014",@"2015",@"2016",@"2017",@"2018",@"2019",@"2020",@"2021",@"2022",@"2023", nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if(_basicPlussegment.selectedSegmentIndex==0)
    {
        _monthBtn.enabled=YES;
        _yearBtn.enabled=YES;
    }
    else if(_basicPlussegment.selectedSegmentIndex==1)
    {
        _monthBtn.enabled=NO;
        _yearBtn.enabled=NO;
    }

   
  
    self.navigationController.navigationBar.tintColor=[[UIColor alloc]initWithRed:16/255.0f green:78/255.0f blue:139/255.0f alpha:1];
    UIImage *buttonImage = [UIImage imageNamed:@"logout1"];
   UIBarButtonItem *logoutbutton=[[UIBarButtonItem alloc]initWithImage:[buttonImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleBordered target:self action:@selector(logoutAction)];
    
    
    NSArray *buttons=[[NSArray alloc]initWithObjects:logoutbutton,nil];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    self.navigationItem.hidesBackButton=YES;
   
    [self SelectJobs];
    
    
    [self SelectApplicantDetails];
    
    //[self SelectEmployeeCraft];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    if ([_Availablityresult isEqualToString:@"Yes"]) {
        
        [self UpdateApplicantDetails];

        
        
    }
    else if([_Availablityresult isEqualToString:@"No"]){
        
       
        
        
    }
    

    
    
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


#pragma mark - Actions

//- (IBAction)employeebtn:(id)sender {
//    
//    [self UpdateApplicantDetails];
//    if (!self.employeeVCtrl) {
//        _employeeVCtrl=[[EmployeeViewController alloc]initWithNibName:@"EmployeeViewController" bundle:nil];
//    }
//    _employeeVCtrl.Applicantid=_Applicantid;
//    _employeeVCtrl.jobsiteid=_Drugjobsiteid;
//    
//    _employeeVCtrl.craftid=_creftid;
//    
//    [self.navigationController pushViewController:_employeeVCtrl animated:YES];
//    
//    
//}

- (IBAction)continuebtn:(id)sender {
    // [self SelectEmployeeCraft];
    
    if ([_Availablityresult isEqualToString:@"Yes"]) {
        
        if (([_skillbtnlbl.titleLabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length ==0)||[_skillbtnlbl.titleLabel.text isEqualToString:@"Select"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Skill is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else{

        [self UpdateApplicantDetails];
            
        }
        
        
        
    }
    else if([_Availablityresult isEqualToString:@"No"]){
        
        
        [self savejobsitdetailstoDB];

        
    }

 
    
    
}

//- (IBAction)edubtn:(id)sender {
//    [self UpdateApplicantDetails];
//    if (!self.educatnVCtrl) {
//        _educatnVCtrl=[[EducationViewController alloc]initWithNibName:@"EducationViewController" bundle:nil];
//    }
//    _educatnVCtrl.Applicantid=_Applicantid;
//    [self.navigationController pushViewController:_educatnVCtrl animated:YES];
//    
//}
//
//- (IBAction)medicalbtn:(id)sender {
//    
//    
//    [self UpdateApplicantDetails];
//    if (!self.newmedVCtrl) {
//        _newmedVCtrl=[[NewMedicalViewController alloc]initWithNibName:@"NewMedicalViewController" bundle:nil];
//    }
//    _newmedVCtrl.Applicantid=_Applicantid;
//    [self.navigationController pushViewController:_newmedVCtrl animated:YES];
//    
//    //    if (!self.medicalVctrl) {
//    //        _medicalVctrl=[[MedicalViewController alloc]initWithNibName:@"MedicalViewController" bundle:nil];
//    //    }
//    //    _medicalVctrl.ApplicantId=_Applicantid;
//    //    [self.navigationController pushViewController:_medicalVctrl animated:YES];
//    //
//    
//}
//
//- (IBAction)basicbtn:(id)sender {
//    [self UpdateApplicantDetails];
//    if (!self.basicVCtrl) {
//        _basicVCtrl=[[BasicdetailsViewController alloc]initWithNibName:@"BasicdetailsViewController" bundle:nil];
//    }
//    _basicVCtrl.Applicantid=_Applicantid;
//    [self.navigationController pushViewController:_basicVCtrl animated:YES];
//    
//    
//    
//}
//
- (IBAction)clickbtn:(id)sender {
//    _nw=@"";
//    if (buttonclicked==0) {
//        //  _clickedbtnlbl.imageView.image=[UIImage imageNamed:@"check"];
//        [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
//        buttonclicked=1;
//        // [_listtable reloadData];
//    }
//    else if(buttonclicked==1){
//        [_clickedbtnlbl setSelected:NO];
//        
//        [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
//        buttonclicked=0;
//        
//    }
    _nw=@"";
    if (buttonclicked==0) {
        //  _clickedbtnlbl.imageView.image=[UIImage imageNamed:@"check"];
        [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        buttonclicked=1;
        // [_listtable reloadData];
    }
    else if(buttonclicked==1){
        [_clickedbtnlbl setSelected:NO];
        
        [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        buttonclicked=0;
        
    }

    // [_listtable reloadData];
    
}
/*Popover*/
- (IBAction)SelectMonth:(id)sender
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
    //create a popover controller
    self.popOverController1 = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController1.popoverContentSize=CGSizeMake(60.0f, 250.0f);
    self.popOverController1=_popOverController1;

       [self.popOverController1 presentPopoverFromRect:_monthBtn.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
    
}

- (IBAction)SelectYear:(id)sender
{
    Poptype=2;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 60, 250)];
    
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
   
    [self.popOverController1 presentPopoverFromRect:_yearBtn.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}
-(void)skillsPopover
{
    Poptype=3;
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
    
    [self.popOverController1 presentPopoverFromRect:_skillbtnlbl.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}
-(void)craftsPopover
{
    Poptype=4;
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
        [self.popOverController1 presentPopoverFromRect:_craftbtnlbl.frame
                                             inView:self.scrollview
                           permittedArrowDirections:UIPopoverArrowDirectionUp
                                           animated:YES];
    
}

- (IBAction)skillbtn:(id)sender {
  
    Poptype=3;
    skillclckd=1;

    [self SelectEmployeeSkills];
   
    [self skillsPopover];
   
    
}

- (IBAction)craftbtn:(id)sender {
    Poptype=4;
    craftclckd=1;
    [self SelectEmployeeCraft];
    [self craftsPopover];
}

//- (IBAction)race:(id)sender {
//    if (!self.raceVCtrl) {
//        _raceVCtrl=[[RaceViewController alloc]initWithNibName:@"RaceViewController" bundle:nil];
//    }
//    _raceVCtrl.applicantId=_Applicantid;
//    [self.navigationController pushViewController:_raceVCtrl animated:YES];
//    
//    
//    
//}
//
//- (IBAction)drugbtn:(id)sender {
//    [self UpdateApplicantDetails];
//    if (!self.drugVctrl) {
//        _drugVctrl=[[CourseDrugViewController alloc]initWithNibName:@"CourseDrugViewController" bundle:nil];
//    }
//    
//    _drugVctrl.Applicantid=_Applicantid;
//    _drugVctrl.jobsiteid=_Drugjobsiteid;
//    _drugVctrl.craftid=_creftid;
//    
//    _drugVctrl.Applicantid=_Applicantid;
//    [self.navigationController pushViewController:_drugVctrl animated:YES];
//    
//}


#pragma mark - Tableview
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
                return [_skillsArray count];
                break;
            case 4:
                return [_craftsArray count];
                break;
            default:
                break;
        }
        
    }
    
    
    if (tableView==_listtable||tableView==_jobsitetable_iphone) {
        return [_jobsiteArray count];
    }
    
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
              if (tableView==_listtable||tableView==_jobsitetable_iphone) {
            [[NSBundle mainBundle]loadNibNamed:@"JobsiteViewControlleripadcell" owner:self options:nil];
//                    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
//                             cell.accessoryType = UITableViewCellAccessoryNone;
//                         } else {
//                             cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                        }

    cell.accessoryType = UITableViewCellAccessoryNone;
            cell=_listtablecell;
            
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
                cell.textLabel.text=[_skillsArray objectAtIndex:indexPath.row];
                break;
            case 4:
                cell.textLabel.text=[_craftsArray objectAtIndex:indexPath.row];
                break;
                
            default:
                break;
        }
        
    }
    
    if (tableView==_listtable||tableView==_jobsitetable_iphone) {
        
        _jobnamelbl=(UILabel*)[cell viewWithTag:1];
        
        
        _jobnamelbl.text=[_jobsiteArray objectAtIndex:indexPath.row];
        
        
        
        NSString*jobs=[_jobsiteArray objectAtIndex:indexPath.row];
        
        
        if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
            
        
        
        if([_nw isEqualToString:@"SelectApplicant"])
        {
            
            
            NSLog(@"jobsite%@",_jobsite.jobsiteid);
            
            
            //NSString*jn=[_rejobiddict objectForKey:_jobsite.jobsiteid];
            
            //[arr objectAtIndex:[(_jobsite.jobsiteid)integerValue]-1];
            NSString *jn=[_rejobiddict objectForKey:[_jobsite.jobsiteid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            _Drugjobsiteid=_jobsite.jobsiteid;
            NSLog(@"jobsite%@",jn);
            if([jn isEqualToString:jobs])
            {
                
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                _clickedbtnlbl.enabled=NO;
                [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
                // buttonclicked=1;
            }
            
        }
        
        
        if ([_selectedrow isEqualToString:@"Selected"]) {
            //newcell=selectedcell;
            if(indexPath.row == selectedcell)
            {
                if(cell.accessoryType==UITableViewCellAccessoryNone)
                {
                   
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                    //cell.selected = NO;
                    _clickedbtnlbl.enabled=NO;
                    [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
                    buttonclicked=0;
                }
                
                
                else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    //cell.selected = NO;
                    _clickedbtnlbl.enabled=YES;
                     //  [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
                    buttonclicked=1;
                }
            }
            else{
                 cell.accessoryType = UITableViewCellAccessoryNone;
            }
            
            
        }
        }
        else{
        if([_nw isEqualToString:@"SelectApplicant"])
        {
            
            
        NSString *jn=[_rejobiddict objectForKey:[_jobsite.jobsiteid stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            
            _Drugjobsiteid=_jobsite.jobsiteid;
            NSLog(@"jobsite%@",jn);
            if([jn isEqualToString:jobs])
            {
                
                
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                _checkbtnlbl_iphone.enabled=NO;
                [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
                // buttonclicked=0;
            }
//            else{
//                cell.accessoryType = UITableViewCellAccessoryNone;
//                _checkbtnlbl_iphone.enabled=YES;
//                [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
//                 buttonclicked=1;
//            }

            
        }
            
            
            if ([_selectedrow isEqualToString:@"Selected"]) {
                
                if(indexPath.row == selectedcell)
                {
                    if(cell.accessoryType==UITableViewCellAccessoryNone)
                    {
                        cell.accessoryType = UITableViewCellAccessoryCheckmark;
                        //cell.selected = NO;
                       _checkbtnlbl_iphone.enabled=NO;
                        [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
                        buttonclicked=0;
                    }
                    
                    
                    else if(cell.accessoryType==UITableViewCellAccessoryCheckmark)
                    {
                        cell.accessoryType = UITableViewCellAccessoryNone;
                        //cell.selected = NO;
                       _checkbtnlbl_iphone.enabled=YES;
                        //   [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
                        buttonclicked=1;
                    }
                
                
                
            }
                else{
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }

        }

            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    


    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_listtable) {
        _selectedrow=@"Selected";
        _nw=@"";
        selectedcell=indexPath.row;
        newcell=1;
        
       [_listtable reloadData];
        
    }
    
    if (tableView==_jobsitetable_iphone) {
        _selectedrow=@"Selected";
        _nw=@"";
         newcell=1;
        selectedcell=indexPath.row;
        [_jobsitetable_iphone reloadData];

        
    }
    if (tableView==_popOverTableView) {
        
      
        
        switch (Poptype) {
            case 1:
                
                [_monthBtn setTitle:[_monthArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                
                break;
            case 2:
                
                [_yearBtn setTitle:[_yearArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                
                
                break;
            case 3:
                  skillindex=indexPath.row;
                [_skillbtnlbl setTitle:[_skillsArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                
                  [_craftbtnlbl setTitle:@"Select"forState:UIControlStateNormal];
                //_craftbtnlbl.enabled=YES;
                skillstring=[_skillsArray objectAtIndex:indexPath.row];
                
                break;
            case 4:
                craftindex=indexPath.row;
                [_craftbtnlbl setTitle:[_craftsArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
                // _creftid=   [_craftdict objectForKey:[_craftsArray objectAtIndex:indexPath.row]];
                
                
                break;
            default:
                break;
        }
        
    }
   // [self dismissViewControllerAnimated:YES completion:NULL];
    [self.popOverController1 dismissPopoverAnimated:YES];
    
}


#pragma mark - webservice
/*webservices*/

-(void)SelectJobs{
    //Poptype=3;
    reldint=1;
    recordResults = FALSE;
    NSString *soapMessage;
   
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectJobs xmlns=\"http://ios.kontract360.com/\">\n"
                   "</SelectJobs>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
      // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectJobs" forHTTPHeaderField:@"Soapaction"];
    
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
    
    


-(void)SelectEmployeeCraft{
    Poptype=4;
    recordResults = FALSE;
    NSString *soapMessage;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad) {
        
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectEmployeeCraft xmlns=\"http://ios.kontract360.com/\">\n"
                   "<SubType>%@</SubType>\n"
                   "</SelectEmployeeCraft>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",skillstring];
    NSLog(@"soapmsg%@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
   
   //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectEmployeeCraft" forHTTPHeaderField:@"Soapaction"];
    
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
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<SelectEmployeeCraft xmlns=\"http://ios.kontract360.com/\">\n"
                       "<SubType>%@</SubType>\n"
                       "</SelectEmployeeCraft>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_skilltextflield_iphone.text];
        NSLog(@"soapmsg%@",soapMessage);
        
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
       
       //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue:@"http://ios.kontract360.com/SelectEmployeeCraft" forHTTPHeaderField:@"Soapaction"];
        
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
-(void)SelectEmployeeSkills{
    Poptype=3;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectEmployeeSkills xmlns=\"http://ios.kontract360.com/\">\n"
                   "</SelectEmployeeSkills>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
   
   //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectEmployeeSkills" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)SelectApplicantDetails{
    //Poptype=3;
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectApplicantDetails xmlns=\"http://ios.kontract360.com/\">\n"
                   "<AppId>%d</AppId>\n"
                   "</SelectApplicantDetails>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid];
    NSLog(@"soapmsg%@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
   
   //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/SelectApplicantDetails" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UpdateApplicantDetails
{
    webtype=1;
    recordResults = FALSE;
    if ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad ) {
        
    
  
    if(_basicPlussegment.selectedSegmentIndex==0)
    {
        basicPlus=1;
    }
    else if(_basicPlussegment.selectedSegmentIndex==1)
    {
        basicPlus=0;
    }
    if(_ncerSegment.selectedSegmentIndex==0)
    {
        ncer=1;
    }
    else if(_ncerSegment.selectedSegmentIndex==1)
    {
        ncer=0;
    }
        NSString *skill;
      
        if (skillclckd==0) {
            skill =skillid;
            if (skill.length==0) {
                skill=@"0";
            }
        }
        
        else{
       skill=[_skilldict objectForKey:[_skillsArray objectAtIndex:skillindex]];
            
        }

        
        
     NSString *craft;
     if (craftclckd==0) {
        craft =_creftid;
        if (craft.length==0) {
            craft=@"0";
        }
    }
    
    else{
        craft= [_craftdict objectForKey: [_craftsArray objectAtIndex:craftindex]];
        
        
    }
    
    
    
    NSString *ncerdesc=_otherdesc.text;
    NSString *soapMessage;
    NSString *jobsite;
        
          jobsite=@"0";
//        if (selectedjobsite.length==0) {
//            jobsite=@"0";
//        }
//        else{
//            
//        }
//    if(buttonclicked==0)
//    {
//        if (newcell==1) {
//            
//        
//        jobsite=[_jobiddict objectForKey:[_jobsiteArray objectAtIndex:selectedcell]];
//            newcell=0;
//        }
//        else{
//            jobsite=selectedjobsite;
//        }
//        
//    }
//    else if(buttonclicked==1)
//    {
//        jobsite=@"0";
//    }
        NSString *dateString;
        NSString *month;
        NSString *year;
        if ([_monthBtn.titleLabel.text isEqualToString:@"MM"]) {
            
          month=@"01";
          
            
        }
        else{
    month=[_monthDictionary objectForKey:_monthBtn.titleLabel.text];
        }
        
        if ([_yearBtn.titleLabel.text isEqualToString:@"YYYY"]) {
            
            year=@"1990";
            
        }
        else{
            year=_yearBtn.titleLabel.text;

        }

      NSString *day=@"01";
    dateString=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
       // dateString=[NSString stringWithFormat:@"%@/%@/%@",month,day,year];
        
        
       
//        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//        [dateFormat setDateFormat: @"MM-dd-yyyy"];
//        
//        NSDate *dateString1 = [dateFormat dateFromString:_expirydatetxtfld_iphone.text];
//        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
//        [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
//        NSString* sqldate=[dateFormat1 stringFromDate:dateString1];
//
        
        
       
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateApplicantDetails xmlns=\"http://ios.kontract360.com/\">\n"
                   "<ApplicantId>%d</ApplicantId>\n"
                   "<JobsiteId>%@</JobsiteId>\n"
                   "<BasicPlus>%d</BasicPlus>\n"
                   "<BasicPlusExpiry>%@</BasicPlusExpiry>\n"
                   "<ApplicantNCERStatus>%d</ApplicantNCERStatus>\n"
                   "<ApplicantNCERDescription>%@</ApplicantNCERDescription>\n"
                   "<Skill>%@</Skill>\n"
                   "<Craft>%@</Craft>\n"
                   "</UpdateApplicantDetails>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_Applicantid,jobsite,basicPlus,dateString,ncer,ncerdesc,skill,craft];
    NSLog(@"soapmsg%@",soapMessage);
    
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
  
   //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantDetails" forHTTPHeaderField:@"Soapaction"];
    
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
        
        if(_saftysegment_iphone.selectedSegmentIndex==0)
        {
            basicPlus=1;
        }
        else if(_saftysegment_iphone.selectedSegmentIndex==1)
        {
            basicPlus=0;
        }
        if(_nccersegment_iphone.selectedSegmentIndex==0)
        {
            ncer=1;
        }
        else if(_nccersegment_iphone.selectedSegmentIndex==1)
        {
            ncer=0;
        }
        NSString *skill=[_skilldict objectForKey: _skilltextflield_iphone.text];
        NSString *craft;
        if ([_craftdict count]==0) {
            craft =_creftid;
        }
        
        else{
            craft= [_craftdict objectForKey: _crafttxtflield_iphone.text];
            
        }
        
        
        
        NSString *ncerdesc=_Othrtraing_iphone.text;
        NSString *soapMessage;
        NSString *jobsite;
          jobsite=@"0";
        
//        if(buttonclicked==0)
//        {
//            if (newcell==1) {
//                
//                
//                jobsite=[_jobiddict objectForKey:[_jobsiteArray objectAtIndex:selectedcell]];
//                newcell=0;
//            }
//            else{
//                jobsite=selectedjobsite;
//            }
//            
//        }
//        else if(buttonclicked==1)
//        {
//            jobsite=@"0";
//        }
        NSString *month=[_monthDictionary objectForKey:_monthBtn.titleLabel.text];
        NSString *year=_yearBtn.titleLabel.text;
        NSString *day=@"01";
        NSString *dateString=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
        NSLog(@"%@",dateString);
        
        
        NSDate*pickerdate=_datepicker_iphone.date;
        NSString *new=[NSString stringWithFormat:@"%@",pickerdate];
        NSArray *dateArray=[[NSArray alloc]init];
        dateArray=[new componentsSeparatedByString:@" "];
        NSString *date1 =[dateArray objectAtIndex:0];
        NSLog(@"skill%@",skill);
        
        

        
        soapMessage = [NSString stringWithFormat:
                       
                       @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                       "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                       
                       
                       "<soap:Body>\n"
                       
                       "<UpdateApplicantDetails xmlns=\"http://ios.kontract360.com/\">\n"
                       "<ApplicantId>%d</ApplicantId>\n"
                       "<JobsiteId>%@</JobsiteId>\n"
                       "<BasicPlus>%d</BasicPlus>\n"
                       "<BasicPlusExpiry>%@</BasicPlusExpiry>\n"
                       "<ApplicantNCERStatus>%d</ApplicantNCERStatus>\n"
                       "<ApplicantNCERDescription>%@</ApplicantNCERDescription>\n"
                       "<Skill>%@</Skill>\n"
                       "<Craft>%@</Craft>\n"
                       "</UpdateApplicantDetails>\n"
                       "</soap:Body>\n"
                       "</soap:Envelope>\n",_Applicantid,jobsite,basicPlus,date1,ncer,ncerdesc,skill,craft];
        NSLog(@"soapmsg%@",soapMessage);
         // NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/service.asmx"];
        
        
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
       //  // NSURL *url = [NSURL URLWithString:@"http://192.168.0.175/service.asmx"];
        
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
        
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        [theRequest addValue:@"http://ios.kontract360.com/UpdateApplicantDetails" forHTTPHeaderField:@"Soapaction"];
        
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
    
    
    [_jobsitetable_iphone reloadData];
    if (webtype==1) {
        _selectedrow=@"";

        [self SelectApplicantDetails];

        webtype=0;
    }
    if (reldint==1) {
         [_listtable reloadData];
    }
    
    else{
   
    
    [_popOverTableView reloadData];
    }
    
    [_datapicker1 reloadAllComponents];
    [_datapicker2 reloadAllComponents];
        [_popOverTableView reloadData];
    
}


#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    
    if([elementName isEqualToString:@"SelectJobsResult"])
    {
        _jobsiteArray=[[NSMutableArray alloc]init];
        _jobiddict=[[NSMutableDictionary alloc]init];
        _rejobiddict=[[NSMutableDictionary alloc]init];
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

   
    if([elementName isEqualToString:@"JobSiteName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SelectEmployeeSkillsResponse"])
    {
        _skillsArray=[[NSMutableArray alloc]init];
        _skilldict=[[NSMutableDictionary alloc]init];
        _skillArraydict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"SkillId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"SkillName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"SelectEmployeeCraftResponse"])
    {
        _craftsArray=[[NSMutableArray alloc]init];
        _craftdict=[[NSMutableDictionary alloc]init];
        _craftArraydict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"CraftId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"CraftName"])
    {
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
    if([elementName isEqualToString:@"Description"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"SelectApplicantDetailsResponse"])
    {
        _jobsitemodelarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"jobSite_Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"BasicPlus"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"BasicPlusExpiry"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"NCCERTStatus"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"NCCERTDescription"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"applicant_Skill"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"applicant_OtherCrafts"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Craftname"])
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
    if([elementName isEqualToString:@"JobSiteName"])
    {
        
        recordResults = FALSE;
        [_jobsiteArray addObject:_soapResults];
        [_jobiddict setObject:_unitstring forKey:_soapResults];
        
        [_rejobiddict setObject:_soapResults forKey:_unitstring];
        
        _soapResults = nil;
    }
    
    
    if([elementName isEqualToString:@"Id"])
    {
        recordResults = FALSE;
        _unitstring=_soapResults;
        
        
           _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"LastName"])
    {
        recordResults = FALSE;
       
        
        
        _soapResults = nil;
        
    }

   
    if([elementName isEqualToString:@"SSN"])
    {recordResults = FALSE;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_soapResults forKey:@"ssn"];
        [defaults synchronize];

        _soapResults = nil;
        
            }

    if([elementName isEqualToString:@"SkillId"])
    {
        
        recordResults = FALSE;
        _unitstring=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"SkillName"])
    {
        
        recordResults = FALSE;
        [_skilldict setObject:_unitstring forKey:_soapResults];
        [_skillArraydict setObject:_soapResults forKey:_unitstring];
        [_skillsArray addObject:_soapResults];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"CraftId"])
    {
        
        recordResults = FALSE;
        _unitstring=_soapResults;
    
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"CraftName"])
    {
        
        recordResults = FALSE;
        [_craftsArray addObject:_soapResults];
        [_craftdict setObject:_unitstring forKey:_soapResults];
        [_craftArraydict setObject:_soapResults forKey:_unitstring];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"EntryId"])
    {
        
        recordResults = FALSE;
        _unitstring=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Description"])
    {
        
        recordResults = FALSE;
        [_craftsArray addObject:_soapResults];
        [_craftdict setObject:_unitstring forKey:_soapResults];
        _soapResults = nil;
    }
    
    
    
    if([elementName isEqualToString:@"jobSite_Id"])
        
    {
        _jobsite=[[jobsite alloc]init];
        
        recordResults = FALSE;
        
        _jobsite.jobsiteid=_soapResults;
        
        
        selectedjobsite=_soapResults;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:_soapResults forKey:@"jobsiteid"];
        
        [defaults synchronize];

        if([_soapResults integerValue]==0)
        {
             _nw=@"";
            _checkbtnlbl_iphone.enabled=YES;
            _clickedbtnlbl.enabled=YES;
             [_clickedbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
            
            buttonclicked=1;
        }
        else{
            _nw=@"SelectApplicant";
             _jobsite.jobsiteid=_soapResults;

            
        }
       
        [_listtable reloadData];
        
        _soapResults = nil;
        
    }
    
    if([elementName isEqualToString:@"BasicPlus"])
    {
        recordResults = FALSE;
        _jobsite.safetycouncilstatus=_soapResults;
        
        if ([_soapResults isEqualToString:@"1"]) {
            _basicPlussegment.selectedSegmentIndex=0;
            _saftysegment_iphone.selectedSegmentIndex=0;
            
        }
        else  if ([_soapResults isEqualToString:@"0"]) {
            _basicPlussegment.selectedSegmentIndex=1;
            _saftysegment_iphone.selectedSegmentIndex=1;

        }
       
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"BasicPlusExpiry"])
    {
        recordResults = FALSE;
        _jobsite.safetycouncilexpiry=_soapResults;
        NSArray*Array=[[NSArray alloc]init];
        Array=[_soapResults componentsSeparatedByString:@"T"];
        
        NSArray*arry1=[[NSArray alloc]init];
        arry1=[[Array objectAtIndex:0]componentsSeparatedByString:@"-" ];
        
        [_yearBtn setTitle:[arry1 objectAtIndex:0] forState:UIControlStateNormal];
        NSLog(@"a%@",[arry1 objectAtIndex:1]);
        [_monthBtn setTitle:[_remonthDictionary objectForKey:[arry1 objectAtIndex:1]] forState:UIControlStateNormal];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dates = [dateFormat dateFromString:[Array objectAtIndex:0]];
        [dateFormat setDateFormat:@"MM-dd-yyy"];
        NSString *myFormattedDate = [dateFormat stringFromDate:dates];
        _expirydatetxtfld_iphone.text=myFormattedDate;
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"NCCERTStatus"])
    {
        recordResults = FALSE;
        
        _jobsite.nccertstatus=_soapResults;
        if ([_soapResults isEqualToString:@"1"]) {
            _ncerSegment.selectedSegmentIndex=0;
            _nccersegment_iphone.selectedSegmentIndex=0;
            
            
        }
        else  if ([_soapResults isEqualToString:@"0"]) {
            _ncerSegment.selectedSegmentIndex=1;
            _nccersegment_iphone.selectedSegmentIndex=1;

            
        }
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"NCCERTDescription"])
    {
        recordResults = FALSE;
        _jobsite.NCCERTDescription=_soapResults;
        _otherdesc.text=_soapResults;
        _Othrtraing_iphone.text=_soapResults;
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"applicant_Skill"])
    {
        recordResults = FALSE;
        _jobsite.ApplicantSkill=_soapResults;
        skillid=_soapResults;
        NSLog(@"_so%@",_soapResults);
        
        [_skillbtnlbl setTitle:[_skillArraydict objectForKey:_soapResults] forState:UIControlStateNormal];
        _skilltextflield_iphone.text=[_skillArraydict objectForKey:_soapResults];
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"applicant_OtherCrafts"])
    {
        recordResults = FALSE;
        _creftid=_soapResults;
        NSLog(@"_so%@",_soapResults);
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        [defaults1 setObject:_soapResults forKey:@"CraftId"];
        [defaults1 synchronize];

        
        //        _jobsite.ApplicantCraft=_soapResults;
        //
        //       _creftid=[_craftdict objectForKey:_soapResults];
        // [_craftbtnlbl setTitle:[_craftArraydict objectForKey:_soapResults] forState:UIControlStateNormal];
        //
        
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"Craftname"])
    {
        recordResults = FALSE;
        _jobsite.ApplicantCraft=_soapResults;
        
        [_craftbtnlbl setTitle:_soapResults forState:UIControlStateNormal];
        _crafttxtflield_iphone.text=_soapResults;
        [_jobsitemodelarray addObject:_jobsite];
        _soapResults = nil;
    }
    
    
}




#pragma mark - iphone Actions



- (IBAction)checkbtn_iphone:(id)sender {
    _nw=@"";
    if (buttonclicked==0) {
        //  _clickedbtnlbl.imageView.image=[UIImage imageNamed:@"check"];
        [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        buttonclicked=1;
        // [_listtable reloadData];
    }
    else if(buttonclicked==1){
        [_clickedbtnlbl setSelected:NO];
        
        [_checkbtnlbl_iphone setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        buttonclicked=0;
        
    }

    
}
#pragma mark - Textflield delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    
    
    
    if (textField==_expirydatetxtfld_iphone) {
        
       
        
        _datepicker_iphone.hidden=NO;
        
        [_datepicker_iphone addTarget:self action:@selector(pickeraction) forControlEvents:UIControlEventValueChanged];
    }
    if (textField==_skilltextflield_iphone) {
        [self SelectEmployeeSkills];
        _datapicker1.hidden=NO;
          _datapicker2.hidden=YES;
    }
    if (textField==_crafttxtflield_iphone) {
        [self SelectEmployeeCraft];
        _datapicker2.hidden=NO;
        _datapicker1.hidden=YES;
    }

    //_picker.hidden=YES;
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_expirydatetxtfld_iphone)  {
        
        
        
       
        _datepicker_iphone.hidden=NO;
        
        [_datepicker_iphone addTarget:self action:@selector(pickeraction) forControlEvents:UIControlEventValueChanged];
    }
//    if (textField==_expirydatetxtfld_iphone) {
//        _datepicker_iphone.hidden=YES;
//    }
    if (textField==_skilltextflield_iphone) {
        NSUInteger newLength = [_skilltextflield_iphone.text length] + [string length] - range.length;
        return (newLength > 100) ? NO : YES;

        _datapicker1.hidden=YES;
    }
    if (textField==_crafttxtflield_iphone) {
        NSUInteger newLength = [_crafttxtflield_iphone.text length] + [string length] - range.length;
        return (newLength > 100) ? NO : YES;

        _datapicker2.hidden=YES;
    }
    if(textField==_otherdesc)
    {
    NSUInteger newLength = [_otherdesc.text length] + [string length] - range.length;
    return (newLength > 50) ? NO : YES;
    }
    if(textField==_Othrtraing_iphone)
    {
        NSUInteger newLength = [_Othrtraing_iphone.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    //_picker.hidden=YES;
    return YES;
}

-(void)pickeraction{
    NSDate *date1  = _datepicker_iphone.date;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateStyle = NSDateFormatterMediumStyle;
    dateFormat.dateFormat=@"MM/dd/yyyy";
    _expirydatetxtfld_iphone.text = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date1]];
    _datepicker_iphone.hidden=YES;
    
    
}


- (IBAction)updatebtn_iphone:(id)sender {
    [self UpdateApplicantDetails];
}


-(IBAction)returnkey:(id)sender{
    [sender resignFirstResponder];
}

#pragma mark - Picker delegate
- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==_datapicker1) {
         return [_skillsArray count];
    }
    else if (pickerView==_datapicker2){
        
         return [_craftsArray count];
    }
    return YES;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
   
    
    if (pickerView==_datapicker1) {
         return [_skillsArray objectAtIndex:row];
    }
    else if (pickerView==_datapicker2){
        
         return [_craftsArray objectAtIndex:row];
    }
    
}


#pragma mark -
#pragma mark PickerView Delegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    if (pickerView==_datapicker1) {
    _skilltextflield_iphone.text =[_skillsArray objectAtIndex:row];
        _datapicker1.hidden=YES;
}
     if (pickerView==_datapicker2) {
         
         _crafttxtflield_iphone.text=[_craftsArray objectAtIndex:row];
           _datapicker2.hidden=YES;
     }
    
    
}
-(IBAction)CancelAction:(id)sender
{
//    [_monthBtn setTitle:@"" forState:UIControlStateNormal];
//    [_yearBtn setTitle:@""forState:UIControlStateNormal];
//    [_skillbtnlbl setTitle:@""forState:UIControlStateNormal];
//    [_craftbtnlbl setTitle:@""forState:UIControlStateNormal];
//     _otherdesc.text=@"";
}

- (IBAction)basicsegnt:(id)sender {
    
    if(_basicPlussegment.selectedSegmentIndex==0)
    {
        _monthBtn.enabled=YES;
        _yearBtn.enabled=YES;
    }
    else if(_basicPlussegment.selectedSegmentIndex==1)
    {
        _monthBtn.enabled=NO;
        _yearBtn.enabled=NO;
    }

}
-(IBAction)cancelaction_iphone:(id)sender
{
//    _expirydatetxtfld_iphone.text=@"";
//    _skilltextflield_iphone.text=@"";
//    _crafttxtflield_iphone.text=@"";
//    
//    _otherdesc.text=@"";
}
#pragma mark-sqlite DB
-(void)savejobsitdetailstoDB{
    
    if(_basicPlussegment.selectedSegmentIndex==0)
    {
        basicPlus=1;
    }
    else if(_basicPlussegment.selectedSegmentIndex==1)
    {
        basicPlus=0;
    }
    if(_ncerSegment.selectedSegmentIndex==0)
    {
        ncer=1;
    }
    else if(_ncerSegment.selectedSegmentIndex==1)
    {
        ncer=0;
    }

    NSString *month=[_monthDictionary objectForKey:_monthBtn.titleLabel.text];
    NSString *year=_yearBtn.titleLabel.text;
    NSString *day=@"01";
    NSString *dateString=[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    NSString *jobsiteid=@"0";
    sqlite3_stmt *statement;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_newEmplyhrListDB)==SQLITE_OK)
    {
        
        NSString *updateSql=[NSString stringWithFormat:@"UPDATE UserList SET JobSiteID=\"%@\",NCER= \"%d\",NCERDes=\"%@\",BasicPlus=\"%d\",DateString=\"%@\" WHERE ID= %@",jobsiteid,ncer,_otherdesc.text,basicPlus,dateString,_sqlitessn];
                             
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
@end
