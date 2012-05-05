class ContestRegistrationController < ApplicationController

  def home
    @page_context = :full_page
  end

  def new
    if params[:testdata]
      case params[:testdata]
        when 'half'
          @user = FactoryGirl.build(:user, params[:user])
          @user.agencies.build
        else
          @user          = FactoryGirl.build(:user, params[:user])
          @user.agencies = [FactoryGirl.build(:agency)]
      end
    else
      @user = User.new(params[:user])
      @user.agencies.build
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user

      redirect_to detect_next_url(@user)
    else
      render :action => :new
    end
  end
end

