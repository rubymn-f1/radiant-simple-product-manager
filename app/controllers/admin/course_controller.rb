class Admin::CourseController < Admin::ResourceController
	model_class Course
	
	def new
    if request.post?
      @course = Course.new(params[:course])
      if @course.save()        
        flash[:notice] = "Success in creating the course"
        redirect_to :controller => 'admin/product', :action => 'index'
      else
        flash[:notice] = "Error creating the course"
      end
    end
  end
  
  def remove
    if request.post?
      @course = Course.find(params[:id])
      @course.destroy()
      flash[:notice] = "Course removed."
      redirect_to :controller => 'admin/product', :action => 'index'
    end
  end
  
  def edit
    if request.post?
      @course = Course.find(params[:id])
      if @course.update_attributes(params[:course])
        flash[:notice] = "Course updated"
        redirect_to :controller => 'admin/product', :action => 'index'
      else
        flash[:notice] = "Error updating course"
      end
    end
  end
  
end