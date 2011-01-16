class LoadFile < ActiveRecord::Base
  @@data_directory = 'public/data'

  def self.data_directory
    @@data_directory
  end

  def self.load(filename, payment='CC')
    file_path = File.join(@@data_directory, filename)

    if not File.exists?(file_path)
      return false
    end

    open(file_path) do |fd|
      fd.each do |line|
        date, description, amount = line.split(',')
        amount_value = BigDecimal.new(amount)
        if amount_value >= 0 then
          next
        end

        date_obj = Date.strptime(date, '%m/%d/%y')

        data = {
          :date => date_obj,
          :description => description[1...-1].strip,
          :amount => amount[1, amount.strip.length - 1],
          :payment => payment,
        }

        if Expense.exists?(data)
          next
        end

        Expense.create(data)
      end
    end

    return true
  end

  def self.delete(filename)
    file_path = File.join(@@data_directory, filename)

    if not File.exists?(file_path)
      return false
    end

    File.delete(file_path)
    return true
  end
end
