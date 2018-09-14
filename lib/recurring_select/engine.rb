module RecurringSelect
  class Engine < Rails::Engine
    
    initializer "recurring_select.extending_form_builder" do |app|
    # config.to_prepare do
      ActionView::Helpers::FormHelper.send(:include, RecurringSelectHelper::FormHelper)
      ActionView::Helpers::FormOptionsHelper.send(:include, RecurringSelectHelper::FormOptionsHelper)
      ActionView::Helpers::FormBuilder.send(:include, RecurringSelectHelper::FormBuilder)
    end
    
    initializer "recurring_select.connecting_middleware" do |app|
      puts Rails::VERSION::STRING
      puts "app_class: #{app.class}"
      if Rails::VERSION::STRING >= '5.2'
        app.config.app_middleware.use RecurringSelectMiddleware
      else
        app.middleware.use RecurringSelectMiddleware # insert_after ActionDispatch::ParamsParser,
      end
      puts app.config.middleware.middlewares
    end
  end
end
