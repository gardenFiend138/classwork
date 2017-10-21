=begin
At first, I was thinking that the names may be passed in
with an "=", but it seems like that's not the case, so I
don't actually have to check for that. Cool.
=end
class AttrAccessorObject
  def self.my_attr_accessor(*names)

    #Defines the getter and setter methods for each argument.

    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}") } #Uses built in method to make getter method; interpolate the argument to give it the name.
      define_method("#{name}=") do |new_name| # Same situation as above, but here we have to put in pipes the value we will set our instance variable to be
        instance_variable_set("@#{name}", new_name) # Again, we interpolate, passing the necessary arguments to the setter method.
      end
    end

  end
end
