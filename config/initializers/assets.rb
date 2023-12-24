# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# 追加（swiper）
# 読み込みのrootディレクトリとして、node_modulesというディレクトリを追加する
# 通常は、import Swiper from "../../node_modules/swiper";と記載する必要があるが、
# import Swiper from "swiper";と記載すれば読み込めるようになる
Rails.application.config.assets.paths << Rails.root.join('node_modules')