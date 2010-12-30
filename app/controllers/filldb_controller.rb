class FilldbController < ApplicationController
  def index
    require 'rubygems'
    require 'hpricot'
    require 'open-uri'
    require 'date'
    
    @today = Time.new
    
    @daysback = 1
    
    @day = @today - @daysback.days
    
    @mirror = "http://wikileaks.ch"
    
    @count = 0
    
    @year = @day.year.to_s
    @dom = @day.day.to_s
    @month = @day.month.to_s

    while @day.year > 2010 || @day.month > 11 || @day.day > 28 do
      
      @day = @today - @daysback.days
      
      @year = @day.year.to_s
      @dom = @day.day.to_s
      @month = @day.month.to_s
      @page = 0
      
      if @dom.to_i < 10
        @dom = "0" + @dom
      end
      
      if @month.to_i < 10
        @month = "0" + @month
      end
      
      @reldate = "/reldate/" + @year + "-" + @month + "-" + @dom + "_" + @page.to_s + ".html"

      url = @mirror + @reldate

      begin
        doc = Hpricot(open(url))
      rescue
        puts "Error on opening #{url}"
        @daysback = @daysback + 1
        next
      end
     
      @numofpage = (doc/"//div[@class='paginator']/a[4]").inner_html.to_i
      
      if @numofpage == 0
        @numofpage = 1
      end
      
      if @numofpage == 22
        @numofpage = 2
      end
      
      if @numofpage == 33
        @numofpage = 3
      end
      
      if @numofpage == 44
        @numofpage = 4
      end
      
      if @numofpage == 55
        @numofpage = 5
      end
      
      if @numofpage == 66
        @numofpage = 6 
      end
      
      @page = 0
      
        while @numofpage > @page
        
            @reldate = "/reldate/" + @year + "-" + @month + "-" + @dom + "_" + @page.to_s + ".html"
            
            url = @mirror + @reldate
            
            puts url

            begin
              doc = Hpricot(open(url))
            rescue
              puts "ERRORD on " + url
            end
            
            (doc/"//html/body/div/div[2]/table/tr").each do |entry|
              @refid = (entry/'td[1]/a').inner_html
              @link = @mirror + (entry/'td[1]/a').to_s.split("\"")[1].to_s
              @subject = (entry/'td[2]').inner_html
              @created = (entry/'td[3]/a').inner_html
              @released = (entry/'td[4]/a').inner_html
              @classification = (entry/'td[5]/a').inner_html
              @origin = (entry/'td[6]/a').inner_html
  
              if @link.chomp.length > 2
                if Cable.find(:all, :conditions => {:link => @link}).length > 0
                #nothing
              else
                Cable.create(:classification => @classification, :subject => @subject, :link => @link, :country => @origin, :dateofcreation => @created, :dateofrelease => @released)
                @count = @count + 1
              end
            end
          end
          @page = @page + 1
        end
        @daysback = @daysback + 1
    end
  end
end
