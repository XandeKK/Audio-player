require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  def setup
    sign_in_system_test
  end
  
  test "can play music" do
    find(:xpath, '//*[@id="playlist_body"]/div[1]/div[1]/div/div/div').click

    assert_text "00:00"
    assert_text "04:00"
    title = find(:xpath, '//*[@id="player-audio"]/div/div[1]/div/span[1]')
    assert_equal musics(:one).title, title.text 
    artistic_name = find(:xpath, '//*[@id="player-audio"]/div/div[1]/div/span[2]')
    assert_equal users(:one).artistic_name, artistic_name.text 
    sleep 1
    assert_text "00:01"
  end

  test "can play music and switch page without broken" do    
    find(:xpath, '//*[@id="playlist_body"]/div[1]/div[1]/div/div/div').click

    assert_text "00:00"
    assert_text "04:00"
    title = find(:xpath, '//*[@id="player-audio"]/div/div[1]/div/span[1]')
    assert_equal musics(:one).title, title.text 
    artistic_name = find(:xpath, '//*[@id="player-audio"]/div/div[1]/div/span[2]')
    assert_equal users(:one).artistic_name, artistic_name.text 
    sleep 1
    assert_text "00:01"

    find(:xpath, '//*[@id="player-audio"]/div/div[3]/div[4]').click
    sleep 1
    assert_text "00:01"

    find('#user-menu-button > div').click
    click_on users(:one).name

    find(:xpath, '//*[@id="player-audio"]/div/div[3]/div[4]').click
    sleep 1
    assert_text "00:02"
  end
end
