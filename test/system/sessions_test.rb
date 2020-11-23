require 'application_system_test_case'
class SessionsTest < ApplicationSystemTestCase
  setup do
    @user = users(:cat)
  end
  test 'login with valid email and password' do
    visit login_path
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: 'password'
    click_on 'ログイン'

    assert_text '写真一覧'
  end
  test 'display errors with invalid email and password' do
    visit login_path
    fill_in 'session_email', with: 'aaaaaaa@a.email'
    fill_in 'session_password', with: 'aaaaaaaaaaa'
    click_on 'ログイン'

    assert_text '入力された情報で登録されたユーザが見つかりませんでした。'
  end
  test 'display errors with empty field' do
    visit login_path
    fill_in 'session_email', with: ''
    fill_in 'session_password', with: ''
    click_on 'ログイン'

    assert_text 'ユーザidを入力してください'
    assert_text 'パスワードを入力してください'
  end

  test 'logout from service' do
    visit login_path
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: 'password'
    click_on 'ログイン'

    assert_text 'ログアウト'
    click_on 'ログアウト'
    assert_text 'ログイン'
  end
end
