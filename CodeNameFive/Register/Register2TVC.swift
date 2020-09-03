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
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    let datePicker = UIDatePicker()
    var currentSelectedField : String?
    let button = UIButton(type: .system)
    var countryId  : Int?
    var stateId : Int?
    
    //MARK:- OUTLETS
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressLine2: UITextField?
    @IBOutlet weak var town: UITextField!
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
        pickerData = ["Bike", "Scooter", "Car", "Rikshaw", "Truk", "Trolly"]
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
        currentSelectedField = address.state.rawValue
        ShowStatePicker()
    }
    
    @IBAction func citySelectionforPicker(_ sender: UITextField) {
        currentSelectedField = address.city.rawValue
        ShowCityPicker()
    }
    
    //MARK:- Load Data from Network
    func loadCountries() {
        httplocationobj.getCountries { (result, error) in
            if error == nil{
                if let result = result{
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
            {
                for state in result.data{
                    print(state.stateName)
                    self.states.append(state.stateName)
                    self.stateID.append(state.stateID)
                }}
        }
    }
    
    func loadCities(stateId : Int){
        httplocationobj.getCities(stateId: stateId) { (result, error) in
            
            if let result = result{
                for city in result.data{
                    print(city.cityName)
                    self.cities.append(city.cityName)
                    self.cityID.append(city.cityID)
                }
            }
        }
    }
    
    @objc func submit(){
        if country.text!.isEmpty && dateOfBirth.text!.isEmpty && addressLine1.text!.isEmpty && town.text!.isEmpty && city.text!.isEmpty && zipCode.text!.isEmpty{
            snackBar(errorMessage: "one Or More Fields Are Empty")
        }
        else{
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
            return countries[row]
        }
        else if currentSelectedField == address.state.rawValue {
            
            return states[row]
        }
        else{
            return cities[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentSelectedField == address.country.rawValue{
            countryId =  countriesID[row]
            country.text = countries[row]
            if let countryId = countryId{
            loadStates(countryId: countryId)
            }
        }
        else if currentSelectedField == address.state.rawValue {
            stateId = stateID[row]
            stateTextField.text = states[row]
            if let stateId =  stateId{
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
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateOfBirth.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
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
