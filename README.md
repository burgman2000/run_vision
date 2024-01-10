# README
# テーブル設計

ランビション(RunVision)

## users テーブル

| Column                | Type     | Options     |
| ------------------    | ------   | ----------- |
| nickname              | string   | null: false |
| email                 | string   | null: false , unique: true |
| encrypted_password    | string   | null: false |


### Association
- has_many :events
- has_many :runnings







##  runnings  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user_id            | references| null: false , foreign_key: true |
| event_id           | references| null: false , foreign_key: true |
| ran_distance       | integer   | null: false           |
| ran_location       | text      | null: false           |
| impression         | text      | null: false |
| date               | date      | null: false |


### Association
- belongs_to :user
- belongs_to :event
- has_many :comments





##   comments   テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| user_id            | references| null: false, foreign_key: true |
| running_id         | references| null: false, foreign_key: true |
| text               | text      | null: false |
+----------------------------------------+

### Association
- belongs_to :user
- belongs_to :running





##  events  テーブル

| Column             | Type      | Options     |
| ------------------ | ------    | ----------- |
| event_name         | string    | null: false |
| target_distance    | integer   | null: false |
| start_date         | date      | null: false |
| end_date           | date      | null: false |
| commit             | text      | null: false |


### Association
- belongs_to :running
















This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
