class FindPlaceAPIError < StandardError
  def initialize(message="")
    super(message)
  end
end
