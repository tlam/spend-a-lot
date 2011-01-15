class StatementsController < ApplicationController
  def index
    directory = 'public/data'
    @files = []

    Dir[File.join(directory, '*.txt')].each do |file|
      @files.push(file)
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def upload
    if params[:upload].nil?
      flash[:notice] = 'Please select a file to upload'
      return redirect_to(:action => 'index')
    end

    post = DataFile.save(params[:upload])
    if post
      flash[:notice] = 'File has been uploaded successfully'
      redirect_to(:action => 'index')
    else
      render(:action => :get)
    end
  end
end
