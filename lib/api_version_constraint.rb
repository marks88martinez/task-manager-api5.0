class ApiVersionConstraint
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end
  def matchers?(req) # si termina en ? return true o false
    @default || req.headers['Accept'].include?("application/vnd.taskmanager.v#{@version}")
  end

end
