class StaticPageController < ApplicationController

  def serve
    page_name = params[:page_name]

    if File.exist?(Rails.root.join('app', 'views', 'static_page', "#{page_name}.html.haml"))
      render page_name
    else
      render :text => 'No such file found'
    end
  end
end
