class ExpensesController < ApplicationController
  # GET /expenses
  # GET /expenses.xml
  def index
    @expenses = Expense.includes(:category).order('date DESC')
    @expenses_months = @expenses.group_by { |t| t.date.beginning_of_month }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.xml
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.xml
  def new
    @expense = Expense.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
  end

  # POST /expenses
  # POST /expenses.xml
  def create
    @expense = Expense.new(params[:expense])

    respond_to do |format|
      if @expense.save
        if params['add-another']
          flash[:notice] = 'Expense created'
          return redirect_to :action => 'new'
        end
        format.html { redirect_to(@expense, :notice => 'Expense was successfully created.') }
        format.xml  { render :xml => @expense, :status => :created, :location => @expense }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.xml
  def update
    @expense = Expense.find(params[:id])

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        format.html { redirect_to(@expense, :notice => 'Expense was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expense.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.xml
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to(expenses_url) }
      format.xml  { head :ok }
    end
  end

  def descriptions
    if params[:term]
      @expenses = Expense.where('description ilike ?', '%' + params[:term] + '%')
    else
      @expenses = Expense.all
    end

    @expenses = @expenses.select("DISTINCT(description)").order("description")
    render :json => @expenses.map(&:description)
  end

  def monthly
    @month = Date.new(params[:year].to_i, params[:month].to_i)
    render :action => 'monthly'
  end
end
