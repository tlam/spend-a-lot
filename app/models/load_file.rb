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
        next if amount_value >= 0

        date_obj = Date.strptime(date, '%m/%d/%y')
        stripped_description = description[1...-1].strip

        data = {
          :date => date_obj,
          :description => self.capitalise_description(stripped_description),
          :amount => amount[1, amount.strip.length - 1],
          :payment => payment,
        }


        next if Expense.exists?(data)

        Expense.create(data)
      end
    end

    return true
  end

  def self.wesabe(filename)
    file_path = File.join(@@data_directory, filename)

    if not File.exists?(file_path)
      return false
    end

    open(file_path) do |fd|
      fd.each do |line|
        account_id, account_name, financial_institution, account_type, currency, date, check_number, amount, merchant, raw_name, memo, note, rating, tags = line.split(',')

        amount_value = BigDecimal.new(amount)
        next if amount_value >= 0
        if account_name == 'Cash Account'
          payment = 'CA'
        else
          payment = 'CC'
        end

        data = {
          :date => date,
          :description => merchant,
          :amount => amount[1, amount.length - 1],
          :payment => payment,
        }

        next if Expense.exists?(data)

        Expense.create(data)
      end
    end
  end

  def self.delete(filename)
    file_path = File.join(@@data_directory, filename)

    if not File.exists?(file_path)
      return false
    end

    File.delete(file_path)
    return true
  end

  def self.capitalise_description(description)
    words = description.split(' ')
    output = []
    exceptions = %w(ON PC)
    words.each do |word|
      if exceptions.include? word
        output.push(word)
      else
        output.push(word.capitalize)
      end
    end
    return output.join(' ')
  end
end
