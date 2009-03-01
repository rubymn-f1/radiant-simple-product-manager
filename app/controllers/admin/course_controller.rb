class Admin::CourseController < Admin::ResourceController
	model_class Course
	
	def new
    if request.post?
      p = Course.new(params[:course])
      if p.save()        
        flash[:notice] = "Success in creating the course"
        redirect_to :controller => 'admin/product', :action => 'index'
      else
        flash[:notice] = "Error creating the course"
      end
    end
  end
  
  def remove
    if request.post?
      p = Course.find(params[:id])
      p.destroy()
      flash[:notice] = "Course removed."
      redirect_to :controller => 'admin/product', :action => 'index'
    end
  end
  
  def edit
    if request.post?
      p = Course.find(params[:id])
      if p.update_attributes(params[:course])
        flash[:notice] = "Course updated"
      else
        flash[:notice] = "Error updating course"
      end
      redirect_to :controller => 'admin/product', :action => 'index'
    end
  end
  
end