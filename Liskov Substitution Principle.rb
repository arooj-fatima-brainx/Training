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
