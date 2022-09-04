require "test_helper"

class MusicsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @music = musics(:one)
  end

  test "should get new" do
    sign_in
    
    get new_music_path
    assert_response :success

    assert_select "h2", "New Song"
  end

  test "should get edit" do
    sign_in
    
    get edit_music_path(@music)
    assert_response :success

    assert_select "h2", "Edit Song"
  end

  test "should not get edit that belongs to the other" do
    sign_in_as(:two)
    
    get edit_music_path(@music)
    assert_response :redirect
  end

  test "should create music" do
    sign_in

    assert_difference("ActiveStorage::Attachment.count", 2) do
      assert_difference("Music.count") do
        assert_difference("Author.count", +2) do
          assert_difference("MusicCategory.count") do
            post musics_path, params: {
              music: {
                title: "time for love",
                image_cover: fixture_file_upload("time-for-love.jpg"),
                music: fixture_file_upload("time-for-love.mp3"),
                authors_attributes: [ {user_id: users(:two).id} ],
                music_categories_attributes: [ category_id: categories(:one).id ]
              }
            }
            assert_response :redirect
            follow_redirect!
            
            assert_select "h1", users(:one).name
            assert_select "h2", users(:one).artistic_name
          end
        end
      end
    end
  end

  test "should not create music without title" do
    sign_in
    
    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_no_difference("Music.count") do
        assert_no_difference("Author.count") do
          assert_no_difference("MusicCategory.count") do
            post musics_path, params: {
              music: {
                title: nil,
                image_cover: fixture_file_upload("time-for-love.jpg"),
                music: fixture_file_upload("time-for-love.mp3"),
                authors_attributes: [],
                music_categories_attributes: []
              }
            }
            assert_response :unprocessable_entity

            assert_select "h2", "New Song"
            assert_select "#music_title[value=?]", ""
          end
        end
      end
    end
  end

  test "should not create music without image cover" do
    sign_in
    
    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_no_difference("Music.count") do
        assert_no_difference("Author.count") do
          assert_no_difference("MusicCategory.count") do
            post musics_path, params: {
              music: {
                title: "time for love",
                # image_cover: nil,
                music: fixture_file_upload("time-for-love.mp3"),
                authors_attributes: [],
                music_categories_attributes: []
              }
            }
            assert_response :unprocessable_entity

            assert_select "h2", "New Song"
            assert_select "#music_title[value=?]", "time for love"
          end
        end
      end
    end
  end

  test "should not create music without music" do
    sign_in
    
    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_no_difference("Music.count") do
        assert_no_difference("Author.count") do
          assert_no_difference("MusicCategory.count") do
            post musics_path, params: {
              music: {
                title: "time for love",
                image_cover: fixture_file_upload("time-for-love.jpg"),
                # music: nil,
                authors_attributes: [],
                music_categories_attributes: []
              }
            }
            assert_response :unprocessable_entity

            assert_select "h2", "New Song"
            assert_select "#music_title[value=?]", "time for love"
          end
        end
      end
    end
  end

  test "should update" do
    sign_in

    music = musics(:one)

    assert_difference("ActiveStorage::Attachment.count", 0) do
      assert_difference("Author.count") do
        put music_path(music), params: {
          music: {
            title: "Green day",
            image_cover: fixture_file_upload("time-for-love.jpg"),
            music: fixture_file_upload("time-for-love.mp3"),
            authors_attributes: [ user_id: users(:two).id ],
            music_categories_attributes: []
          }
        }
        assert_response :redirect

        follow_redirect!
            
        assert_select "h1", users(:one).name
        assert_select "h2", users(:one).artistic_name
      end
    end
  end

  test "should not update without title" do
    sign_in

    music = musics(:one)

    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_no_difference("Author.count") do
        put music_path(music), params: {
          music: {
            title: nil,
            image_cover: fixture_file_upload("time-for-love.jpg"),
            music: fixture_file_upload("time-for-love.mp3"),
            authors_attributes: [ user_id: users(:two).id ],
            music_categories_attributes: []
          }
        }
        assert_response :unprocessable_entity

        assert_select "h2", "Edit Song"
        assert_select "#music_title[value=?]", ""
      end
    end
  end

  test "should update without image cover" do
    sign_in

    music = musics(:one)

    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_difference("Author.count", 1) do
        put music_path(music), params: {
          music: {
            title: "Green day",
            # image_cover: nil,
            music: fixture_file_upload("time-for-love.mp3"),
            authors_attributes: [ user_id: users(:two).id ],
            music_categories_attributes: []
          }
        }
        assert_response :redirect

        follow_redirect!
            
        assert_select "h1", users(:one).name
        assert_select "h2", users(:one).artistic_name
      end
    end
  end

  test "should update without music" do
    sign_in

    music = musics(:one)

    assert_no_difference("ActiveStorage::Attachment.count", 2) do
      assert_difference("Author.count", 1) do
        put music_path(music), params: {
          music: {
            title: "Green day",
            image_cover: fixture_file_upload("time-for-love.jpg"),
            # music: nil,
            authors_attributes: [ user_id: users(:two).id ],
            music_categories_attributes: []
          }
        }
        assert_response :redirect

        follow_redirect!
            
        assert_select "h1", users(:one).name
        assert_select "h2", users(:one).artistic_name
      end
    end
  end

  test "should destroy music" do
    sign_in

    assert_difference("Music.count", -1) do
      assert_difference("Author.count", -1) do
        assert_difference("MusicCategory.count", -1) do
          delete music_path(musics(:one))
          assert_response :redirect
        end
      end
    end
  end
end
