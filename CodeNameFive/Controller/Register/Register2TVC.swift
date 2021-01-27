import UIKit

class Register2TVC: UITableViewController,UITextFieldDelegate {
    
    //MARK:- Variables
    var vSpinner : UIView?
    let httplocationobj = HTTPLocation()
    var countries: [String] = []
    var countriesID: [Int] = []
    var states: [String] = []
    var stateID: [Int] = []
    var cities: [String] = []
    var cityID: [Int] = []
    let picker = UIPickerView()
    var overlayView = UIView()
    let datePicker = UIDatePicker()
    var currentSelectedField : String?
    let button = UIButton(type: .custom)
    var countryId  : Int?
    var stateId : Int?
    var cityId  :Int?
    var dic : [String : Any] = [:]
    var ai = UIActivityIndicatorView()
    //MARK:- OUTLETS
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressLine2: UITextField?
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    
    
    enum address : String {
        case country = "country"
        case state = "state"
        case city = "city"
    }
    
    //MARK:- LifeCyles
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        print(Registration.phoneNumber as Any)
        self.picker.delegate = self
        self.picker.dataSource = self
        loadCountries()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backReturn))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    @objc func backReturn(){
         navigationController?.popViewController(animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ScreenBottombutton.goToNextScreen(button: button , view: self.view)
        button.addTarget(self, action: #selector(submit), for: .touchUpInside)
    }
    
    // MARK:- Textefield Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- TextFields Actions
    
    @IBAction func countrySelection(_ sender: Any) {
        currentSelectedField = address.country.rawValue
        ShowCountryPicker()
    }
    
    @IBAction func dateOfBirthSelection(_ sender: Any) {
        showDatePicker()
    }
    
    @IBAction func stateSelectionforPicker(_ sender: UITextField) {
        if country.text!.isEmpty{
             self.view.endEditing(true)
            self.MyshowAlertWith(title: "Error", message: "You must select the country first")
        }
        else{
            currentSelectedField = address.state.rawValue
            ShowStatePicker()
        }
    }
    
    @IBAction func citySelectionforPicker(_ sender: UITextField) {
        if stateTextField.text!.isEmpty{
            self.view.endEditing(true)
            MyshowAlertWith(title: "Error", message: "You must select the state first")
        }
        else{
            currentSelectedField = address.city.rawValue
            ShowCityPicker()
        }
    }
    
    //MARK:- Load Data from Network
    func loadCountries() {
        httplocationobj.getCountries { (result, error) in
            if error == nil{
                if let result = result{
                    self.countries.removeAll()
                    self.countriesID.removeAll()
                    for country in result.data{
                        self.countries.append(country.countryName)
                        self.countriesID.append(country.countryID)
                    }
                }
            }
        }
    }
    func loadStates(countryId : Int){
        httplocationobj.getState(countryId: countryId) { (result, error) in
            if let result = result
            {   self.states.removeAll()
                self.stateID.removeAll()
                for state in result.data{
                    print(state.stateName)
                    self.states.append(state.stateName)
                    self.stateID.append(state.stateID)
                }
                self.removeSpinner()
            }
        }
    }
    
    func loadCities(stateId : Int){
        httplocationobj.getCities(stateId: stateId) { (result, error) in
            if let result = result{
                self.cities.removeAll()
                self.cityID.removeAll()
                for city in result.data{
                    print(city.cityName)
                    self.cities.append(city.cityName)
                    self.cityID.append(city.cityID)
                }
                self.removeSpinner()
            }
        }
    }
    
    @objc func submit(){
        if isEmptyOrNot() {
            Registration.country = countryId
            Registration.city = cityId
            Registration.state = stateId
            Registration.dob = dateOfBirth.text
            Registration.address1 = addressLine1.text
            Registration.address2 = addressLine2?.text
            Registration.zipCode = zipCode.text
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register3TVC") as! Register3TVC
            navigationController?.pushViewController(newViewController, animated: false)
        }
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "Enter your date of birth and address to verify your identity"
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}
extension Register2TVC: UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentSelectedField == address.country.rawValue{
            return countries.count
        }
        else if currentSelectedField == address.state.rawValue {
            return states.count
        }
        else{
            return cities.count
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentSelectedField == address.country.rawValue{
            countryId =  countriesID[row]
            return countries[row]
        }
        else if currentSelectedField == address.state.rawValue {
            
            stateId = stateID[row]
            return states[row]
        }
        else{
            cityId = cityID[row]
            return cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentSelectedField == address.country.rawValue{
            countryId =  countriesID[row]
            country.text = countries[row]
            if let countryId = countryId{
                showSpinner(onView: self.view)
                loadStates(countryId: countryId)
            }
        }
        else if currentSelectedField == address.state.rawValue {
            stateId = stateID[row]
            stateTextField.text = states[row]
            if let stateId =  stateId{
                showSpinner(onView: self.view)
                loadCities(stateId: stateId)
                
            }
        }
        else{
            city.text = cities[row]
        }
    }
    func setBackButton(){
        navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
        
        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonPressed(btn:)), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backButtonPressed(btn : UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension Register2TVC{
    
    func ShowCountryPicker(){
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Done));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        country.inputAccessoryView = toolbar
        country.inputView = picker
    }
    
    func ShowStatePicker(){
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Done));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        stateTextField.inputAccessoryView = toolbar
        stateTextField.inputView = picker
    }
    
    func ShowCityPicker(){
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Done));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        city.inputAccessoryView = toolbar
        city.inputView = picker
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
        datePicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250.0)
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfBirth.inputAccessoryView = toolbar
        dateOfBirth.inputView = datePicker
        datePicker.addTarget(self, action: #selector(donedatePicker), for: UIControl.Event.valueChanged)
        
    }
    @objc func donedatePicker(){
        if checkDateofBirth(){
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            dateOfBirth.text = formatter.string(from: datePicker.date)
            self.view.endEditing(true)
        }
        else{
            self.view.endEditing(true)
            MyshowAlertWith(title: "Error", message: "You must be 18 or older to register as a partner")
        }
    }
    @objc func Done(){
        self.view.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    @objc func CancelCountryPicker(){
        country.text = nil
    }
    func checkDateofBirth() -> Bool {
        let dateOfBirth = datePicker.date
        let today = Date()
        let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let age = gregorian.components([.year], from: dateOfBirth, to: today, options: [])
        
        if age.year! < 18 {
            print("user is under 18")
            return false
        }
        else{
            return true
        }
    }
    func isEmptyOrNot() -> Bool {
        if dateOfBirth.text!.isEmpty{

            MyshowAlertWith(title: "Error", message: "Select your date of birth")
            return false
        }
            
        else if addressLine1.text!.isEmpty{
            MyshowAlertWith(title: "Error", message:  "Enter your address line 1")
           
            return false
        }
        else if country.text!.isEmpty{
            MyshowAlertWith(title: "Error", message: "Select your country")
            
            return false
        }
            
        else if stateTextField.text!.isEmpty{
            MyshowAlertWith(title: "Error", message: "Select your state")
           
            return false
        }
            
        else if city.text!.isEmpty{
            MyshowAlertWith(title: "Error", message: "Select your city")
           
            return false
            
        }
        else if zipCode.text!.isEmpty{
            MyshowAlertWith(title: "Error", message: "Enter your zip code")
           
            return false
        }
            
        else {
            return true
        }
    }
      
}

extension Register2TVC {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        if #available(iOS 13.0, *) {
            ai = UIActivityIndicatorView.init(style: .large)
        } else if #available(iOS 12.0, *) {
            ai = UIActivityIndicatorView.init(style: .whiteLarge)
        }
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async { [self] in
            spinnerView.addSubview(self.ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
