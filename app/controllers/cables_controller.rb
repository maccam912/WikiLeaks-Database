class CablesController < ApplicationController
  # GET /cables
  # GET /cables.xml
  
  def index
    if params[:search] && params[:origin] && params[:classification1] && params[:classification2]
      @cables = Cable.find(:all, :order => "dateofrelease DESC", :conditions => ['(classification LIKE ? OR classification LIKE ?) AND subject LIKE ? AND country LIKE ?', "%#{params[:classification1]}%", "%#{params[:classification2]}%", "%#{params[:search]}%", "%#{params[:origin]}%"])
    else
      @cables = Cable.find(:all, :order => "dateofrelease DESC")
    end
    
    @records = @cables.count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cables }
    end
  end

  # GET /cables/1
  # GET /cables/1.xml
  def show
    @cable = Cable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cable }
    end
  end
=begin
  # GET /cables/new
  # GET /cables/new.xml
  def new
    @cable = Cable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cable }
    end
  end

  # GET /cables/1/edit
  def edit
    @cable = Cable.find(params[:id])
  end

  # POST /cables
  # POST /cables.xml
  def create
    @cable = Cable.new(params[:cable])

    respond_to do |format|
      if @cable.save
        format.html { redirect_to(@cable, :notice => 'Cable was successfully created.') }
        format.xml  { render :xml => @cable, :status => :created, :location => @cable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cables/1
  # PUT /cables/1.xml
  def update
    @cable = Cable.find(params[:id])

    respond_to do |format|
      if @cable.update_attributes(params[:cable])
        format.html { redirect_to(@cable, :notice => 'Cable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cables/1
  # DELETE /cables/1.xml
  def destroy
    @cable = Cable.find(params[:id])
    @cable.destroy

    respond_to do |format|
      format.html { redirect_to(cables_url) }
      format.xml  { head :ok }
    end
  end
=end  
end
