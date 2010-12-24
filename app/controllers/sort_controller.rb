class SortController < ApplicationController
  def index
    @cables = Cable.all
    @records = @cables.count

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cables }
    end
  end
end
