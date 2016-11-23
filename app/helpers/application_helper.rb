module ApplicationHelper
  def profile_img(user)
    if user.avatar?
      return image_tag(user.avatar, alt: user.name)
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name)
  end

  # this helper is for users#index page
  def user_profile_img(user)
    if user.avatar?
      return image_tag(user.avatar, alt: user.name, size: "60x60")
    else
      img_url = 'no_image.png'
    end
    image_tag(img_url, alt: user.name, size: "60x60")
  end

  def question_count(user)
    count = Question.where(user_id: user.id).count
    if count > 0
      val = count
    else
      val = "まだ質問していません"
    end
  end

  def answer_count(user)
    count = Answer.where(user_id: user.id).count
    if count > 0
      val = count
    else
      val = "まだどの質問に対しても回答していません"
    end
  end

end
