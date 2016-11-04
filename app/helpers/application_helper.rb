module ApplicationHelper
  def profile_img(user)


    if user.avatar?
      return image_tag(user.avatar, alt: user.name) 
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name)
  end
end
