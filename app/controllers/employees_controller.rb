class EmployeesController < ApplicationController
  def index
    @employees = employees.all
    end 
  end

  def new
    
  end

  def create
    employee = Employee.create(
                        first_name: params[:first_name],
                        last_name: params[:last_name],
                        email: params[:email]
                          )

    redirect_to "/employees/#{employee.id}"
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])
    employee.update(
                    first_name: params[:first_name],
                    last_name: params[:last_name],
                    email: params[:email]
                    )

    redirect_to "/employees/#{employee.id}"
  end

  def destroy
     employee = Employee.find(params[:id])
     employee.destory
    redirect_to "/employees"
  end
end
