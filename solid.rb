#         1-Single Responsibility Principle - SRP:
#It states that a class should have one, and only one reason to change
#Here's a sample code where all the functionality is in a single class:

class AuthenticatesUser
  def authenticate(email, password)
    if matches?(email, password)
     do_some_authentication
    else
      raise NotAllowedError
    end
  end

  private
  def matches?(email, password)
    user = find_from_db(:user, email)
    user.encrypted_password == encrypt(password)
  end
end

#here auntheticator class has two responibilities i.e, matching password and authenticating. it is against SRP. Following is the solution of this.

class AuthenticatesUser
  def authenticate(email, password)
    if MatchesPasswords.new(email, password).matches?
     do_some_authentication
    else
      raise NotAllowedError
    end
  end
end

class MatchesPasswords
  def initialize(email, password)
     @email = email
     @password = password
  end

  def matches?
     user = find_from_db(:user, @email)
    user.encrypted_password == encrypt(@password)
  end
end








#        2-Open/closed principle
#This principle states, "software entities (classes, modules, functions, etc.) should be open for extension but closed for modification".
# let's see an example

class PayslipGenerator
  def initialize(employee, month)
    @employee = employee
    @month = month
  end

  def generate_payslip
    #-----
    if employee.contractor?
        # generate payslip for contractor
    else
        # generate a normal payslip
    end
  end
end

#In this example if we need more generation logic, we need to modify the existing class which is the voilation of open/closed princple
# here is the solution of this problem

class ContractorPayslipGenerator
  def initialize(employee, month)
    @employee = employee
    @month = month
  end

  def generate
    #-------
  end
end

class FullTimePayslipGenerator
  def initialize(employee, month)
    @employee = employee
    @month = month
  end

  def generate
    # -------
  end
end

#Now, change the PayslipGenerator class to use these classes:

GENERATORS = {
  'full_time' => FullTimePayslipGenerator,
  'contractor' => ContractorPayslipGenerator
}

class PayslipGenerator
  def initialize(employee, month)
    @employee = employee
    @month = month
  end

  def generate_payslip
    # -------
    GENERATORS[employee.type].new(employee, month).generate()
  end
end







		#Liskov Substitution Principle - LSP
#This principle states that "Subtypes must be substitutable for their base types"
# let's look an example
class Animal
  def walk
     do_some_walkin
  end
end

class Cat < Animal
  def run
    run_like_a_cat
  end
end

#So, they must have the same interface. We can do it like so:

class Animal
  def walk
     do_some_walkin
  end

  def run
    raise NotImplementedError
  end
end

class Cat < Animal
  def run
    run_like_a_cat
  end
end






			#Interface Segregation Principle - ISP
#This principle states that "Clients should not be forced to depend upon interfaces that they don't use."

class Car
  def open
  end

  def start_engine
  end

   def change_engine
   end
end

class Driver
  def drive
    @car.open
    @car.start_engine
  end
end

class Mechanic
  def do_stuff
    @car.change_engine
  end
end

#As you can see, our Car class has an interface that's used partially by both the Driver and the Mechanic. We can improve our interface like so:

class Car
  def open
  end

  def start_engine
  end
end

class CarInternals
   def change_engine
   end
end

class Driver
  def drive
    @car.open
    @car.start_engine
  end
end

class Mechanic
  def do_stuff
    @car_internals.change_engine
  end
end






			#Dependency Inversion Principle - DIP
#"THIS principle states that "Abstractions should not depend upon details. Details should depend upon abstractions".
# LEt's look an example 
class Report
  def body
     generate_reporty_stuff
  end

  def print
     JSONFormatter.new.format(body)
  end
end

class JSONFormatter
  def format(body)
     ...
  end
end

#Now there is a formatter class, but I've hardcoded it on the Report class, thus creating a dependency from the Report to the JSONFormatter. Since the Report is a more abstract (high-level) concept than the JSONFormatter, we're effectively breaking the DIP.
#We can solve it the exact same way we solved it on the OCP problem, with dependency injection:

class Report
  def body
     generate_reporty_stuff
  end

  def print(formatter: JSONFormatter.new)
     formatter.format body
  end
end


