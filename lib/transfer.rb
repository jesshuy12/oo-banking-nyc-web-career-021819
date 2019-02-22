class Transfer

  attr_reader :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? && @sender.balance > @amount
  end

  def execute_transaction
    if self.valid? && @status == "pending"
      @receiver.deposit(@amount)
      @sender.deposit(@amount * -1)
      @status = "complete"
      #binding.pry
    else
      @status = "rejected"
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      @receiver.deposit(@amount * -1)
      @sender.deposit(@amount)
      @status = "reversed"
    end
  end

end
