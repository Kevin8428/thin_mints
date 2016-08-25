module MeteredAccessHelper

  def end_of_meter
    if cookies[:meter] && JSON.load(cookies[:meter]).length > 3
      trigger_paywall
    end
  end

  def build_meter_cookie
    validate_session
    check_for_content
  end

  def validate_session
    if !cookies[:meter]
      cookies[:meter] = JSON.dump([0])
    end
  end

  def check_for_content
    meter_array = JSON.load(cookies[:meter])

    if meter_array.length > 3
      trigger_paywall
    else
      add_content
    end
  end

  def add_content
    article = Article.find(params[:id])
    cookie_array = JSON.load(cookies[:meter])

    if !cookie_array.include?(article.id)
      cookie_array << article.id
      cookies[:meter] = JSON.dump(cookie_array)
    end
  end

  def trigger_paywall
    binding.pry
  end

end
