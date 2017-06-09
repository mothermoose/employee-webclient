class Employee
  attr_accessor :id, :first_name, :last_name, :email, :birthday
  def initialize(hash_options)
    @id = hash_options["id"]
    @first_name = hash_options["first_name"]
    @last_name = hash_options["last_name"]
    @email = hash_options["email"]
    @birthday = Date.parse(hash_options["birthday"]) if hash_options['birthday']
  end 

  def full_name
    "#{first_name} #{last_name}"
  end 

  def friendly_birthday
    #birthday ? birthday.strftime('%b %d, %Y') : "NA" <-- ternary
    if birthday
      birthday.strftime('%b %d, %Y')
    else 
      "N/A"
  end 

  def self.find(id)
    @employee = Employee.new(Unirest.get("#{ENV["API_HOST"]}/api/v1/employees/#{ id }.json"),
      headers: {
        "Accept" => "application/json"
        "X-User_Email" => "ENV["API_EMAIL"]",
        "Authorization" => "Token token =#{ ENV["API_TOKEN"]"},
      }
      .body)
  end 

  def self.all
    employee_hashes = Unirest.get("#{ENV["API_HOST"]}/api/v1/employees.json")
            headers: {
                    "Accept" => "application/json"
                    "X-User_Email" => "ENV["API_EMAIL"]",
                    "Authorization" => "Token token =#{ ENV["API_TOKEN"]"},

    .body

    employee_hashes.each do |employee_hash|
      @employees << Employee.new(employee_hash)
  end  

  def self.create(employee_params)
      response = Unirest.post(
                "#{ENV["API_HOST"]}/api/v1/employees/#{params["id"]}.json",
                headers: {
                  "Accept" => "application/json"
                  "X-User_Email" => "ENV["API_EMAIL"],
                  "Authorization" => "Token token=#{ ENV["API_TOKEN"] }"
                  },
                parameters: employee_params

                ).body 
      Employee.new(response)
  end  

  def update (employee_hash)
    employee = Unirest.patch(
                            "#{ENV["API_HOST"]}/api/v1/employees/#{ id }.json",
                            headers: {
                              "Accept" => "application/json",
                              "X-User_Email" => "ENV["API_EMAIL"]",
                              "Authorization" => "Token token =#{ ENV["API_TOKEN"]"
                              },
                            params: employee_params
                            ).body
    Employee.new(response)
  end  

  def destroy (employee_hash)
    Unirest.delete(
                   "#{ENV["API_HOST"]}/api/v1/employees/#{ id }.json",
                   headers: {"Accept" => "application/json"}
                   ).body
    redirect_to "/employees"
  end 
end 