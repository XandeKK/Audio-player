ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def sign_in
    sign_in_as(:one)
  end

  def sign_in_as(id)
    post session_path, params: {
      session: {
        email: users(id).email,
        password: "password"
      }
    }
  end

  def sign_in_system_test
    visit sign_in_url
  
    assert_text "Sign in"

    fill_in "Email", with: users(:one).email
    fill_in "Password", with: "password"

    click_on "Sign in"

    assert_text "Recents"
    assert_text "Random"
  end

  def move_to_profile
    loop do
      find('#user-menu-button > div').click
      if has_xpath? '//*[@id="user-dropdown"]'
        break if find(:xpath, '//*[@id="user-dropdown"]').visible?
      end
    end
    click_on users(:one).name

    assert_text users(:one).name
    assert_text users(:one).artistic_name
    assert_text musics(:one).title
  end
end
