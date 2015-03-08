require 'spec_helper'

require 'rails/all'
require 'rspec/rails'
require 'action_controller/railtie'

module Test
  class TestApplication < ::Rails::Application;  end

  TestApplication.config.secret_key_base = 'test'

  class TestsController < ActionController::Base
    include ::Rails.application.routes.url_helpers

    before_filter :a_before_filter, :only => [:before_filter_collection_action,
                                              :before_and_around_filter_collection_action,
                                              :before_and_after_filter_collection_action,
                                              :before_filter_member_action,
                                              :before_and_around_filter_member_action,
                                              :before_and_after_filter_member_action]

    around_filter :an_around_filter, :only => [:before_and_around_filter_collection_action,
                                               :around_filter_collection_action,
                                               :around_and_after_filter_collection_action,
                                               :before_and_around_filter_member_action,
                                               :around_filter_member_action,
                                               :around_and_after_filter_member_action]

    after_filter :an_after_filter, :only => [:before_and_after_filter_collection_action,
                                             :around_and_after_filter_collection_action,
                                             :after_filter_collection_action,
                                             :before_and_after_filter_member_action,
                                             :around_and_after_filter_member_action,
                                             :after_filter_member_action]

    def before_filter_collection_action; end
    def around_filter_collection_action; end
    def after_filter_collection_action; end
    def before_and_around_filter_collection_action; end
    def before_and_after_filter_collection_action; end
    def around_and_after_filter_collection_action; end
    def before_filter_member_action; end
    def around_filter_member_action; end
    def after_filter_member_action; end
    def before_and_around_filter_member_action; end
    def before_and_after_filter_member_action; end
    def around_and_after_filter_member_action; end

    protected

    def a_before_filter; end
    def an_around_filter; yield; end
    def an_after_filter; end
  end
end

RSpec.describe Test::TestsController, :type => :controller do
  before do
    routes.draw {
      namespace :test do
        resources :tests, :only => [] do
          collection do
            get :before_filter_collection_action
            get :around_filter_collection_action
            get :after_filter_collection_action
            get :before_and_around_filter_collection_action
            get :before_and_after_filter_collection_action
            get :around_and_after_filter_collection_action
          end

          member do
            get :before_filter_member_action
            get :around_filter_member_action
            get :after_filter_member_action
            get :before_and_around_filter_member_action
            get :before_and_after_filter_member_action
            get :around_and_after_filter_member_action
          end
        end
      end
    }
  end

  describe ':execute_before_filter' do
    it { should execute_before_filter :a_before_filter, :on => :before_filter_collection_action, :via => :get }
    it { should execute_before_filter :a_before_filter, :on => :before_and_around_filter_collection_action, :via => :get }
    it { should execute_before_filter :a_before_filter, :on => :before_and_after_filter_collection_action, :via => :get }
    it { should execute_before_filter :a_before_filter, :on => :before_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_before_filter :a_before_filter, :on => :before_and_around_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_before_filter :a_before_filter, :on => :before_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }

    it { should_not execute_before_filter :a_before_filter, :on => :around_filter_collection_action, :via => :get }
    it { should_not execute_before_filter :a_before_filter, :on => :after_filter_collection_action, :via => :get }
    it { should_not execute_before_filter :a_before_filter, :on => :around_and_after_filter_collection_action, :via => :get }
    it { should_not execute_before_filter :a_before_filter, :on => :around_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_before_filter :a_before_filter, :on => :after_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_before_filter :a_before_filter, :on => :around_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }
  end

  describe ':execute_around_filter' do
    it { should execute_around_filter :an_around_filter, :on => :before_and_around_filter_collection_action, :via => :get }
    it { should execute_around_filter :an_around_filter, :on => :before_and_around_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_around_filter :an_around_filter, :on => :around_filter_collection_action, :via => :get }
    it { should execute_around_filter :an_around_filter, :on => :around_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_around_filter :an_around_filter, :on => :around_and_after_filter_collection_action, :via => :get }
    it { should execute_around_filter :an_around_filter, :on => :around_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }

    it { should_not execute_around_filter :an_around_filter, :on => :before_and_after_filter_collection_action, :via => :get }
    it { should_not execute_around_filter :an_around_filter, :on => :before_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_around_filter :an_around_filter, :on => :after_filter_collection_action, :via => :get }
    it { should_not execute_around_filter :an_around_filter, :on => :after_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_around_filter :an_around_filter, :on => :before_filter_collection_action, :via => :get }
    it { should_not execute_around_filter :an_around_filter, :on => :before_filter_member_action, :via => :get, :with => { :id => 1 } }
  end

  describe ':execute_after_filter' do
    it { should execute_after_filter :an_after_filter, :on => :before_and_after_filter_collection_action, :via => :get }
    it { should execute_after_filter :an_after_filter, :on => :before_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_after_filter :an_after_filter, :on => :after_filter_collection_action, :via => :get }
    it { should execute_after_filter :an_after_filter, :on => :around_and_after_filter_collection_action, :via => :get }
    it { should execute_after_filter :an_after_filter, :on => :after_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should execute_after_filter :an_after_filter, :on => :around_and_after_filter_member_action, :via => :get, :with => { :id => 1 } }

    it { should_not execute_after_filter :an_after_filter, :on => :before_filter_collection_action, :via => :get }
    it { should_not execute_after_filter :an_after_filter, :on => :before_and_around_filter_collection_action, :via => :get }
    it { should_not execute_after_filter :an_after_filter, :on => :before_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_after_filter :an_after_filter, :on => :before_and_around_filter_member_action, :via => :get, :with => { :id => 1 } }
    it { should_not execute_after_filter :an_after_filter, :on => :around_filter_collection_action, :via => :get }
    it { should_not execute_after_filter :an_after_filter, :on => :around_filter_member_action, :via => :get, :with => { :id => 1 } }
  end
end
