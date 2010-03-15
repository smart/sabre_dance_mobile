require 'base_controller'
class MediaController < BaseController


  def index
    toolbar("Media", :back => "Back")
    render
  end

  def music
    toolbar("Studio Tracks", :back => "Back")
    render
  end

  def videos
    toolbar("Video", :back => "Back")
    render
  end
end