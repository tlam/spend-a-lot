require 'csv'

class StatementsController < ApplicationController
  def index
    @files = []

    Dir[File.join(LoadFile.data_directory, '*.csv')].each do |file|
      @files.push(Pathname.new(file).basename)
    end

    @files = @files.sort{|x,y| y <=> x}

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def csv
    @expenses = Expense.includes(:category).order('date DESC')
    CSV.open('data.csv', 'w') do |csv|
      csv << ['Description', 'Category', 'Amount', 'Date', 'Payment']
      @expenses.each do |expense|
        if expense.amount == 0
          next
        end
        if expense.category.nil?
          category = ''
        else
          category = expense.category.name
        end
        csv << [expense.description, category, expense.amount, expense.date, expense.payment]
      end
    end
    return redirect_to :action => 'index'
  end

  def upload
    if params[:upload].nil?
      flash[:notice] = 'Please select a file to upload'
      return redirect_to :action => 'index'
    end

    post = DataFile.save(params[:upload])
    if post
      flash[:notice] = 'File has been uploaded successfully'
    else
      flash[:notice] = 'File upload failed'
    end
    redirect_to :action => 'index'
  end

  def load
    if params[:filename].nil?
      flash[:notice] = 'Filename does not exist'
      return redirect_to :action => 'index'
    else
      loaded = LoadFile.load(params[:filename])
      if loaded
        flash[:notice] = 'Data loaded'
      else
        flash[:notice] = 'Data load failed'
      end
      return redirect_to :action => 'index'
    end
  end

  def wesabe
    if params[:filename].nil?
      flash[:notice] = 'Wesabe file does not exist'
      return redirect_to :action => 'index'
    else
      loaded = LoadFile.wesabe(params[:filename])
      if loaded
        flash[:notice] = 'Wesabe data loaded'
      else
        flash[:notice] = 'Wesabe load failed'
      end
      return redirect_to :action => 'index'
    end
  end

  def delete
    if params[:filename].nil?
      flash[:notice] = 'Filename does not exist'
      return redirect_to :action => 'index'
    else
      loaded = LoadFile.delete(params[:filename])
      if loaded
        flash[:notice] = 'File deleted'
      else
        flash[:notice] = 'File deletion failed'
      end
      return redirect_to :action => 'index'
    end
  end
end
