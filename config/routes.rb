Rails.application.routes.draw do
  # ヘルスチェック
  get "up" => "rails/health#show", as: :rails_health_check

  # ─── 一般ユーザー向け（予約フロー） ──────────────────────
  # トップページはカレンダー（空き状況一覧）
  root "daily_slots#index"
  
  # ゲスト向け日別枠（カレンダー表示 + 日付別の空き確認）
  resources :daily_slots, only: [:index, :show]

  # ゲスト向け予約
  resources :reservations, only: [:new, :create, :show] do
    collection do
      post :confirm # 入力フォームからの送信を受け取り、確認画面を表示する
    end
    member do
      get :complete # 予約完了画面（/reservations/:id/complete）
    end
  end

  # ─── 管理者向け ────────────────────────────────────────
  # Deviseによる認証（URLを /manage/auth/... に変更してセキュリティ向上）
  devise_for :users, path: "manage/auth",
                     path_names: { sign_in: "login", sign_out: "logout" },
                     skip: [:registrations, :passwords, :confirmations, :unlocks]

  namespace :manage do
    # 管理画面トップページ
    root "dashboard#index"

    # 料金マスタの管理（削除は日別枠との紐づきがあるため除外）
    resources :prices, only: [:index, :show, :new, :create, :edit, :update]

    # 日別枠（カレンダー）の管理（園長が枠を追加・修正できるように権限拡大）
    resources :daily_slots, only: [:index, :show, :new, :create, :edit, :update]

    # 予約データの管理（代行入力を含む）
    resources :reservations, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        patch :update_status # キャンセルや来園済などのステータス変更用
      end
    end
  end
end