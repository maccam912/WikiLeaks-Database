require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'date'
require 'time'
    
    @today = Time.new
    @day = @today
    @mirror = "http://wikileaks.ch"
    
    @count = 0
    
    @n = 1

    while @day.year > 2010 || @day.month > 11 || @day.day > 28 do
      
      @day = @today - @n.days
      
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

      doc = Hpricot(open(url))
      
      while (doc/"//html/body/div/div[2]/div/a[4]").inner_html.to_i > @page+1
        puts (doc/"//html/body/div/div[2]/div/a[4]").inner_html.to_i
        @reldate = "/reldate/" + @year + "-" + @month + "-" + @dom + "_" + @page.to_s + ".html"
        url = @mirror + @reldate

        doc = Hpricot(open(url))
    
        (doc/"//html/body/div/div[2]/table/tr").each do |entry|
          @refid = (entry/'td[1]/a').inner_html
          @link = @mirror + (entry/'td[1]/a').to_s.split("\"")[1].to_s
          @subject = (entry/'td[2]').inner_html
          @created = (entry/'td[3]/a').inner_html
          @released = (entry/'td[4]/a').inner_html
          @classification = (entry/'td[5]/a').inner_html
          @origin = (entry/'td[6]/a').inner_html
  
          if @subject.chomp.length > 2
            if Cable.find(:all, :conditions => {:subject => @subject}).length > 0
              #nothing
            else
              Cable.create(:classification => @classification, :subject => @subject, :link => @link, :country => @origin, :dateofcreation => @created, :dateofrelease => @released)
              @count = @count + 1
            end
          end
        end
      @page = @page + 1
      end
      @page = 0
      @n = @n + 1
    end