class StaticController < ApplicationController
  def index
  end

  def about
  end

  def pricing
    plans = Plan.visible.sorted
    redirect_to root_path, alert: t(".no_plans_html", link: helpers.link_to_if(current_user&.admin?, "Add a visible plan in the admin", madmin_plans_path)) unless plans.any?
    @monthly_plans, @yearly_plans = plans.partition(&:monthly?)
  end

  def terms
    @agreement = Rails.application.config.agreements.find { _1.id == :terms_of_service }
  end

  def privacy
    @agreement = Rails.application.config.agreements.find { _1.id == :privacy_policy }
  end
end
