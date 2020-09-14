import UIKit
import MaterialComponents.MaterialSnackbar
class Register2TVC: UITableViewController,UITextFieldDelegate {
    
    //MARK:- Variables
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
    let button = UIButton(type: .system)
    var countryId  : Int?
    var stateId : Int?
    var cityId  :Int?
     var vSpinner : UIView?
    
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
        self.picker.delegate = self
        self.picker.dataSource = self
        loadCountries()
        
        
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
        MDCSnackbarManager.delegate = self
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
            snackBar(errorMessage: "select Country First")
        }
        else{
            currentSelectedField = address.state.rawValue
            ShowStatePicker()
            
        }
    }
    
    @IBAction func citySelectionforPicker(_ sender: UITextField) {
        if stateTextField.text!.isEmpty{
            self.view.endEditing(true)
            snackBar(errorMessage: "select State First")
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
        if section == 0{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "things We Need To Check"
        }
        if section == 1{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "enter Your Date Of Birth And Address To Verify Your Identity"
        }
        
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
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        dateOfBirth.inputAccessoryView = toolbar
        dateOfBirth.inputView = datePicker
        
    }
    func snackBar(errorMessage : String) {
        let message = MDCSnackbarMessage()
        message.text = errorMessage
        MDCSnackbarManager.messageTextColor = .white
        MDCSnackbarManager.snackbarMessageViewBackgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        MDCSnackbarManager.show(message)
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
            snackBar(errorMessage: "you Are Under 18")
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
            snackBar(errorMessage: "select Your Date of Birth")
            return false
        }
            
        else if addressLine1.text!.isEmpty{
            snackBar(errorMessage: "fill Address Line 1")
            return false
        }
        else if country.text!.isEmpty{
            snackBar(errorMessage: "select Your Country")
            return false
        }
            
        else if stateTextField.text!.isEmpty{
            snackBar(errorMessage: "select Your State")
            return false
        }
            
        else if city.text!.isEmpty{
            
            snackBar(errorMessage: "select Your City")
            return false
            
        }
        else if zipCode.text!.isEmpty{
            snackBar(errorMessage: "fill Zip Code")
            return false
        }
            
        else {
            return true
        }
    }
}
extension Register2TVC : MDCSnackbarManagerDelegate{
    func willPresentSnackbar(with messageView: MDCSnackbarMessageView?) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    func snackbarDidDisappear() {
        ScreenBottombutton.goToNextScreen(button: button , view: self.view)
    }
    
}

extension Register2TVC {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
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
