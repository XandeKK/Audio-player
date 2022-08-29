require "test_helper"

class MusicTest < ActiveSupport::TestCase
  def setup
    music = File.open("#{Rails.root}/test/fixtures/files/music/time-for-love.mp3")
    image_cover = File.open("#{Rails.root}/test/fixtures/files/image/time-for-love.jpg")

    @music = Music.new(title: "time for love")
    @music.music.attach(io: music, filename: 'time-for-love.mp3')
    @music.image_cover.attach(io: image_cover, filename: 'time-for-love.jpg')
  end

  test "should be valid" do
    assert @music.valid?
  end

  test "should save" do
    assert_difference("Music.count") do
      assert_difference("ActiveStorage::Attachment.count", 2) do
        assert @music.save
      end
    end
  end

  test "should not valid without title" do
    @music.title = nil
    assert @music.invalid?
  end

  test "should not valid without music" do
    @music.music.purge
    assert @music.invalid?
  end

  test "should not valid without image cover" do
    @music.image_cover.purge
    assert @music.invalid?
  end

  test "should update" do
    @music.save

    music_file = File.open("#{Rails.root}/test/fixtures/files/music/time-for-love.mp3")
    @music.music.attach(io: music_file, filename: 'time-for-love-2.mp3')

    image_file = File.open("#{Rails.root}/test/fixtures/files/image/time-for-love.jpg")
    @music.image_cover.attach(io: image_file, filename: 'time-for-love-2.jpg')

    assert @music.update(title: "IIDD")

    assert_equal "IIDD", @music.title
    assert_equal "time-for-love-2.mp3", @music.music.filename.to_s
    assert_equal "time-for-love-2.jpg", @music.image_cover.filename.to_s
  end

  test "should destroy" do
    @music.save

    assert_difference("Music.count", -1) do
      assert_difference("ActiveStorage::Attachment.count", -2) do
        assert @music.destroy
      end
    end
  end
  
end
