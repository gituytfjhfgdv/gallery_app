require "application_system_test_case"

class PhotosTest < ApplicationSystemTestCase
  setup do
    @user = users(:cat)
    @photo = photos(:one)
    visit login_url
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: 'password'
    click_on 'ログイン'
  end
  test 'visiting the index' do
    visit photos_url
    assert_selector 'h1', text: '写真一覧'
    assert_text '写真を新しくアップロードする'
    assert_text 'MyTweetAppと連携する'
    assert_text 'ログアウト'
    assert_text @photo.title
  end

  test 'create new photo' do
    visit photos_url
    click_on '写真を新しくアップロードする'

    fill_in 'photo_title', with: 'first photo'
    file_path = Rails.root.join('test', 'fixtures', 'images', 'dummy_photo.jpg')
    attach_file 'photo_image_file', file_path
    click_on 'アップロード'
    assert_selector 'h1', text: '写真一覧'
    assert_text 'first photo'
  end

  test 'fail to create new photo' do
    visit photos_url
    click_on '写真を新しくアップロードする'

    fill_in 'photo_title', with: ''
    click_on 'アップロード'
    assert_selector 'h1', text: '写真アップロード'
    assert_text 'タイトルを入力してください'
    assert_text '画像ファイルを入力してください'
  end

  test 'permit only logined user to photos_path' do
    visit photos_url
    click_on 'ログアウト'
    visit photos_url
    assert_text 'ログイン'
  end
  test 'permit only logined user to new_photo_path' do
    visit new_photo_url
    click_on 'ログアウト'
    visit new_photo_url
    assert_text 'ログイン'
  end
end
