class FakeLogger

  def initialize(*)
    @history = []
  end

  def history
    @history
  end

  def info(msg)
    @history.push(msg)
  end

end