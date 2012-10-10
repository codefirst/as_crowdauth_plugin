# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

describe CrowdauthController do
  before { Setting.stub(:[]).and_return(true) }

  describe "index にアクセスすると login に redirect する" do
    before  { get :index }
    subject { response }
    it {
      should redirect_to(:controller => 'crowdauth', :action => 'login')
    }
  end

  VALID_API_RESPONSE = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><user name="codefirst" expand="attributes"><link rel="self" href="http://crowd.host:8095/rest/usermanagement/1/user?username=codefirst"/><first-name>code</first-name><last-name>first</last-name><display-name>code first</display-name><email>codefirst@example.com</email><password><link rel="edit" href="http://crowd.host:8095/rest/usermanagement/1/user/password?username=codefirst"/></password><active>true</active><attributes><link rel="self" href="http://crowd.host:8095/rest/usermanagement/1/user/attribute?username=codefirst"/></attributes></user>'

  it "validなユーザはログインできる" do
    RestClient.stub(:post).and_return(VALID_API_RESPONSE)
    post :login, :login => {:username => 'dummy', :password => 'dummy'}
    session[:current_user_id].should_not be_nil
  end

  it "invalidなユーザはログインできない" do
    RestClient.stub(:post).and_raise(RestClient::Exception)
    post :login, :login => {:username => 'dummy', :password => 'dummy'}
    session[:current_user_id].should be_nil
  end

  it "一度ログインしたユーザは同じユーザで再度ログインできる" do
    RestClient.stub(:post).and_return(VALID_API_RESPONSE)
    post :login, :login => {:username => 'dummy', :password => 'dummy'}
    uid = session[:current_user_id]

    post :login, :login => {:username => 'dummy', :password => 'dummy'}
    session[:current_user_id].should == uid
  end

  it "ログイン時に名前とプロフィール画像URLを上書きできる" do
    RestClient.stub(:get).and_return(VALID_API_RESPONSE)
    post :login, :login => {
      :username => 'dummy', :password => 'dummy', :name => 'updated',
      :image_url => 'http://www.example.com/updated.png'
    }
    u = User.find(session[:current_user_id])
    u.name.should == "updated"
    u.profile_image_url.should == "http://www.example.com/updated.png"
  end
end
