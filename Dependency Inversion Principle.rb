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
