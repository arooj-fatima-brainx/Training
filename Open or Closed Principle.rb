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

